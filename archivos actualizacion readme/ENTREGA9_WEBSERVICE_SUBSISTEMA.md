# ENTREGA 9 - Subsistema WebService

## Qué se implementó
- Modelo de datos WebService con 3 entidades persistentes:
  - `mySiss.Config.WS.Integracion` (`WSIntegracion`)
  - `mySiss.Config.WS.ClienteIntegracion` (`WSClienteIntegracion`)
  - `mySiss.Config.WS.IntegracionLog` (`WSIntegracionLog`)
- Extensión de `mySiss.API.SystemService` con lógica para:
  - CRUD de integraciones
  - asociación cliente↔integración y activación/inactivación
  - ejecución controlada HTTP GET/POST
  - trazabilidad y consulta de logs
- Extensión de `mySiss.API.SystemREST` con endpoints `/ws/*`.
- Reutilización y conexión real de vistas:
  - `mySissWSMaster.html`
  - `mySissWSIntegracion.html`
  - `mySissWSEjecucion.html`
  - JS: `mysiss_webservice_admin.js`

## Endpoints creados
- `GET /ws/integrations`
- `POST /ws/integrations`
- `GET /ws/integrations/:id`
- `PUT /ws/integrations/:id`
- `PUT /ws/integrations/:id/status`
- `GET /ws/clients/:id/integrations`
- `PUT /ws/clients/:id/integrations`
- `PUT /ws/client-integrations/:id/status`
- `POST /ws/execute`
- `GET /ws/logs/integration/:id`
- `GET /ws/logs/client/:id`
- `GET /ws/logs/:id`

## Estructura de datos
- `WSIntegracion`: definición maestra de integración.
- `WSClienteIntegracion`: asignación por cliente.
- `WSIntegracionLog`: trazabilidad de ejecución (siempre registra).

## Cómo probar
1. Compilar clases en namespace `MYSISS`:
   - `Do $SYSTEM.OBJ.Compile("mySiss.Config.WS.Integracion","ck")`
   - `Do $SYSTEM.OBJ.Compile("mySiss.Config.WS.ClienteIntegracion","ck")`
   - `Do $SYSTEM.OBJ.Compile("mySiss.Config.WS.IntegracionLog","ck")`
   - `Do $SYSTEM.OBJ.Compile("mySiss.API.SystemService","ck")`
   - `Do $SYSTEM.OBJ.Compile("mySiss.API.SystemREST","ck")`
2. Abrir `app/WS/mySissWSIntegracion.html` y crear una integración.
3. Asociar integración a cliente desde la misma vista.
4. Ejecutar desde `app/WS/mySissWSEjecucion.html`.
5. Verificar logs recientes en la misma vista o endpoint `/ws/logs/*`.
