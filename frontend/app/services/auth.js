(function () {
  async function login(payload) {
    const data = await window.mySissApi.post('/login', payload);
    window.mySissSession.setSession(data);
    return data;
  }

  async function logout() {
    const data = await window.mySissApi.post('/logout', {});
    window.mySissSession.clearSession();
    return data;
  }

  async function verifySession() {
    return window.mySissApi.get('/verify-session');
  }

  async function forgotPassword(email) {
    return window.mySissApi.post('/forgot-password', { email });
  }

  async function validateToken(email, token) {
    return window.mySissApi.post('/validate-token', { email, token });
  }

  async function resetPassword(email, token, newPassword, confirmPassword) {
    return window.mySissApi.post('/reset-password', { email, token, newPassword, confirmPassword });
  }

  window.mySissAuth = { login, logout, verifySession, forgotPassword, validateToken, resetPassword };
})();
