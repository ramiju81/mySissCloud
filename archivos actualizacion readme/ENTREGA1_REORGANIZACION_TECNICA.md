# ENTREGA 1 — Reorganización técnica progresiva de mySissCloud

## 1. Estado real actual del repositorio

- Stack real detectado:
  - Backend: InterSystems IRIS ObjectScript (`src/mySiss/**`).
  - Frontend: HTML/CSS/JS estático por módulo (`frontend/app/**`).
  - Datos: SQL legacy en `db/mySiss_Cloud.sql` + creación real de tablas vía `DBInit.cls`.
  - Orquestación local: Docker Compose + scripts bash/PowerShell.
- Estado de integración: existen clases REST y bootstrap de WebApp IRIS, pero no hay evidencia de integración completa y homogénea entre todas las pantallas frontend y esos endpoints.
- El repositorio hoy es un conjunto de módulos parcialmente independientes con madurez desigual.

## 2. Estructura real encontrada

- Raíz:
  - `frontend/` (UI estática, assets y plantillas WS)
  - `src/` (clases IRIS)
  - `db/` (SQL legacy)
  - `scripts/` (init/compile)
  - `docker-compose.yml`, `manage.sh`, `manage.ps1`
- Frontend real por módulos:
  - `frontend/app/Seguridad`
  - `frontend/app/Glosas`
  - `frontend/app/Honorarios`
  - `frontend/app/Auditoria`
- Backend real:
  - API REST: `src/mySiss/conn/API.cls`
  - Configuración/plataforma: `src/mySiss/Config/WebApp.cls`, `DBInit.cls`, `Seed.cls`
  - Modelo por dominios: `Config/AU`, `GL`, `HO`, `MS`, `SG`, `WS`.
- Piezas separadas:
  - Existen rutas frontend hardcoded que no corresponden exactamente con archivos reales (ej. diferencias de nombre/case o ubicación).

## 3. Módulos y componentes identificados

- Módulos frontend confirmados: Auditoría, Glosas, Honorarios, Seguridad.
- Módulos backend/modelo confirmados: AU, GL, HO, MS, SG, WS.
- Componentes compartidos mínimos:
  - `frontend/app.js` (utilitario de sesión muy básico).
  - No se evidencia framework común de componentes ni capa común de servicios para todos los módulos.
- Independencia actual:
  - Alta independencia entre módulos frontend (cada uno con su propio HTML/CSS/JS).
  - La convivencia en base común es posible, pero hoy no está formalizada por contrato API uniforme ni por convenciones de integración frontend.

## 4. Problemas reales verificados

- Duplicación real verificada:
  - Existe árbol duplicado de Auditoría (`frontend/app/Auditoria/Auditoria/...`) con archivos equivalentes a `frontend/app/Auditoria/...`.
- Hardcoded:
  - Login frontend con usuarios/contraseñas en código.
  - Credenciales por defecto visibles en compose/scripts/bootstrap.
- Persistencia local:
  - Uso intensivo de `localStorage/sessionStorage` como persistencia funcional en pantallas de Auditoría y Glosas.
- Lógica de negocio en frontend:
  - Reglas de flujo y datos de negocio embebidos en HTML/JS inline.
- Contrato común débil entre capas:
  - API existente no cubre de forma explícita todos los flujos de todos los módulos frontend actuales.
  - `frontend/app.js` usa base `/mySiss/api`, mientras `WebApp.cls` expone `/csp/mySissCloud/api`.
- Seguridad:
  - CORS abierto con credenciales.
  - REST/CSP configurados sin autenticación de plataforma.
  - En API hay validación de password en texto plano y creación de password con salt fijo literal.
- Dependencias/rutas incompletas:
  - Ejemplo verificado: login apunta a `app/Honorarios/Honorarios.html` (no existe; archivo real `honorarios.html`).
  - Ejemplo verificado: login apunta a `app/Auditoria/Rol lider proceso/AuditoriaLP.html` pero ese archivo existe bajo `app/Auditoria/Auditoria/rol lider proceso/`.
- Corrección explícita respecto a revisiones previas:
  - Se confirma con evidencia que **sí** existe duplicación de Auditoría en el repositorio actual (no es supuesto): `frontend/app/Auditoria/...` y `frontend/app/Auditoria/Auditoria/...`.

## 5. Elementos reutilizables

- Frontend reutilizable (sin rehacer):
  - Pantallas por módulo ya construidas y navegables, útiles como base visual/funcional.
  - Estructura por módulo actual (independiente) puede mantenerse temporalmente.
- Backend reutilizable:
  - `DBInit.cls` y `Seed.cls` como base para inicialización controlada de datos/tablas.
  - `API.cls` como punto de partida de contrato REST (debe endurecerse).
  - `WebApp.cls` como bootstrap técnico (debe ajustarse por entorno y seguridad).
