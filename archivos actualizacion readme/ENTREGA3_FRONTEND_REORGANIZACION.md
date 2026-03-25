# Entrega - Reorganización frontend

## 1) Qué se reorganizó
- Se centralizó frontend funcional dentro de `frontend/app/`.
- Se movió `WS` dentro de `app`.
- Se organizó login en estructura por vista/estilo/script sin perder funcionalidad.
- Se centralizó la capa de servicios frontend dentro de `app/services`.

## 2) Qué se movió o reubicó
- `frontend/WS` -> `frontend/app/WS`
- `frontend/services` -> `frontend/app/services`
- `frontend/mySiss_Cloud_Login.html` -> `frontend/app/Login/mySiss_Cloud_Login.html`
- Se creó un archivo puente en `frontend/mySiss_Cloud_Login.html` para redirección compatible.
- Se separó CSS/JS del login:
  - `frontend/app/Login/css/mySiss_Cloud_Login.css`
  - `frontend/app/Login/js/mySiss_Cloud_Login.js`

## 3) Qué no se tocó y por qué
- No se tocaron módulos de negocio (Honorarios/Auditoría/Glosas/Seguridad) más allá de rutas de acceso de login.
- No se modificaron archivos de referencia Excel/PDF: son soporte funcional/documental, no lógica activa.
- No se tocó `README.md`.

## 4) Cómo quedó organizado el frontend
- `frontend/app/`
  - `Login/` (HTML + CSS + JS)
  - `services/` (config/api/session/auth)
  - `WS/` (template/static)
  - `Seguridad/`, `Honorarios/`, `Auditoria/`, `Glosas/` (sin reescritura masiva)

## 5) Cómo probar que sigue funcionando
1. Abrir `/csp/mySissCloud/mySiss_Cloud_Login.html` y validar redirección automática a `/app/Login/mySiss_Cloud_Login.html`.
2. Probar login real (credenciales de BD) y navegación por rol.
3. Probar flujo forgot/validate/reset password desde login.
4. Abrir una plantilla WS (`/csp/mySissCloud/app/WS/template/mySissWSMaster.html`) y validar carga de CSS/JS.
5. Validar en consola que scripts cargan desde `/csp/mySissCloud/app/services/*.js` sin 404.
