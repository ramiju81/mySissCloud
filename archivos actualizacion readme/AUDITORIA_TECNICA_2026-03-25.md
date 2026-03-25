# Auditoría técnica integral — mySissCloud (2026-03-25)

## 1) Resumen del estado real del proyecto

- Estado global: **híbrido entre prototipo funcional y base técnica parcial**.
- Hay backend REST en IRIS y scripts de inicialización, pero gran parte del frontend opera con lógica cliente, datos en `localStorage/sessionStorage` y autenticación simulada.
- La arquitectura no está consolidada en una sola línea tecnológica coherente: conviven modelo legacy (`SG_User`, `SG_Passw`) y modelo nuevo (`mySiss_SEGUsuario`) con convenciones diferentes.
- Riesgo principal: **seguridad** (credenciales hardcoded, autenticación no robusta, CORS abierto, aplicaciones CSP sin auth, exposición de usuarios/passwords por defecto).

## 2) Estructura actual del proyecto

- **Infraestructura/arranque**: `docker-compose.yml`, `manage.sh`, `scripts/init.osc`.
- **Backend**: clases ObjectScript en `src/mySiss/`:
  - API REST: `src/mySiss/conn/API.cls`
  - Bootstrap y seguridad de plataforma: `src/mySiss/Config/WebApp.cls`, `DBInit.cls`, `Seed.cls`
  - Muchas clases de configuración por módulos (AU, GL, SG, WS, MS).
- **Frontend**: HTML estático masivo en `frontend/app/**` (sin bundler, sin framework, casi sin JS modular; mucha lógica incrustada inline).
- **Datos**:
  - Esquema SQL legacy: `db/mySiss_Cloud.sql`.
  - Esquema ejecutable real en ObjectScript: `src/mySiss/Config/DBInit.cls`.

## 3) Principales problemas encontrados

### 3.1 Acoplamiento y arquitectura
- El frontend mezcla UI + reglas + persistencia local en archivos HTML grandes.
- El backend no implementa de forma consistente RBAC por endpoint; valida sesión pero no privilegios por rol/acción.
- Hay dualidad de modelos/tablas (`SG_*` vs `mySiss_SEG*`) que eleva deuda técnica y riesgo de divergencia.

### 3.2 Duplicación de código
- Existe **árbol duplicado completo** dentro de `frontend/app/Auditoria/Auditoria/...` respecto de `frontend/app/Auditoria/...` (mismo contenido en múltiples archivos).
- Esto implica doble mantenimiento y alta probabilidad de inconsistencias.

### 3.3 Hardcoded y configuración en código
- Credenciales y usuarios por defecto expuestos en scripts y configuración.
- Rutas, valores SMTP y parámetros de seguridad fijados en código de bootstrap.
- Endpoints y paths no homogéneos entre frontend utilitario y despliegue real.

### 3.4 Persistencia simulada
- Uso extenso de `localStorage`/`sessionStorage` como “fuente de verdad” en módulos funcionales (auditoría/glosas), sin backend transaccional equivalente en la UI.

## 4) Riesgos técnicos y de seguridad

- **Auth débil**:
  - Login frontend por comparación directa de usuario/clave hardcoded.
  - “Recuperación de contraseña” simulada (solo consola/token base64 local).
- **Auth de plataforma débil**:
  - CSP app y REST app configuradas como no autenticadas.
- **API insegura**:
  - CORS `*` con credenciales habilitadas.
  - Validación de contraseña en texto plano y salt literal `'SALT'` al crear usuario en API.
  - IDs por `MAX()+1` (riesgo de condición de carrera).
- **Credenciales expuestas**:
  - Usuario IRIS y password por defecto en compose/scripts.
  - Superusuario app y password por defecto visibles en init/logs.
- **Manejo de errores**:
  - Mensajes internos potencialmente expuestos al cliente (`ex.DisplayString()`).

## 5) Qué está incompleto o simulado

- Login real del frontend principal: simulado por condicionales hardcoded.
- Recuperación de contraseña: simulada, no hay envío real ni verificación robusta de token.
- Flujo de múltiples pantallas depende de `localStorage/sessionStorage`, no de APIs backend en buena parte de módulos.
- Persistencia funcional real en frontend no está unificada contra la API REST existente.

## 6) Qué está mal planteado a nivel de arquitectura

- **Falta un contrato único de dominio** entre UI, API y BD.
- **Modelo de datos duplicado/ambiguo** (legacy SQL vs tablas modernas en `DBInit`).
- **UI monolítica por HTML estático** con lógica inline difícil de testear/versionar.
- **Bootstrap “todo en uno”** (infra + seguridad + usuario root + parámetros) sin separación por entorno.

## 7) Qué falta para nivel profesional

1. Seguridad base (must):
   - Remover credenciales hardcoded.
   - Forzar auth real en CSP/REST, sesiones seguras y CSRF strategy.
   - Hash de passwords con algoritmo robusto + salt único por usuario (y pepper opcional).
   - RBAC real en endpoints (no solo “hay sesión”).
2. Unificación de modelo:
   - Definir un único esquema canónico (eliminar/archivar legacy no usado).
3. Frontend mantenible:
   - Extraer JS inline a módulos.
   - Eliminar duplicados de directorio.
   - Reemplazar `localStorage` como persistencia de negocio por API.
4. Calidad:
   - Suite mínima de pruebas (API + smoke UI).
   - Linters/formateo y pipeline CI.
5. Operación:
   - Configuración externalizada por entorno (12-factor), secretos en vault/env seguros.

## 8) Recomendaciones claras de reorganización

### Fase 1 (contención de riesgo, 1-2 semanas)
- Desactivar credenciales por defecto en logs/scripts.
- Cerrar CORS a orígenes permitidos.
- Quitar `AutheEnabled=32` en apps productivas.
- Corregir creación de usuario en API: hash + salt real, transacciones y claves autogeneradas seguras.

### Fase 2 (consolidación técnica, 2-4 semanas)
- Definir “fuente única” de esquema (DBInit o migraciones SQL versionadas) y deprecar la otra.
- Eliminar árbol duplicado `frontend/app/Auditoria/Auditoria/` dejando una sola ruta.
- Introducir capa de servicios frontend para consumo API y desacoplar lógica de vistas.

### Fase 3 (madurez, 4-8 semanas)
- Tests automatizados (unitarios backend + integración API + smoke E2E).
- Observabilidad (logs estructurados, trazas, alertas).
- Hardening de sesión/cookies, rate limiting en login y auditoría de accesos real.

## Evidencia clave verificada

- API con CORS abierto y credenciales + login de password en texto plano + inserción con salt fijo: `src/mySiss/conn/API.cls`.
- WebApp/REST sin autenticación y creación de usuario IRIS hardcoded: `src/mySiss/Config/WebApp.cls`.
- Superusuario y password por defecto en bootstrap DB: `src/mySiss/Config/DBInit.cls`.
- Credenciales visibles en init y scripts: `scripts/init.osc`, `manage.sh`, `docker-compose.yml`.
- Login frontend hardcoded y recuperación simulada: `frontend/mySiss_Cloud_Login.html`.
- Persistencia en `localStorage`/`sessionStorage`: `frontend/app/Auditoria/...`, `frontend/app/Glosas/...`, `frontend/app.js`, `frontend/localstorage.html`.
- Evidencia de árbol duplicado de Auditoría: pares de archivos idénticos en `frontend/app/Auditoria/` y `frontend/app/Auditoria/Auditoria/`.
