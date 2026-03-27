# ENTREGA 8 - Seguridad administrativa real

## Qué se implementó
- Backend real para administración de seguridad:
  - usuarios (`/security/users`)
  - roles (`/security/roles`)
  - permisos por rol (`/security/roles/:id/permissions`)
  - catálogos de clientes y módulos (`/security/catalog/*`)
- Validaciones de negocio:
  - no duplicar username
  - no duplicar nombre de rol
  - solo superusuario/administrador pueden administrar seguridad
  - activación/inactivación de usuarios y roles
  - asociación usuario→cliente y usuario→rol persistida en backend
- Persistencia nueva para estado de roles: `mySiss.Config.SG.RolStatus`.

## Qué quedó conectado
- Login/sesión/enrutamiento existentes se mantienen.
- Superusuario (`ramiju`) conserva acceso total.
- Administrador de `.env` conserva acceso administrativo con restricciones de configuración sensible.
- Frontend de Seguridad (`seg_gestion_usuario.html`) consume APIs reales para usuarios, roles y permisos.

## Archivos tocados
- `src/mySiss/API/SystemService.cls`
- `src/mySiss/API/SystemREST.cls`
- `src/mySiss/Config/SG/RolStatus.cls`
- `frontend/app/Seguridad/seg_gestion_usuario.html`
- `frontend/app/assets/js/seg_gestion_usuario.js`

## Cómo probar
1. Compilar clases: `bash manage.sh compile`.
2. Iniciar sesión como superusuario o administrador.
3. Abrir `app/Seguridad/seg_gestion_usuario.html`.
4. Probar:
   - crear/editar usuario
   - asignar cliente y rol
   - listar usuarios
   - crear/editar rol
   - consultar/actualizar permisos por rol
5. Intentar consumir `/security/*` sin privilegios y verificar HTTP 403.
