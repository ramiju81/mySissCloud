let recoveryEmail = "";
let recoveryToken = "";

async function resolvePostLoginRoute() {
    if (window.mySissRouting && window.mySissRouting.resolveRoute) {
        return window.mySissRouting.resolveRoute();
    }
    const resp = await window.mySissApi.get('/auth/resolve-route');
    return (resp.data && resp.data.route) || '/csp/mySissCloud/mysiss_cloud.html';
}

async function login() {
    const usuario = document.getElementById("usuario").value.trim();
    const password = document.getElementById("password").value;
    const rememberMe = document.getElementById("rememberMe").checked;
    const mensaje = document.getElementById("mensaje");
    mensaje.textContent = "";

    if (!usuario || !password) {
        mensaje.textContent = "Usuario/email y contraseña son obligatorios.";
        return;
    }

    try {
        await window.mySissAuth.login({ username: usuario, email: usuario, password, rememberMe });
        if (rememberMe) window.mySissSession.rememberEmail(usuario); else window.mySissSession.clearRememberedEmail();
        document.getElementById("password").value = "";
        const route = await resolvePostLoginRoute();
        window.location.href = route;
    } catch (error) {
        mensaje.textContent = (error.payload && error.payload.error) ? error.payload.error : "Error de autenticación.";
        document.getElementById("password").value = "";
    }
}

function openRecoveryModal() { document.getElementById("recoveryModal").style.display = "block"; }
function closeRecoveryModal() {
    document.getElementById("recoveryModal").style.display = "none";
    document.getElementById("recoveryInput").value = "";
    document.getElementById("recoveryMessage").textContent = "";
}
function openTokenModal() { document.getElementById("tokenModal").style.display = "block"; }
function closeTokenModal() {
    document.getElementById("tokenModal").style.display = "none";
    document.getElementById("tokenInput").value = "";
    document.getElementById("tokenMessage").textContent = "";
}
function openResetModal() { document.getElementById("resetModal").style.display = "block"; }
function closeResetModal() {
    document.getElementById("resetModal").style.display = "none";
    document.getElementById("newPasswordInput").value = "";
    document.getElementById("confirmPasswordInput").value = "";
    document.getElementById("resetMessage").textContent = "";
}

async function sendRecoveryEmail() {
    const email = document.getElementById("recoveryInput").value.trim();
    const message = document.getElementById("recoveryMessage");
    message.textContent = "";
    if (!email) { message.textContent = "Ingresa el correo."; return; }

    try {
        await window.mySissAuth.forgotPassword(email);
        recoveryEmail = email;
        message.style.color = "green";
        message.textContent = "Solicitud recibida. Revisa tu correo y valida el token.";
        setTimeout(() => { closeRecoveryModal(); openTokenModal(); }, 700);
    } catch (error) {
        message.style.color = "red";
        message.textContent = (error.payload && error.payload.error) ? error.payload.error : "No fue posible iniciar recuperación.";
    }
}

async function validateTokenStep() {
    const token = document.getElementById("tokenInput").value.trim();
    const message = document.getElementById("tokenMessage");
    if (!token) { message.textContent = "Ingresa el token."; return; }

    try {
        await window.mySissAuth.validateToken(recoveryEmail, token);
        recoveryToken = token;
        closeTokenModal();
        openResetModal();
    } catch (error) {
        message.textContent = (error.payload && error.payload.error) ? error.payload.error : "Token inválido.";
    }
}

async function resetPasswordStep() {
    const newPassword = document.getElementById("newPasswordInput").value;
    const confirmPassword = document.getElementById("confirmPasswordInput").value;
    const message = document.getElementById("resetMessage");
    message.textContent = "";

    if (!newPassword || !confirmPassword) { message.textContent = "Completa ambos campos."; return; }

    try {
        await window.mySissAuth.resetPassword(recoveryEmail, recoveryToken, newPassword, confirmPassword);
        message.style.color = "green";
        message.textContent = "Contraseña actualizada correctamente.";
        setTimeout(() => {
            closeResetModal();
            recoveryEmail = "";
            recoveryToken = "";
        }, 900);
    } catch (error) {
        message.style.color = "red";
        message.textContent = (error.payload && error.payload.error) ? error.payload.error : "No fue posible actualizar contraseña.";
    }
}

document.getElementById("usuario").addEventListener("keypress", function(event) {
    if (event.key === "Enter") { event.preventDefault(); login(); }
});
document.getElementById("password").addEventListener("keypress", function(event) {
    if (event.key === "Enter") { event.preventDefault(); login(); }
});

window.addEventListener("DOMContentLoaded", async function () {
    const remembered = window.mySissSession.getRememberedEmail();
    if (remembered) {
        document.getElementById("usuario").value = remembered;
        document.getElementById("rememberMe").checked = true;
    }
    try {
        const active = await window.mySissAuth.verifySession();
        if (active && active.authenticated) {
            const route = await resolvePostLoginRoute();
            window.location.href = route;
        }
    } catch (e) {
        // sin sesión
    }
});
