(function () {
  async function getContext() {
    const resp = await window.mySissApi.get('/auth/context');
    return resp.data || {};
  }

  async function resolveRoute() {
    const resp = await window.mySissApi.get('/auth/resolve-route');
    return (resp.data && resp.data.route) || '/csp/mySissCloud/app/Login/mySiss_Cloud_Login.html';
  }

  async function authorizeModule(slug) {
    const resp = await window.mySissApi.get(`/auth/authorize-module/${encodeURIComponent(slug)}`);
    return resp;
  }

  window.mySissRouting = { getContext, resolveRoute, authorizeModule };
})();
