// Services/BrowserTokenStore.cs
using Microsoft.JSInterop;

public interface ITokenStoreWeb
{
    Task SetAsync(string access, string? refresh);
    Task<string?> GetAccessAsync();
    Task<string?> GetRefreshAsync();
    Task ClearAsync();
}

public class BrowserTokenStore : ITokenStore
{
    private readonly IJSRuntime _js;
    public BrowserTokenStore(IJSRuntime js) => _js = js;
    public Task<string?> GetAccessAsync() => _js.InvokeAsync<string?>("localStorage.getItem", "jwt_access").AsTask();
    public Task<string?> GetRefreshAsync() => _js.InvokeAsync<string?>("localStorage.getItem", "jwt_refresh").AsTask();
    public async Task SetAsync(string access, string? refresh)
    {
        await _js.InvokeVoidAsync("localStorage.setItem", "jwt_access", access);
        if (!string.IsNullOrWhiteSpace(refresh))
            await _js.InvokeVoidAsync("localStorage.setItem", "jwt_refresh", refresh);
    }
    public async Task ClearAsync()
    {
        await _js.InvokeVoidAsync("localStorage.removeItem", "jwt_access");
        await _js.InvokeVoidAsync("localStorage.removeItem", "jwt_refresh");
    }
}
