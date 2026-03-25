# mySissCloud

Sistema de gestión hospitalaria mySiss sobre InterSystems IRIS.

## Módulos
- **Seguridad** — Usuarios, roles, funcionalidades y control de acceso
- **Auditoría** — Auditoría concurrente, hallazgos y planes de acción
- **Glosas** — Radicación, objeciones, conciliación
- **Honorarios** — Contratos médicos, producción y liquidación
- **Cuentas Médicas** — Auditoría y validación de cuentas

## Requisitos
- Docker Desktop
- InterSystems IRIS Community (imagen Docker)

## Inicio rápido

```bash
# 1. Iniciar contenedor
bash manage.sh start

# 2. Inicializar base de datos (primera vez)
bash manage.sh init

# 3. Abrir la aplicación
# http://localhost:52773/csp/mySissCloud/mySiss_Cloud_Login.html
```

## Credenciales iniciales

| Tipo | Usuario | Contraseña |
|------|---------|------------|
| IRIS (superserver) | ABAP | ABAPMYSISS |
| App mySiss | ABAP | Admin2025* |

> **IMPORTANTE:** Cambiar la contraseña de la aplicación después del primer ingreso.

## Estructura del proyecto

```
mySissCloud/
├── .devcontainer/       # Configuración DevContainer
├── .env                 # Variables de entorno
├── docker-compose.yml   # Configuración Docker
├── manage.sh            # Script de administración (Linux/Mac/WSL)
├── scripts/
│   ├── init.osc         # Inicialización completa de BD
│   └── compile.osc      # Solo compilar clases
├── src/mySiss/
│   ├── Config/
│   │   ├── DBInit.cls   # Crea todas las tablas (SEG/AUD/GLO/HON/CUE)
│   │   ├── Seed.cls     # Datos iniciales: funcionalidades y roles
│   │   └── WebApp.cls   # Configura la WebApp REST en IRIS
│   └── conn/
│       └── API.cls      # API REST (auth + recuperación de clave + CRUD)
└── frontend/
    ├── mySiss_Cloud_Login.html   # Login con recuperación de contraseña
    ├── mysiss_cloud.html         # Dashboard principal
    └── app/
        ├── Auditoria/
        ├── Glosas/
        ├── Honorarios/
        └── Seguridad/
            └── seg_gestion_usuario.html
```

## Flujo de recuperación de contraseña

1. Click en "Olvidé mis datos" en el login
2. **Paso 1** — Ingresar correo registrado
3. **Paso 2** — Ingresar el token de 6 dígitos recibido (válido 10 min)
4. **Paso 3** — Crear nueva contraseña (mín. 8 chars, mayúscula, minúscula, número, especial)

## Nomenclatura de tablas

Todas las tablas siguen el patrón `mySiss_XXXNombre` donde `XXX` es el prefijo del módulo:

| Módulo | Prefijo |
|--------|---------|
| Seguridad | SEG |
| Auditoría | AUD |
| Glosas | GLO |
| Honorarios | HON |
| Cuentas Médicas | CUE |
