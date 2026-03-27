# ENTREGA 6 - Base de ecosistema (mySiss)

## Qué se implementó
- Persistencia de configuración global del sistema (`SystemConfig`) con campos de entorno, motor de BD, URLs y estado de conexión.
- Servicio y API REST para:
  - `GET /system/health`
  - `GET /system/config`
  - `POST /system/config`
  - `PUT /system/config`
  - `GET /system/database/status`
- Endpoints base para clientes y módulos por cliente:
  - `GET/POST/PUT /ms/clients`
  - `PUT /ms/clients/:id/status`
  - `GET/PUT /ms/clients/:id/modules`
  - `GET /ms/modules/catalog`
- Reglas de acceso:
  - Superusuario (`SUPERUSER_USERNAME`, por defecto `ramiju`) puede editar configuración global.
  - Administrador (`ADMIN_USERNAME`) puede administrar clientes y asignaciones, pero no configuración sensible.
- Base frontend `mySiss` para visualizar estado, configuración global, lista de clientes y catálogo de módulos.

## Qué quedó preparado
- Soporte de entorno configurable (`MYSISS_ENV`) y motor (`MYSISS_DB_ENGINE`) para distinguir IRIS/SQLite.
- Validación de estado de BD y persistencia del último chequeo.
- Estructura persistente cliente ↔ módulos sin datos iniciales ni asignaciones quemadas.
- Catálogo de módulos desde `SG_Modulo` excluyendo `WebService` como módulo funcional.

## Cómo probar
1. Configurar `.env` (incluye `SQLITE_DB_PATH`, `SUPERUSER_USERNAME`, `SUPERUSER_PASSWORD`, `ADMIN_USERNAME`, `ADMIN_PASSWORD`).
2. Compilar clases con `bash manage.sh compile`.
3. Probar endpoints desde sesión autenticada:
   - `GET /csp/mySissCloud/api/system/health`
   - `GET /csp/mySissCloud/api/system/config`
   - `PUT /csp/mySissCloud/api/system/config`
   - `GET /csp/mySissCloud/api/ms/clients`
4. Abrir base frontend:
   - `/csp/mySissCloud/app/mySiss/system_base.html`
