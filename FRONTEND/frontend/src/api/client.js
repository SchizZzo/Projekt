export const API_HOST = 'http://localhost';

const buildHeaders = (headers = {}, useAuth = true) => {
  const builtHeaders = new Headers(headers);
  builtHeaders.set('Content-Type', 'application/json');

  if (useAuth) {
    const accessToken = localStorage.getItem('accessToken');
    if (accessToken) {
      builtHeaders.set('Authorization', `Bearer ${accessToken}`);
    }
  }

  return builtHeaders;
};

export const apiRequest = async (path, options = {}, { useAuth = true } = {}) => {
  const headers = buildHeaders(options.headers, useAuth);
  const response = await fetch(`${API_HOST}${path}`, { ...options, headers });
  return response;
};
