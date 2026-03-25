(function () {
  const SESSION_KEY = 'mySiss_session';
  const REMEMBER_KEY = 'mySiss_remember_email';

  function setSession(sessionData) {
    sessionStorage.setItem(SESSION_KEY, JSON.stringify(sessionData || {}));
  }

  function getSession() {
    try { return JSON.parse(sessionStorage.getItem(SESSION_KEY) || 'null'); }
    catch (e) { return null; }
  }

  function clearSession() {
    sessionStorage.removeItem(SESSION_KEY);
  }

  function rememberEmail(email) {
    if (!email) return;
    localStorage.setItem(REMEMBER_KEY, email);
  }

  function getRememberedEmail() {
    return localStorage.getItem(REMEMBER_KEY) || '';
  }

  function clearRememberedEmail() {
    localStorage.removeItem(REMEMBER_KEY);
  }

  window.mySissSession = {
    setSession,
    getSession,
    clearSession,
    rememberEmail,
    getRememberedEmail,
    clearRememberedEmail
  };
})();
