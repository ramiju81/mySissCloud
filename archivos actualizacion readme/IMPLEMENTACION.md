# 🚀 Guía de Implementación Rápida - mySissCloud

## ✅ Qué se ha corregido

### 1. Error METHOD DOES NOT EXIST en API ✅
**Problema original:** Al llamar `/api/ping` obtenías error de método no existe
**Solución:** Se corrigió la clase `API.cls` con imports y estructura correcta

### 2. Error 404 en archivos HTML ✅  
**Problema original:** No se podían acceder a los HTML desde el navegador
**Solución:** Se creó `WebApp.cls` que configura correctamente las aplicaciones web

### 3. Base de datos vacía ✅
**Problema original:** `DBInit.cls` y `Seed.cls` estaban vacíos
**Solución:** Se implementó toda la estructura de tablas y datos iniciales

### 4. No existía super usuario ✅
**Problema original:** No había forma de acceder al sistema
**Solución:** Se crea automáticamente el usuario `admin` con contraseña `admin123`

### 5. Proceso de inicialización manual ✅
**Problema original:** Muchos pasos manuales y propenso a errores
**Solución:** Script unificado `init.osc` y script de PowerShell `manage.ps1`

## 📦 Archivos Nuevos/Modificados

```
mySissCloud/
├── src/mySiss/
│   ├── conn/
│   │   └── API.cls              ← MODIFICADO: API REST completo
│   └── Config/
│       ├── DBInit.cls           ← MODIFICADO: Crea todas las tablas
│       ├── Seed.cls             ← MODIFICADO: Inserta datos iniciales
│       └── WebApp.cls           ← NUEVO: Configura aplicaciones web
├── scripts/
│   ├── compile.osc              ← Existente (deprecado)
│   └── init.osc                 ← NUEVO: Script completo de inicialización
├── README.md                    ← NUEVO: Documentación completa
├── MIGRACION_HTML.md            ← NUEVO: Guía para migrar HTMLs
├── TROUBLESHOOTING.md           ← NUEVO: Solución de problemas
└── manage.ps1                   ← NUEVO: Script de administración
```

## 🎯 Pasos para Implementar

### Paso 1: Detener el contenedor actual

```powershell
cd C:\mySissCloud
docker-compose down
```

### Paso 2: Reemplazar archivos

Copia los archivos del proyecto actualizado sobre tu directorio existente. Los archivos importantes a reemplazar son:

- `src/mySiss/conn/API.cls`
- `src/mySiss/Config/DBInit.cls`
- `src/mySiss/Config/Seed.cls`
- `src/mySiss/Config/WebApp.cls` (nuevo)
- `scripts/init.osc` (nuevo)
- `manage.ps1` (nuevo)

### Paso 3: Iniciar contenedor

```powershell
docker-compose up -d
```

Espera 30 segundos para que IRIS inicie completamente.

### Paso 4: Inicializar el sistema

**Opción A: Usando el script de administración (recomendado)**
```powershell
.\manage.ps1 init
```

**Opción B: Manualmente**
```powershell
Get-Content .\scripts\init.osc | docker exec -i iris-mysisscloud iris session IRIS
```

Este proceso:
1. ✓ Carga todas las clases
2. ✓ Compila el API REST
3. ✓ Crea todas las tablas de la BD
4. ✓ Inserta datos maestros
5. ✓ Crea el super usuario
6. ✓ Configura las aplicaciones web

### Paso 5: Verificar instalación

```powershell
.\manage.ps1 status
```

Deberías ver:
- ✓ Contenedor corriendo
- ✓ Archivos HTML encontrados
- ✓ Clases ObjectScript encontradas
- ✓ API respondiendo correctamente

### Paso 6: Probar acceso

**1. Probar API:**
http://localhost:52773/csp/mySissCloud/api/ping

Deberías ver:
```json
{
  "ok": 1,
  "service": "mySissCloud API",
  "version": "1.0.0",
  "timestamp": "2024-02-11 14:30:00"
}
```

**2. Probar HTML:**
http://localhost:52773/csp/mySissCloud/mysiss_cloud.html

Debería cargar la página principal.

**3. Probar Login:**
http://localhost:52773/csp/mySissCloud/WebServiceLogin.html

- Usuario: `admin`
- Contraseña: `admin123`

⚠️ **NOTA:** El login actual todavía usa localStorage. Necesitas modificarlo según la guía MIGRACION_HTML.md para que use el API REST.

## 📝 Próximos Pasos

### Inmediato (Esto ya funciona)
- ✅ API REST operativo
- ✅ Base de datos creada con estructura completa
- ✅ Super usuario creado
- ✅ Aplicaciones web configuradas
- ✅ Archivos HTML accesibles

### A corto plazo (Debes implementar)
1. **Modificar WebServiceLogin.html** para usar `/api/login` en lugar de localStorage
2. **Agregar verificación de sesión** en mysiss_cloud.html y otras páginas
3. **Crear endpoints REST** para módulos de Seguridad, Glosas, Honorarios, Auditoría
4. **Modificar todos los HTMLs** para consumir API en lugar de localStorage

Ver archivo `MIGRACION_HTML.md` para guía detallada.

## 🔧 Comandos Útiles del Script de Administración

```powershell
# Ver ayuda
.\manage.ps1 help

# Iniciar contenedor
.\manage.ps1 start

# Detener contenedor
.\manage.ps1 stop

# Reiniciar contenedor
.\manage.ps1 restart

# Inicializar/Reinicializar BD completa
.\manage.ps1 init

# Solo compilar clases (sin tocar BD)
.\manage.ps1 compile

# Ver logs en tiempo real
.\manage.ps1 logs

# Abrir shell IRIS
.\manage.ps1 shell

# Ver estado del sistema
.\manage.ps1 status
```

