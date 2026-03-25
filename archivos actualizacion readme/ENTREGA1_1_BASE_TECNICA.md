# ENTREGA 1.1 — Base técnica ejecutable

Supuesto estándar declarado: el backend de seguridad inicial se implementará sobre la API IRIS existente (`/csp/mySissCloud/api`) y se extenderá solo con endpoints de seguridad faltantes.

## 1. Mapa de reutilización

| Módulo | Reutilizable directo | Requiere ajuste | Requiere intervención |
|---|---|---|---|
| Seguridad | `frontend/app/Seguridad/*.html` (UI base) | Adaptar consumo a capa `services/` y unificar navegación | Login hardcoded en `frontend/mySiss_Cloud_Login.html`; recuperación simulada |
| Honorarios | Pantallas de captura/validación/reportes existentes en `frontend/app/Honorarios/` | Normalizar rutas/case (`honorarios.html` vs `Honorarios.html`) | Remover dependencia de sesión local para permisos reales |
| Auditoría | Pantallas existentes en `frontend/app/Auditoria/` | Encapsular persistencia local en servicios por pantalla | Resolver duplicación `frontend/app/Auditoria/Auditoria/...`; migrar lógica de negocio fuera de HTML |
| Glosas | Pantallas existentes en `frontend/app/Glosas/` | Encapsular acceso a datos en servicios | Reducir datos seed/localStorage como fuente de verdad de negocio |

## 2. Estructura de servicios frontend

Estructura mínima propuesta (sin romper lo actual):

```text
/frontend/services/
  config.js
  api.js
  session.js
  auth.js
```

Propósito por archivo:
- `config.js`: origen API, timeouts y flags de entorno frontend.
- `api.js`: cliente HTTP único (`get/post/put/delete`) con manejo estándar de errores.
- `session.js`: lectura/escritura de sesión de UI y utilidades `isAuthenticated`/`clearSession`.
- `auth.js`: operaciones de seguridad (login/logout/verify/forgot/validate/reset) usando `api.js`.

Reglas obligatorias:
- Ningún módulo debe consumir `fetch` directo después de esta base.
- Todo request HTTP pasa por `api.js`.
- `auth.js` no accede storage directo; usa `session.js`.

## 3. Contrato API mínimo

Base path sugerido: `/csp/mySissCloud/api`.

### 3.1 POST `/login`
- Request JSON:
```json
{ "email": "user@dominio.com", "password": "******", "rememberMe": false }
```
- Response 200 JSON:
```json
{ "success": 1, "user": { "id": 1, "email": "user@dominio.com", "fullName": "Nombre Apellido", "roles": ["SUPERADMIN"] }, "session": { "authenticated": true, "expiresInMin": 30 } }
```
- Errores: `400` payload inválido, `401` credenciales inválidas, `423` usuario bloqueado, `500` error interno.

### 3.2 POST `/logout`
- Request JSON:
```json
{}
```
- Response 200 JSON:
```json
{ "success": 1, "message": "Sesion cerrada" }
```
- Errores: `401` no autenticado, `500` error interno.

### 3.3 GET `/verify-session`
- Request: sin body.
- Response 200 JSON:
```json
{ "authenticated": true, "user": { "id": 1, "email": "user@dominio.com", "fullName": "Nombre Apellido", "roles": ["SUPERADMIN"] } }
```
- Errores: `401` sesión inválida/expirada, `500` error interno.

### 3.4 POST `/forgot-password`
- Request JSON:
```json
{ "email": "user@dominio.com" }
```
- Response 200 JSON (sin filtrar existencia):
```json
{ "success": 1, "message": "Si el correo existe, se enviara un token", "cooldownSec": 60 }
```
- Errores: `400` email inválido, `429` demasiadas solicitudes, `500` error interno.

### 3.5 POST `/validate-token`
- Request JSON:
```json
{ "email": "user@dominio.com", "token": "123456" }
```
- Response 200 JSON:
```json
{ "success": 1, "tokenValid": true, "tokenRef": "tok_ref_temporal", "expiresInSec": 300 }
```
- Errores: `400` formato inválido, `401` token inválido/expirado, `429` intentos excedidos, `500` error interno.

### 3.6 POST `/reset-password`
- Request JSON:
```json
{ "email": "user@dominio.com", "tokenRef": "tok_ref_temporal", "newPassword": "NuevaClaveSegura!", "confirmPassword": "NuevaClaveSegura!" }
```
- Response 200 JSON:
```json
{ "success": 1, "message": "Contrasena actualizada" }
```
- Errores: `400` payload/política inválida, `401` tokenRef inválido/expirado, `409` password reutilizada, `500` error interno.

## 4. Modelo base de seguridad

Tablas base (alineadas al repo actual):

