using Microsoft.Maui.Storage;

public interface ITokenStore
{
    Task SetAsync(string access, string? refresh);
    Task<string?> GetAccessAsync();
    Task<string?> GetRefreshAsync();
    Task ClearAsync();
}

public class SecureStorageTokenStore : ITokenStore
{
    public Task<string?> GetAccessAsync() => SecureStorage.GetAsync("jwt_access");
    public Task<string?> GetRefreshAsync() => SecureStorage.GetAsync("jwt_refresh");

    public async Task SetAsync(string access, string? refresh)
    {
        await SecureStorage.SetAsync("jwt_access", access);
        if (!string.IsNullOrWhiteSpace(refresh))
            await SecureStorage.SetAsync("jwt_refresh", refresh);
    }

    public async Task ClearAsync()
    {
        SecureStorage.Remove("jwt_access");
        SecureStorage.Remove("jwt_refresh");
        await Task.CompletedTask;
    }
}