- Infra reutilizable:
  - `docker-compose.yml` + scripts `manage.sh/manage.ps1` para ciclo de desarrollo/operación inicial.

## 6. Arquitectura objetivo propuesta

Escenario objetivo respetado:
- Frontend servido por Web Application de IRIS.
- Backend en Docker en servidor aparte.
- Base de datos en IRIS for Health.

Responsabilidades objetivo:
- Frontend (IRIS WebApp):
  - Renderizado UI, estado de vista y validación básica de formularios.
  - Sin persistencia de negocio en `localStorage` (solo estado UX no sensible).
- Backend (Docker aparte):
  - API de negocio por dominios (Seguridad, Glosas, Honorarios, Auditoría).
  - Autenticación, autorización, auditoría, validaciones de negocio y orquestación de flujos.
- IRIS for Health (DB):
  - Persistencia única de datos transaccionales.
  - Esquema canónico y políticas de integridad.

Conexión futura (sin simular ahora):
- Frontend -> Backend: HTTPS REST (contrato versionado).
- Backend -> IRIS DB: conexión IRIS nativa/driver según stack backend definitivo.

Qué se puede hacer ya:
- Definir contrato API mínimo por módulo y mapa pantalla->endpoint.
- Normalizar rutas frontend y eliminar duplicados de estructura.
- Encapsular acceso a datos frontend en servicios JS por módulo (aunque temporalmente lean localStorage).

Qué debe esperar:
- Login unificado productivo, recuperación por token real, remember-me real, y endurecimiento final de sesión/cookies hasta tener backend definitivo conectado a IRIS DB en entorno objetivo.

## 7. Estrategia de transición sin romper estructura actual

Fase T0 (inmediata, sin romper):
- Mantener módulos como están (independientes).
- Congelar nuevas pantallas duplicadas en `frontend/app/Auditoria/Auditoria/`.
- Corregir navegación rota por rutas/case incorrectos.
- Inventario formal por módulo: pantallas, datos locales usados, endpoints existentes.

Fase T1 (reorganización mínima):
- Introducir carpeta de servicios JS por módulo (sin migración masiva), para aislar acceso a datos.
- Estandarizar naming/rutas de archivos y menús sin alterar UX.
- Definir contrato REST mínimo por dominio y priorizar pantallas críticas.

Fase T2 (unificación progresiva):
- Migrar persistencia de negocio desde localStorage/sessionStorage a API por lotes de pantallas.
- Mantener fallback local temporal controlado solo en pantallas aún no migradas.
- Cerrar huecos de seguridad (CORS, auth app, RBAC por endpoint).

Fase T3 (entregas siguientes):
- Login unificado + recuperación por token + política de contraseñas configurable + remember me sobre backend real.

## 8. Dependencias y vacíos que aún faltan

- Definir stack final del backend separado (lenguaje/framework y cliente IRIS DB).
- Definir mecanismo de autenticación objetivo (cookies seguras vs token) y expiración.
- Definir SMTP/servicio de correo real para token de recuperación.
- Definir contrato único de entidades entre frontend/backend/DB (hoy hay legado y modelo nuevo coexistiendo).
- Definir matriz de permisos por módulo/acción aplicada en backend.
- Definir ambientes y gestión de secretos (no hardcoded).

## 9. Base necesaria para la Entrega 2

Para diseñar correctamente login unificado, recordar datos, token por correo y nueva contraseña, se requiere dejar cerrados estos insumos:

1) Inventario funcional (por pantalla)
- Pantallas exactas de login/recuperación/cambio clave activas y rutas válidas.
- Flujo real de navegación (éxito/error/logout).

2) Inventario de datos
- Tablas reales que se usarán para usuario, roles, credenciales, tokens y parámetros.
- Campos obligatorios y formato (usuario, email, estado, vencimiento, intentos fallidos, expiración token).

3) Contrato API mínimo de seguridad
- Endpoints necesarios: login, logout, verify-session, forgot-password, validate-token, reset-password, remember-me.
- Estructura de request/response y códigos de error.

4) Políticas configurables
- Fuente de verdad de parámetros de contraseña (longitud, complejidad, expiración, reintentos, bloqueo).
- Parámetros de expiración de sesión y token.

5) Integración técnica
- Decisión de transporte de sesión (cookie segura o token) y estrategia de almacenamiento cliente.
- Mecanismo de envío de correo y observabilidad de eventos de seguridad.

6) Plan de migración de pantallas
- Orden de migración por riesgo/impacto (primero Seguridad/login, luego módulos con mayor uso de localStorage).
- Criterio de salida por pantalla (ya no depende de datos hardcoded/localStorage para negocio).
