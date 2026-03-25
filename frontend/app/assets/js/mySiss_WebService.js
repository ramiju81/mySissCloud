// mySiss WebService - JavaScript utilities
const API_BASE = '/csp/mySissCloud/api';

async function apiCall(endpoint, method='GET', body=null) {
    const opts = { method, headers: { 'Content-Type': 'application/json' } };
    if (body) opts.body = JSON.stringify(body);
    try {
        const res  = await fetch(API_BASE + endpoint, opts);
        return await res.json();
    } catch(e) {
        console.error('API error:', e);
        return { ok: false, error: 'Error de conexión' };
    }
}
