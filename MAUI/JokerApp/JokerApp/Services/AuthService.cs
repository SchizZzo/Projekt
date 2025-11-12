using System.Net.Http.Json;
using System.Text.Json;
using System.Text.Json.Serialization;

public record LoginRequest(string email, string password);
public record TokenResponse([property: JsonPropertyName("access")] string Access,
                            [property: JsonPropertyName("refresh")] string? Refresh);
public record RegisterRequest(string username, string email, string password, string password_confirm);
public record RefreshRequest(string refresh);

public interface IAuthService
{
    Task<(bool ok, string? error)> LoginAsync(string email, string pass);
    Task<bool> RegisterAsync(string user, string email, string pass, string pass_confirm);
    Task LogoutAsync();
}

public class AuthService : IAuthService
{
    private readonly IHttpClientFactory _http;
    private readonly ITokenStore _tokens;
    private readonly JsonSerializerOptions _json = new(JsonSerializerDefaults.Web);

    private const string TokenPath = "api/login/";
    private const string RegisterPath = "api/register/"; //"auth/users/" // Djoser
    private const string RefreshPath = "api/token/refresh/"; // adjust if your backend uses a different path

    public AuthService(IHttpClientFactory http, ITokenStore tokens)
    {
        _http = http; _tokens = tokens;
    }

    HttpClient C => _http.CreateClient("Api");

    public async Task<(bool ok, string? error)> LoginAsync(string email, string pass)
    {
        var resp = await C.PostAsJsonAsync(TokenPath, new LoginRequest(email, pass), _json);
        if (!resp.IsSuccessStatusCode)
        {
            string body = string.Empty;
            try { body = await resp.Content.ReadAsStringAsync(); } catch { }
            var msg = !string.IsNullOrWhiteSpace(body) ? body : resp.ReasonPhrase;
            return (false, msg);
        }

        var data = await resp.Content.ReadFromJsonAsync<TokenResponse>(_json);
        if (data is null || string.IsNullOrWhiteSpace(data.Access))
            return (false, "Brak tokena w odpowiedzi serwera.");

        await _tokens.SetAsync(data.Access, data.Refresh);

        return (true, null);
    }

    private async Task<(bool ok, string? error)> TryRefreshAsync()
    {
        var refresh = await _tokens.GetRefreshAsync();
        if (string.IsNullOrWhiteSpace(refresh)) return (false, "Brak refresh tokena.");

        var resp = await C.PostAsJsonAsync(RefreshPath, new RefreshRequest(refresh), _json);
        if (!resp.IsSuccessStatusCode)
        {
            string body = string.Empty;
            try { body = await resp.Content.ReadAsStringAsync(); } catch { }
            await _tokens.ClearAsync();
            var msg = !string.IsNullOrWhiteSpace(body) ? body : resp.ReasonPhrase;
            return (false, msg);
        }

        var data = await resp.Content.ReadFromJsonAsync<TokenResponse>(_json);
        if (data is null || string.IsNullOrWhiteSpace(data.Access))
        {
            await _tokens.ClearAsync();
            return (false, "Brak tokena po odświeżeniu.");
        }

        await _tokens.SetAsync(data.Access, data.Refresh);
        return (true, null);
    }

    public async Task<bool> RegisterAsync(string user, string email, string pass, string pass_confirm)
    {
        var resp = await C.PostAsJsonAsync(RegisterPath, new RegisterRequest(user, email, pass, pass_confirm), _json);
        return resp.IsSuccessStatusCode;
    }

    public Task LogoutAsync() => _tokens.ClearAsync();
}
