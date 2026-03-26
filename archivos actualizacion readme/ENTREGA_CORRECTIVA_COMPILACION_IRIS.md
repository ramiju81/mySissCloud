# Entrega correctiva de compilación IRIS

## 1) Errores de compilación corregidos
- Se corrigieron expresiones con sintaxis ObjectScript ambigua/no válida que podían disparar `ERROR #5559`:
  - guardas `If '..RequireSecurityAdmin()` cambiadas a forma explícita `If (..RequireSecurityAdmin()=0) { Quit $$$OK }`.
  - eliminación de línea repetida en `GetSecurityUser`.
  - eliminación de expresión inválida con `$Piece(...,*-1)` en validación SQLite.
  - limpieza de duplicado de asignación `tEstadoId`.

## 2) Archivos tocados
- `src/mySiss/API/SystemService.cls`
- `src/mySiss/API/SystemREST.cls`

## 3) Dependencias mínimas ajustadas
- No fue necesario ajustar nuevas dependencias funcionales.
- Solo se corrigió sintaxis y consistencia interna para parseo válido IRIS.

## 4) Cómo compilar y probar
1. Ingresar a IRIS en namespace `MYSISS`.
2. Compilar clases:
   - `Do $SYSTEM.OBJ.Compile("mySiss.API.SystemService","ck")`
   - `Do $SYSTEM.OBJ.Compile("mySiss.API.SystemREST","ck")`
3. Verificar que no aparezca `ERROR #5559`.
4. Probar endpoints base:
   - `GET /csp/mySissCloud/api/system/health`
   - `GET /csp/mySissCloud/api/auth/context`
   - `GET /csp/mySissCloud/api/security/users`
