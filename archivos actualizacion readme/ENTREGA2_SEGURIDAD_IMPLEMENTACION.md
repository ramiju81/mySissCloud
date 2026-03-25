# Entrega 2 - Implementación seguridad base

## 1) Qué se implementó
- API de seguridad en backend IRIS:
  - `POST /login`
  - `POST /logout`
  - `GET /verify-session`
  - `POST /forgot-password`
  - `POST /validate-token`
  - `POST /reset-password`
- Login real con:
  - validación de usuario activo/bloqueado,
  - validación de contraseña con hash+salt,
  - control de intentos fallidos y bloqueo,
  - sesión con timeout configurable.
- Recuperación real con token:
  - creación de token temporal,
  - persistencia en tabla de tokens,
  - validación de token,
  - reset de contraseña con política configurable e invalidación de token.
- Frontend login conectado al backend real (sin hardcoded de usuarios/clave) y preparado para capa común `services/`.

## 2) Archivos tocados
- `src/mySiss/conn/API.cls`
- `frontend/mySiss_Cloud_Login.html`
- `frontend/app.js`
- `frontend/services/config.js`
- `frontend/services/api.js`
- `frontend/services/session.js`
- `frontend/services/auth.js`

## 3) Pendiente para WebService / mySiss / módulos funcionales
- Integración real de envío de correo (actualmente punto desacoplado listo para enchufar proveedor).
- Parametría global `mySiss` para CORS/orígenes y configuraciones técnicas transversales de WebService.
- Migración progresiva de pantallas de módulos funcionales para consumir `frontend/services/*` y dejar de depender de localStorage de negocio.
- RBAC fino por endpoint funcional (seguridad base quedó lista, falta extender por dominio).

## 4) Cómo probar el flujo
1. Iniciar IRIS y ejecutar inicialización (`manage.sh init`).
2. Abrir `http://localhost:52773/csp/mySissCloud/mySiss_Cloud_Login.html`.
3. Login:
   - usar credenciales de usuario existente en `mySiss_SEGUsuario`.
   - validar respuestas de error por usuario inactivo/bloqueado/clave errada.
4. Recuperación:
   - abrir “Olvidaste contraseña”, ingresar email registrado.
   - validar token (`/validate-token`).
   - actualizar contraseña (`/reset-password`).
5. Sesión:
   - verificar estado con `/verify-session`.
   - cerrar sesión con `/logout`.
