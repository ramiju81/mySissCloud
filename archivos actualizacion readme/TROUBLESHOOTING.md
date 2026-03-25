# Solución de Problemas - mySissCloud

## 🔍 Diagnóstico Rápido

### Usar el script de administración

```powershell
.\manage.ps1 status
```

Este comando te mostrará el estado completo del sistema y te ayudará a identificar problemas.

---

## ❌ Error: 404 Not Found al acceder a HTML

### Síntomas
- Al acceder a `http://localhost:52773/csp/mySissCloud/mysiss_cloud.html` aparece "HTTP ERROR 404"
- El navegador dice "No se puede encontrar esta página"

### Causas Comunes

#### 1. La aplicación web no está configurada

**Diagnóstico:**
```powershell
# Verificar si el contenedor está corriendo
docker ps

# Verificar archivos HTML
docker exec iris-mysisscloud ls -la /usr/irissys/csp/mySissCloud/*.html
```

**Solución:**
```powershell
# Re-inicializar el sistema
.\manage.ps1 init
```

O manualmente:
```powershell
Get-Content .\scripts\init.osc | docker exec -i iris-mysisscloud iris session IRIS
```

#### 2. Los archivos HTML no están en el contenedor

**Diagnóstico:**
```powershell
docker exec iris-mysisscloud ls -la /usr/irissys/csp/mySissCloud/
```

Si no ves archivos HTML, el volumen no está montado correctamente.

**Solución:**
```powershell
# Detener y recrear contenedor
docker-compose down
docker-compose up -d

# Verificar archivos
docker exec iris-mysisscloud ls -la /usr/irissys/csp/mySissCloud/
```

#### 3. El namespace no es correcto

**Diagnóstico:**
Entrar al portal IRIS: http://localhost:52773/csp/sys/UtilHome.csp
- Usuario: SuperUser
- Password: SYS

Ir a: System Administration → Security → Applications → Web Applications
Buscar `/csp/mySissCloud` y verificar:
- NameSpace debe ser: **CNET**
- Path debe ser: **/usr/irissys/csp/mySissCloud**

**Solución:**
Ejecutar `.\manage.ps1 init` para reconfigurar.

---

## ❌ Error: METHOD DOES NOT EXIST en /api/ping

### Síntomas
```json
{
  "errors": [{
    "error": "ERROR #5002: Error de ObjectScript: <METHOD DOES NOT EXIST>WriteJSON+3^mySiss.conn.API.1 *Write,%CSP.Response"
  }]
}
```

### Causa
La clase API.cls antigua no tenía los imports correctos de %CSP.Response.

### Solución
```powershell
# Recompilar con la nueva versión
.\manage.ps1 compile

# O re-inicializar completamente
.\manage.ps1 init
```

---

## ❌ Error: Credenciales inválidas al hacer login

### Síntomas
- Usuario: admin
- Password: admin123
- Respuesta: "Credenciales inválidas"

### Diagnóstico

**Verificar que existe el usuario:**
```powershell
# Entrar al shell IRIS
.\manage.ps1 shell

# En IRIS, ejecutar:
CNET> set sql = "SELECT * FROM SG_User WHERE Nombre_user = 'admin'"
CNET> set stmt = ##class(%SQL.Statement).%New()
CNET> do stmt.%Prepare(sql)
CNET> set rset = stmt.%Execute()
CNET> while rset.%Next() { write rset.%Get("Nombre_user"), " - ", rset.%Get("ID_user"), ! }
CNET> halt
```

### Solución

Si no aparece el usuario:
```powershell
.\manage.ps1 init
```

Esto recreará toda la BD incluyendo el super usuario.

---

## ❌ Error: Container is not running

### Síntomas
```
Error: Cannot connect to Docker daemon
```

### Solución
1. Verificar que Docker Desktop está corriendo
2. Abrir Docker Desktop
3. Esperar a que esté completamente iniciado
4. Ejecutar:
```powershell
.\manage.ps1 start
```