1) `mySiss_SEGUsuario` (credenciales y estado usuario)
- Campos clave: `SEGUsuId`, `SEGUsuLogin`, `SEGUsuCorreo`, `SEGUsuPasswordHash`, `SEGUsuSalt`, `SEGUsuEstado`, `SEGUsuIntentosFallidos`, `SEGUsuFechaBloqueo`, `SEGUsuFechaUltimoAcceso`, `SEGUsuTipoUsuario`.

2) `mySiss_SEGUsuarioRol` (asignación de rol)
- Campos clave: `SEGUsuRolUsuId`, `SEGUsuRolRolId`, `SEGUsuRolEstado`.

3) `mySiss_SEGRol` (catálogo de roles)
- Campos clave: `SEGRolId`, `SEGRolNombre`, `SEGRolEstado`.

4) `mySiss_SEGTokenRecuperacion` (token de recuperación)
- Campos clave: `SEGTokId`, `SEGTokUsuId`, `SEGTokToken`, `SEGTokFechaCreacion`, `SEGTokFechaExpiracion`, `SEGTokUsado`, `SEGTokIpSolicitud`.

5) `mySiss_SEGParametro` (políticas configurables)
- Campos clave: `SEGParamClave`, `SEGParamValor`, `SEGParamDescripcion`.

6) `mySiss_SEGAuditoriaAcceso` (traza de seguridad)
- Campos clave: `SEGAudAccId`, `SEGAudAccUsuId`, `SEGAudAccTipo`, `SEGAudAccFecha`, `SEGAudAccIp`, `SEGAudAccDetalle`.

Relaciones básicas:
- `SEGUsuario(1) -> (N) SEGUsuarioRol`.
- `SEGRol(1) -> (N) SEGUsuarioRol`.
- `SEGUsuario(1) -> (N) SEGTokenRecuperacion`.
- `SEGUsuario(1) -> (N) SEGAuditoriaAcceso`.

## 5. Flujo de login y recuperación

### 5.1 Login (email + password)
1. Input: `email`, `password`, `rememberMe`.
2. Validación frontend: formato email, no vacíos.
3. Backend valida usuario activo/no bloqueado.
4. Backend valida contraseña (hash).
5. Output éxito: sesión autenticada + datos mínimos de usuario/roles.
6. Output error: `401` credenciales, `423` bloqueado.

### 5.2 Recuperación por token (flujo exacto solicitado)
1. Usuario ingresa `email`.
   - Input: `email`.
   - Output: mensaje neutro (`success=1`).
   - Validaciones: formato email, rate-limit.
2. Sistema valida existencia.
   - Backend interno; no revelar si existe.
3. Sistema genera token.
   - Token numérico/alfanumérico corto + expiración.
4. Sistema envía token por correo.
   - Registro en auditoría.
5. Popup ingreso token.
   - Input: `email`, `token`.
6. Validación de token.
   - Output éxito: `tokenRef` temporal.
   - Validaciones: expiración, no usado, intentos.
7. Popup nueva contraseña.
   - Input: `newPassword`, `confirmPassword`.
8. Validación contra política.
   - Backend consulta `SEGParametro`.
9. Actualización de contraseña.
   - Guardar hash+salt, invalidar token, reset intentos, auditar evento.

## 6. Política de contraseñas

Parámetros configurables:
- `PASSWORD_MIN_LENGTH`
- `PASSWORD_REQUIRE_UPPER`
- `PASSWORD_REQUIRE_LOWER`
- `PASSWORD_REQUIRE_NUMBER`
- `PASSWORD_REQUIRE_SPECIAL`
- `PASSWORD_EXPIRATION_DAYS` (nuevo requerido)
- `PASSWORD_HISTORY_COUNT` (nuevo requerido)
- `MAX_INTENTOS_FALLIDOS`

Dónde vivirán:
- Tabla `mySiss_SEGParametro`.

Consumo:
- Backend: validación obligatoria en `login`/`reset-password`.
- Frontend: validación preliminar UX (sin reemplazar validación backend).

## 7. Orden de implementación

Orden obligatorio aplicado:

1) Seguridad
- Implementar `services/` base + endpoints seguridad faltantes (`forgot-password`, `validate-token`, `reset-password`).
- Dependencia: ninguna.

2) WebService (base técnica)
- Estandarizar cliente API común y manejo de errores/sesión para consumo transversal.
- Dependencia: Seguridad lista (contrato base estable).

3) Honorarios
- Migrar primero consumo a `services/api.js` y remover accesos directos.
- Dependencia: base técnica WebService.

4) Auditoría (submódulos)
- Unificar rutas activas, eliminar consumo directo/local progresivamente y consolidar árbol duplicado.
- Dependencia: base técnica + patrón aplicado en Honorarios.

5) Glosas
- Migrar persistencia local de negocio a servicios API por lotes de pantallas.
- Dependencia: patrón estable en Auditoría/Honorarios.
