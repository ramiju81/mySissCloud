(function () {
  async function requireModuleAccess(slug) {
    try {
      const auth = await window.mySissRouting.authorizeModule(slug);
      if (!auth.allowed) {
        window.location.replace((auth && auth.redirect) || '/csp/mySissCloud/mysiss_cloud.html?state=no-access');
      }
    } catch (error) {
      const redirect = (error.payload && error.payload.redirect) || '/csp/mySissCloud/app/Login/mySiss_Cloud_Login.html';
      window.location.replace(redirect);
    }
  }

  window.mySissModuleGuard = { requireModuleAccess };
})();