---

## ❌ Error: Port 52773 already in use

### Síntomas
```
Error: Bind for 0.0.0.0:52773 failed: port is already allocated
```

### Causa
Ya hay otro servicio usando el puerto 52773.

### Solución

**Opción 1: Detener el otro servicio**
```powershell
# Ver qué está usando el puerto
netstat -ano | findstr :52773

# El último número es el PID, detenerlo:
taskkill /PID <número> /F
```

**Opción 2: Cambiar el puerto en mySissCloud**

Editar `.env`:
```
IRIS_WEB_PORT=52774
```

Luego:
```powershell
docker-compose down
docker-compose up -d
```

Acceder en: http://localhost:52774

---

## ❌ Error: Cannot find module in JavaScript

### Síntomas
En la consola del navegador:
```
Uncaught ReferenceError: fetch is not defined
```

### Causa
Navegador muy antiguo o modo de compatibilidad.

### Solución
1. Usar navegador moderno (Chrome, Firefox, Edge actualizados)
2. Desactivar modo de compatibilidad en IE
3. Actualizar navegador

---

## ❌ Error: CORS Policy Block

### Síntomas
```
Access to fetch at 'http://localhost:52773/csp/mySissCloud/api/login' 
from origin 'http://localhost:8080' has been blocked by CORS policy
```

### Causa
Estás accediendo desde un puerto diferente al del servidor.

### Solución
Acceder directamente desde el puerto de IRIS:
- ✅ http://localhost:52773/csp/mySissCloud/mysiss_cloud.html
- ❌ http://localhost:8080/mysiss_cloud.html

---

## ❌ Error: Session lost / Usuario no autenticado

### Síntomas
- Login funciona
- Al navegar a otra página, dice "No autenticado"
- Redirige al login constantemente

### Causa
Las cookies de sesión no se están enviando correctamente.

### Solución
1. Verificar que todos los fetch usen `credentials: 'include'`:
```javascript
fetch('/csp/mySissCloud/api/verify-session', {
    credentials: 'include'  // ← IMPORTANTE
})
```

2. Verificar que no hay mezclado de HTTP/HTTPS
3. Limpiar cookies del navegador y volver a intentar

---

## ❌ Error: Database locked / Cannot write

### Síntomas
```
ERROR #5540: SQLCODE: -400 Message: Fatal error occurred
```

### Causa
Corrupción en la base de datos o falta de espacio.

### Solución
```powershell
# Detener contenedor
docker-compose down

# Eliminar volúmenes (PERDERÁS DATOS)
docker volume ls
docker volume rm <volume-name>

# Reiniciar
docker-compose up -d
.\manage.ps1 init
```

---

## ❌ Los cambios en HTML no se reflejan

### Síntomas
- Editas un archivo HTML
- Recargas la página
- No ves los cambios

### Solución

**Opción 1: Limpiar caché del navegador**
- Chrome: Ctrl + Shift + Delete → Limpiar caché
- O Ctrl + Shift + R para recargar forzada

**Opción 2: Verificar que el archivo se actualizó en el contenedor**
```powershell
# Ver fecha de modificación
docker exec iris-mysisscloud ls -la /usr/irissys/csp/mySissCloud/mysiss_cloud.html

# Si no coincide, el volumen no está sincronizando
docker-compose restart
```

---

## ❌ Los cambios en .cls no se reflejan

### Síntomas
- Editas una clase ObjectScript
- El comportamiento no cambia

### Solución
```powershell
# SIEMPRE compilar después de editar .cls
.\manage.ps1 compile

# O si cambiaste estructura de BD
.\manage.ps1 init
```

---

## 🔧 Comandos Útiles de Diagnóstico

### Ver logs en tiempo real
```powershell
.\manage.ps1 logs
```

### Entrar al shell IRIS
```powershell
.\manage.ps1 shell
```

### Ver estado completo
```powershell
.\manage.ps1 status
```

