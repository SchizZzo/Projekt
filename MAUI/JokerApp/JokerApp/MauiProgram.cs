using Microsoft.AspNetCore.Components.WebView.Maui;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Maui.Controls.Hosting;
using Microsoft.Maui.Hosting;
using System.Net.Http.Headers;
using System.Text.Json;
using System.Text;

namespace JokerApp;

public class AuthHandler : DelegatingHandler
{
    private readonly ITokenStore _tokens;
    private readonly IHttpClientFactory _httpFactory;
    private const string RefreshPath = "api/token/refresh/"; // adjust to your backend if different

    public AuthHandler(ITokenStore tokens, IHttpClientFactory httpFactory)
    {
        _tokens = tokens;
        _httpFactory = httpFactory;
    }

    protected override async Task<HttpResponseMessage> SendAsync(HttpRequestMessage req, CancellationToken ct)
    {
        // Skip adding Authorization header for token endpoints (login/register/refresh)
        if (req.RequestUri != null)
        {
            var path = req.RequestUri.AbsolutePath?.ToLowerInvariant() ?? string.Empty;
            if (path.Contains("/api/login") || path.Contains("/api/register") || path.Contains("/api/token/refresh"))
            {
                return await base.SendAsync(req, ct);
            }
        }

        var access = await _tokens.GetAccessAsync();
        if (!string.IsNullOrWhiteSpace(access))
            req.Headers.Authorization = new AuthenticationHeaderValue("Bearer", access);

        var resp = await base.SendAsync(req, ct);

        if (resp.StatusCode != System.Net.HttpStatusCode.Unauthorized)
            return resp;

        // Attempt refresh
        var refresh = await _tokens.GetRefreshAsync();
        if (string.IsNullOrWhiteSpace(refresh))
        {
            await _tokens.ClearAsync();
            return resp;
        }

        try
        {
            var client = _httpFactory.CreateClient("ApiNoAuth");
            var payload = JsonSerializer.Serialize(new { refresh });
            using var content = new StringContent(payload, Encoding.UTF8, "application/json");
            var refreshResp = await client.PostAsync(RefreshPath, content, ct);
            if (!refreshResp.IsSuccessStatusCode)
            {
                await _tokens.ClearAsync();
                return resp; // original 401
            }

            // Read tokens from response (expecting { access: "...", refresh: "..." } or at least access)
            var doc = await JsonDocument.ParseAsync(await refreshResp.Content.ReadAsStreamAsync(ct), cancellationToken: ct);
            if (!doc.RootElement.TryGetProperty("access", out var accessEl))
            {
                await _tokens.ClearAsync();
                return resp;
            }

            var newAccess = accessEl.GetString();
            string? newRefresh = null;
            if (doc.RootElement.TryGetProperty("refresh", out var refreshEl))
                newRefresh = refreshEl.GetString();

            if (string.IsNullOrWhiteSpace(newAccess))
            {
                await _tokens.ClearAsync();
                return resp;
            }

            await _tokens.SetAsync(newAccess, newRefresh);

            // Retry original request with new access token
            using var newReq = await CloneHttpRequestMessageAsync(req);
            newReq.Headers.Authorization = new AuthenticationHeaderValue("Bearer", newAccess);
            var retryResp = await base.SendAsync(newReq, ct);
            return retryResp;
        }
        catch
        {
            await _tokens.ClearAsync();
            return resp;
        }
    }

    private static async Task<HttpRequestMessage> CloneHttpRequestMessageAsync(HttpRequestMessage req)
    {
        var clone = new HttpRequestMessage(req.Method, req.RequestUri)
        {
            Version = req.Version
        };

        // Copy the content (if any)
        if (req.Content != null)
        {
            var ms = new MemoryStream();
            await req.Content.CopyToAsync(ms);
            ms.Position = 0;
            clone.Content = new StreamContent(ms);

            // Copy content headers
            if (req.Content.Headers != null)
            {
                foreach (var h in req.Content.Headers)
                    clone.Content.Headers.TryAddWithoutValidation(h.Key, h.Value);
            }
        }

        // Copy the request headers
        foreach (var header in req.Headers)
            clone.Headers.TryAddWithoutValidation(header.Key, header.Value);

        // Copy properties
        foreach (var prop in req.Options)
        {
            // HttpRequestMessage.Options is readonly collection-like; copying options isn't necessary for typical scenarios
        }

        return clone;
    }
}

public static class MauiProgram
{
    public static MauiApp CreateMauiApp()
    {
        var builder = MauiApp.CreateBuilder()
            .UseMauiApp<App>()
            .ConfigureFonts(f => f.AddFont("OpenSans-Regular.ttf", "OpenSansRegular"));

        builder.Services.AddMauiBlazorWebView();
#if DEBUG
        builder.Services.AddBlazorWebViewDeveloperTools();
#endif

        // 🔗 Adres Twojego Django backendu
        var apiBase = "http://localhost/";

        builder.Services.AddSingleton<ITokenStore, SecureStorageTokenStore>();
        builder.Services.AddTransient<AuthHandler>();

        // Register a base client without AuthHandler for login/refresh calls
        builder.Services.AddHttpClient("ApiNoAuth", c => c.BaseAddress = new Uri(apiBase));
        // Register the main API client that includes the AuthHandler
        builder.Services.AddHttpClient("Api", c => c.BaseAddress = new Uri(apiBase))
                        .AddHttpMessageHandler<AuthHandler>();

        builder.Services.AddScoped<IAuthService, AuthService>();

        return builder.Build();
    }
}