## 🗄️ Estructura de Base de Datos Creada

### Módulo de Seguridad
- ✅ SG_TipoDoc - Tipos de documento
- ✅ SG_Celular - Números de celular
- ✅ SG_Email - Correos electrónicos
- ✅ SG_Person - Personas
- ✅ SG_Password - Contraseñas
- ✅ SG_User - Usuarios del sistema
- ✅ SG_Rol - Roles
- ✅ SG_UserRol - Asignación usuario-rol
- ✅ SG_Modulo - Módulos del sistema
- ✅ SG_Funcion - Funciones por módulo
- ✅ SG_Actividad - Actividades por función
- ✅ SG_RolActividad - Permisos por rol

### Datos Maestros
- ✅ MS_Pais - Países
- ✅ MS_Departamento - Departamentos
- ✅ MS_Ciudad - Ciudades
- ✅ MS_Sede - Sedes
- ✅ MS_Prestador - Prestadores de salud
- ✅ MS_Asegur - Aseguradoras

### Datos Iniciales Insertados
- ✅ 5 tipos de documento (CC, CE, PA, TI, NIT)
- ✅ 3 países (Colombia, Estados Unidos, México)
- ✅ 3 departamentos de Colombia
- ✅ 3 ciudades (Bogotá, Medellín, Cali)
- ✅ 4 módulos (Seguridad, Glosas, Honorarios, Auditoría)
- ✅ 10 funciones distribuidas en los módulos
- ✅ 4 actividades para gestión de usuarios
- ✅ 5 roles (SuperUsuario, Administrador, Auditor, Facturador, Consulta)
- ✅ 1 super usuario: admin / admin123

## 🎓 Ejemplo de Uso

### Consultar usuarios desde IRIS Shell

```powershell
.\manage.ps1 shell
```

En el shell de IRIS:
```objectscript
CNET> set sql = "SELECT u.Nombre_user, p.Nombre, p.Apellido, r.Rol FROM SG_User u JOIN SG_Person p ON u.ID_Person = p.ID_Person JOIN SG_UserRol ur ON u.ID_user = ur.ID_user JOIN SG_Rol r ON ur.ID_rol = r.ID_rol"
CNET> set stmt = ##class(%SQL.Statement).%New()
CNET> do stmt.%Prepare(sql)
CNET> set rset = stmt.%Execute()
CNET> while rset.%Next() { write rset.%Get("Nombre_user"), " (", rset.%Get("Nombre"), " ", rset.%Get("Apellido"), ") - Rol: ", rset.%Get("Rol"), ! }
CNET> halt
```

Salida esperada:
```
admin (Super Usuario) - Rol: SuperUsuario
```

### Probar API de Login

Usando PowerShell:
```powershell
$body = @{
    username = "admin"
    password = "admin123"
} | ConvertTo-Json

$response = Invoke-RestMethod -Uri "http://localhost:52773/csp/mySissCloud/api/login" -Method Post -Body $body -ContentType "application/json" -SessionVariable session

$response
```

Salida esperada:
```json
{
  "success": 1,
  "message": "Login exitoso",
  "user": {
    "id": 1,
    "username": "admin",
    "fullName": "Super Usuario",
    "roles": ["SuperUsuario"]
  }
}
```

## ⚠️ Advertencias Importantes

1. **Contraseñas en texto plano:** Actualmente las contraseñas se guardan en texto plano. En producción DEBES implementar bcrypt o similar.

2. **LocalStorage en HTMLs:** Los archivos HTML actuales todavía usan localStorage. No están conectados al API REST. Debes modificarlos según MIGRACION_HTML.md.

3. **Sin HTTPS:** El sistema usa HTTP. En producción debes configurar HTTPS.

4. **CORS abierto:** El API permite cualquier origen (*). En producción restringe esto.

5. **Sin rate limiting:** No hay protección contra ataques de fuerza bruta. Implementa rate limiting en producción.

## 📞 Soporte

Si encuentras problemas:

1. **Revisar TROUBLESHOOTING.md** - Soluciones a problemas comunes
2. **Ver estado:** `.\manage.ps1 status`
3. **Ver logs:** `.\manage.ps1 logs`
4. **Resetear completamente:**
   ```powershell
   docker-compose down
   docker volume prune
   docker-compose up -d
   .\manage.ps1 init
   ```

## ✅ Checklist de Validación

Después de implementar, verifica que:

- [ ] El contenedor Docker está corriendo
- [ ] API /ping responde correctamente
- [ ] Puedes acceder a mysiss_cloud.html
- [ ] Puedes acceder a WebServiceLogin.html
- [ ] El script manage.ps1 funciona
- [ ] manage.ps1 status muestra todo en verde
- [ ] Puedes entrar al shell IRIS con manage.ps1 shell
- [ ] Existen las tablas en la BD (ver comando SQL en sección anterior)
- [ ] Existe el usuario admin en la BD

Si todos estos puntos están ✅, la implementación fue exitosa.

## 🎉 ¡Listo!

Ahora tienes:
- ✅ Un backend IRIS completamente funcional
- ✅ API REST operativa con autenticación
- ✅ Base de datos con estructura completa
- ✅ Super usuario creado
- ✅ Scripts de administración
- ✅ Documentación completa

El siguiente paso es migrar los archivos HTML para que usen el API REST en lugar de localStorage. Ver `MIGRACION_HTML.md` para la guía detallada.
