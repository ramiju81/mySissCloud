# Entrega - Corrección de centralización frontend

## 1) Qué se corrigió
- Se corrigió la reorganización anterior para cumplir centralización real:
  - todos los CSS de módulos/login/WS quedaron en `frontend/app/css/`
  - todos los JS de módulos/login/WS quedaron en `frontend/app/js/`
  - `services` quedó centralizado en `frontend/app/js/services/`

## 2) Qué archivos se movieron
- CSS movidos desde carpetas por módulo (`Login`, `Seguridad`, `Honorarios`, `Auditoria`, `Glosas`, `WS/static`) a `app/css/`.
- JS movidos desde carpetas por módulo (`Login`, `Seguridad`, `Honorarios`, `Auditoria`, `Glosas`, `WS/static`) a `app/js/`.
- `app/services/*.js` -> `app/js/services/*.js`.

## 3) Estructura final
- HTML: `frontend/app/<Modulo>/*.html`
- CSS central: `frontend/app/css/*.css`
- JS central: `frontend/app/js/*.js`
- Servicios centralizados: `frontend/app/js/services/*.js`

## 4) Cómo probar
1. Abrir `mySiss_Cloud_Login.html` y validar login + recuperación.
2. Validar carga de assets en:
   - `app/Seguridad/seg_gestion_usuario.html`
   - `app/Honorarios/honorarios.html`
   - `app/Auditoria/Auditoria.html`
   - `app/Glosas/radicacion.html`
3. Abrir `app/WS/template/mySissWSMaster.html` y validar CSS cargado desde `app/css`.
4. Confirmar que no quedan carpetas `css/` o `js/` dentro de módulos ajustados.
