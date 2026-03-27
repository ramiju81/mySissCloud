# Entrega correctiva de compilación IRIS (SystemREST/SystemService)

## 1) Errores sintácticos corregidos
- Se eliminó sintaxis inline inválida para IRIS/ObjectScript en ambas clases:
  - objetos inline (`{"x":1}`),
  - arreglos inline (`[]`),
  - `Quit` con objetos inline,
  - `WriteJSON` con objetos inline,
  - `%Push` con objetos inline.
- Se reemplazó por sintaxis válida:
  - `##class(%DynamicObject).%New()`
  - `##class(%DynamicArray).%New()`
  - `%Set()` / `%Push()`
  - helper `Obj(...)` para construcción segura de respuestas/ítems.
- Se corrigieron operadores no válidos (`&&`, `||`) a operadores válidos ObjectScript (`&`, `!`).
- Se normalizó `ReadJSONBody()` para devolver `%DynamicObject` válido sin literales inline.

## 2) Archivos tocados
- `src/mySiss/API/SystemService.cls`
- `src/mySiss/API/SystemREST.cls`

## 3) Dependencias mínimas adicionales
- Ninguna dependencia nueva.
- Solo ajustes internos de sintaxis en las dos clases objetivo.

## 4) Cómo compilar en IRIS
1. Entrar al namespace `MYSISS`.
2. Ejecutar:
   - `Do $SYSTEM.OBJ.Compile("mySiss.API.SystemService","ck")`
   - `Do $SYSTEM.OBJ.Compile("mySiss.API.SystemREST","ck")`
3. Verificar ausencia de `ERROR #5559` y `ERROR #5030`.
