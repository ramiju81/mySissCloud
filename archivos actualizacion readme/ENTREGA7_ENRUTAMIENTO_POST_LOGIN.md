# ENTREGA 7 - Enrutamiento real post-login

## Flujo post-login
1. Login/verify-session exitoso.
2. Frontend consulta `GET /auth/resolve-route`.
3. Backend resuelve contexto real (`username`, tipo de usuario, cliente, módulos habilitados, estado de sesión).
4. Backend responde ruta final:
   - superusuario/admin -> dashboard (`mysiss_cloud.html`)
   - usuario normal con 1 módulo -> módulo directo
   - usuario normal con >1 módulo -> dashboard
   - usuario normal sin módulos -> dashboard con estado controlado

## Determinación de acceso
- Fuente de verdad: backend (`mySiss.API.SystemService`).
- Tipo de usuario:
  - superusuario: `SUPERUSER_USERNAME` (ramiju)
  - administrador: `ADMIN_USERNAME` (.env)
  - normal: resto de usuarios autenticados
- Cliente del usuario: `SG_User.ID_Cliente`.
- Módulos habilitados: `MS_ClienteMod` por cliente + catálogo real `SG_Modulo` (excluye WebService funcional).

## Usuario único / múltiples / sin módulos
- 1 módulo: redirección directa al `entry_path` del módulo.
- múltiples módulos: entra a `mysiss_cloud.html` y solo ve tarjetas permitidas.
- sin módulos: entra a `mysiss_cloud.html?state=no-modules` con mensaje controlado.

## Protección de módulos
- Se agregó guard en páginas principales de módulo, validando backend `GET /auth/authorize-module/:slug`.
- Sin sesión o sin permiso: redirección controlada a login/dashboard sin loops.

## Archivos tocados
- `src/mySiss/API/SystemService.cls`
- `src/mySiss/API/SystemREST.cls`
- `frontend/app/Login/mysiss_cloud.html`
- `frontend/app/assets/js/mySiss_Cloud_Login.js`
- `frontend/app/services/routing.js`
- `frontend/app/services/module-guard.js`
- `frontend/app/Auditoria/Auditoria.html`
- `frontend/app/Honorarios/honorarios.html`
- `frontend/app/Glosas/radicacion.html`
- `frontend/app/Seguridad/seg_gestion_usuario.html`
- `frontend/app/mySiss/system_base.html`

## Cómo probar
1. Compilar clases: `bash manage.sh compile`.
2. Login con superusuario/admin/usuario normal.
3. Verificar redirección post-login según perfil.
4. Abrir URL directa de módulo sin permiso y confirmar bloqueo controlado.
5. Verificar dashboard con módulos filtrados por backend.