### Verificar API
```powershell
curl http://localhost:52773/csp/mySissCloud/api/ping
```

O en PowerShell:
```powershell
Invoke-WebRequest -Uri "http://localhost:52773/csp/mySissCloud/api/ping" -UseBasicParsing
```

### Ver tablas creadas
```powershell
.\manage.ps1 shell

# En IRIS:
CNET> set sql = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'SQLUser'"
CNET> set stmt = ##class(%SQL.Statement).%New()
CNET> do stmt.%Prepare(sql)
CNET> set rset = stmt.%Execute()
CNET> while rset.%Next() { write rset.%Get("TABLE_NAME"), ! }
CNET> halt
```

### Ver usuarios creados
```powershell
.\manage.ps1 shell

# En IRIS:
CNET> set sql = "SELECT u.Nombre_user, p.Nombre, p.Apellido FROM SG_User u JOIN SG_Person p ON u.ID_Person = p.ID_Person"
CNET> set stmt = ##class(%SQL.Statement).%New()
CNET> do stmt.%Prepare(sql)
CNET> set rset = stmt.%Execute()
CNET> while rset.%Next() { write rset.%Get("Nombre_user"), " - ", rset.%Get("Nombre"), " ", rset.%Get("Apellido"), ! }
CNET> halt
```

---

## 🆘 Reseteo Completo (Último Recurso)

Si nada funciona y quieres empezar de cero:

```powershell
# 1. Detener todo
docker-compose down

# 2. Eliminar volúmenes de datos (PERDERÁS TODO)
docker volume prune

# 3. Eliminar imagen (opcional)
docker rmi intersystemsdc/iris-community:latest

# 4. Reconstruir
docker-compose up -d

# 5. Esperar 30 segundos a que IRIS inicie completamente
Start-Sleep -Seconds 30

# 6. Inicializar
.\manage.ps1 init

# 7. Verificar
.\manage.ps1 status
```

---

## 📞 Checklist de Debugging

Cuando algo no funciona, verifica en este orden:

- [ ] ¿Docker Desktop está corriendo?
- [ ] ¿El contenedor está activo? (`docker ps`)
- [ ] ¿Los archivos HTML están en el contenedor? (`.\manage.ps1 status`)
- [ ] ¿La aplicación web está configurada? (Portal IRIS → Security → Applications)
- [ ] ¿El API responde? (`curl http://localhost:52773/csp/mySissCloud/api/ping`)
- [ ] ¿Las clases están compiladas? (`.\manage.ps1 compile`)
- [ ] ¿La BD está inicializada? (`.\manage.ps1 init`)
- [ ] ¿El navegador tiene caché? (Ctrl + Shift + R)
- [ ] ¿Hay errores en la consola del navegador? (F12)
- [ ] ¿Los logs muestran errores? (`.\manage.ps1 logs`)

---

## 📚 Recursos Adicionales

- **Documentación IRIS**: https://docs.intersystems.com/irislatest/
- **Docker Troubleshooting**: https://docs.docker.com/config/daemon/
- **CORS Debugging**: https://developer.mozilla.org/es/docs/Web/HTTP/CORS
- **Fetch API**: https://developer.mozilla.org/es/docs/Web/API/Fetch_API

---

## 💡 Consejos Generales

1. **Siempre compila después de cambiar .cls**: `.\manage.ps1 compile`
2. **Usa el script manage.ps1** en lugar de comandos manuales
3. **Revisa los logs** cuando algo falle: `.\manage.ps1 logs`
4. **El navegador cachea mucho**: Ctrl + Shift + R para recargar
5. **El shell IRIS es tu amigo**: `.\manage.ps1 shell`
6. **No edites directamente en el contenedor**: todos los cambios se hacen en local y se sincronizan
7. **Si dudas, reinicia**: `.\manage.ps1 restart`
8. **Si REALMENTE dudas, re-inicializa**: `.\manage.ps1 init`
