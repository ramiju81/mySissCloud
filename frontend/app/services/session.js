(function () {
  const SESSION_KEY = 'mySiss_session';

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
    sessionStorage.setItem('mySiss_remember_email', email);
  }

  function getRememberedEmail() {
    return sessionStorage.getItem('mySiss_remember_email') || '';
  }

  function clearRememberedEmail() {
    sessionStorage.removeItem('mySiss_remember_email');
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
