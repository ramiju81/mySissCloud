// mySiss Cloud - App utilities
const API_BASE = '/csp/mySissCloud/api';

function getSession() {
    if (window.mySissSession) return window.mySissSession.getSession();
    try { return JSON.parse(sessionStorage.getItem('mySiss_session') || 'null'); }
    catch (e) { return null; }
}

async function requireAuth() {
    if (window.mySissAuth) {
        try {
            const auth = await window.mySissAuth.verifySession();
            if (auth && auth.authenticated) return;
        } catch (e) {
            // continuar con redirect
        }
    }
    window.location.href = '/csp/mySissCloud/app/Login/mySiss_Cloud_Login.html';
}
