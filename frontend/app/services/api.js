(function () {
  async function request(path, options = {}) {
    const base = (window.mySissConfig && window.mySissConfig.apiBase) || '/csp/mySissCloud/api';
    const url = `${base}${path}`;
    const resp = await fetch(url, {
      credentials: 'include',
      headers: { 'Content-Type': 'application/json', ...(options.headers || {}) },
      ...options
    });

    let data = {};
    try { data = await resp.json(); } catch (e) { data = { success: 0, error: 'Respuesta invalida' }; }

    if (!resp.ok || data.success === 0 || data.authenticated === 0) {
      const err = new Error(data.error || `HTTP ${resp.status}`);
      err.status = resp.status;
      err.payload = data;
      throw err;
    }
    return data;
  }

  window.mySissApi = {
    get: (path) => request(path, { method: 'GET' }),
    post: (path, body) => request(path, { method: 'POST', body: JSON.stringify(body || {}) }),
    put: (path, body) => request(path, { method: 'PUT', body: JSON.stringify(body || {}) })
  };
})();
