# Guía de Migración: localStorage → API REST

## 📋 Resumen

Los archivos HTML actuales utilizan `localStorage` para almacenar datos. Esto no es adecuado para una aplicación empresarial porque:
- Los datos solo existen en el navegador del usuario
- No hay persistencia real en la base de datos
- No hay validación de seguridad
- No se puede compartir información entre usuarios

Esta guía detalla cómo migrar a una arquitectura cliente-servidor usando el API REST de IRIS.

## 🎯 Objetivos

1. Reemplazar todo uso de `localStorage` con llamadas al API REST
2. Implementar autenticación basada en sesiones
3. Persistir todos los datos en la base de datos IRIS
4. Mantener la funcionalidad actual de la UI

## 🔧 Cambios Necesarios

### 1. Sistema de Autenticación

#### ❌ ANTES (localStorage)
```javascript
// WebServiceLogin.html
function login() {
    const username = document.getElementById("usuario").value;
    const password = document.getElementById("contrasena").value;
    
    // Almacenar en localStorage (inseguro)
    localStorage.setItem("loggedInUser", username);
    localStorage.setItem("userPassword", password);
    
    window.location.href = "mysiss_cloud.html";
}

function logout() {
    localStorage.removeItem("loggedInUser");
    localStorage.removeItem("userPassword");
    window.location.href = "WebServiceLogin.html";
}
```

#### ✅ DESPUÉS (API REST)
```javascript
// WebServiceLogin.html
async function login() {
    const username = document.getElementById("usuario").value;
    const password = document.getElementById("contrasena").value;
    
    try {
        const response = await fetch('/csp/mySissCloud/api/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            credentials: 'include', // Importante para sesiones
            body: JSON.stringify({ username, password })
        });
        
        const data = await response.json();
        
        if (data.success) {
            // Guardar info del usuario en sessionStorage (temporal)
            sessionStorage.setItem('user', JSON.stringify(data.user));
            window.location.href = "mysiss_cloud.html";
        } else {
            showError(data.error || 'Credenciales inválidas');
        }
    } catch (error) {
        showError('Error de conexión con el servidor');
        console.error('Login error:', error);
    }
}

async function logout() {
    try {
        await fetch('/csp/mySissCloud/api/logout', {
            method: 'POST',
            credentials: 'include'
        });
    } catch (error) {
        console.error('Logout error:', error);
    }
    
    sessionStorage.clear();
    window.location.href = "WebServiceLogin.html";
}

// Verificar sesión al cargar la página
async function checkSession() {
    try {
        const response = await fetch('/csp/mySissCloud/api/verify-session', {
            credentials: 'include'
        });
        
        const data = await response.json();
        
        if (!data.authenticated) {
            window.location.href = "WebServiceLogin.html";
        } else {
            sessionStorage.setItem('user', JSON.stringify(data.user));
        }
    } catch (error) {
        window.location.href = "WebServiceLogin.html";
    }
}

// Llamar al cargar páginas protegidas
document.addEventListener('DOMContentLoaded', checkSession);
```

### 2. Gestión de Datos de Usuarios

#### Archivo: app/Seguridad/conf_usua_1.html

#### ❌ ANTES
```javascript
// Guardar usuario
function guardarUsuario() {
    const usuarios = JSON.parse(localStorage.getItem('usuarios') || '[]');
    usuarios.push({
        id: Date.now(),
        nombre: document.getElementById('nombre').value,
        username: document.getElementById('username').value,
        // ...
    });
    localStorage.setItem('usuarios', JSON.stringify(usuarios));
}

// Listar usuarios
function listarUsuarios() {
    const usuarios = JSON.parse(localStorage.getItem('usuarios') || '[]');
    // Renderizar tabla
}
```

#### ✅ DESPUÉS
```javascript
// Crear nuevo endpoint en API.cls
ClassMethod CreateUser() As %Status
{
  // Leer datos del request
  Set tJSON = ##class(%DynamicObject).%FromJSON(%request.Content)
  
  // Validar permisos del usuario actual
  // ...
  
  // Insertar en BD
  &sql(INSERT INTO SG_User (...) VALUES (...))
  
  // Retornar resultado
  Quit ..WriteJSON(result)
}

// JavaScript frontend
async function guardarUsuario() {
    const userData = {
        nombre: document.getElementById('nombre').value,
        username: document.getElementById('username').value,
        // ...
    };
    
    try {
        const response = await fetch('/csp/mySissCloud/api/users', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            credentials: 'include',
            body: JSON.stringify(userData)
        });
        
        const data = await response.json();
        
        if (data.success) {
            showSuccess('Usuario creado exitosamente');
            listarUsuarios(); // Recargar lista
        } else {
            showError(data.error);
        }
    } catch (error) {
        showError('Error al guardar usuario');
    }
}

async function listarUsuarios() {
    try {
        const response = await fetch('/csp/mySissCloud/api/users', {
            credentials: 'include'
        });
        
        const data = await response.json();
        
        if (data.success) {
            renderizarTablaUsuarios(data.users);
        }
    } catch (error) {
        showError('Error al cargar usuarios');
    }
}
```

### 3. Módulo de Glosas

#### Archivos afectados:
- app/Glosas/radicacion.html
- app/Glosas/gestion.html
- app/Glosas/conciliacion.html

#### Patrón a seguir:

```javascript
// 1. Crear endpoints en API.cls
ClassMethod GetFacturas() As %Status { ... }
ClassMethod CreateFactura() As %Status { ... }
ClassMethod UpdateFactura(id) As %Status { ... }
ClassMethod DeleteFactura(id) As %Status { ... }

// 2. Modificar JavaScript frontend
const GlosasAPI = {
    async getFacturas(filtros = {}) {
        const params = new URLSearchParams(filtros);
        const response = await fetch(`/csp/mySissCloud/api/glosas/facturas?${params}`, {
            credentials: 'include'
        });
        return await response.json();
    },
    
    async createFactura(facturaData) {
        const response = await fetch('/csp/mySissCloud/api/glosas/facturas', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            credentials: 'include',
            body: JSON.stringify(facturaData)
        });
        return await response.json();
    },
    
    async updateFactura(id, updates) {
        const response = await fetch(`/csp/mySissCloud/api/glosas/facturas/${id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            credentials: 'include',
            body: JSON.stringify(updates)
        });
        return await response.json();
    },
    
    async deleteFactura(id) {
        const response = await fetch(`/csp/mySissCloud/api/glosas/facturas/${id}`, {
            method: 'DELETE',
            credentials: 'include'
        });
        return await response.json();
    }
};

// 3. Usar en la UI
async function cargarFacturas() {
    try {
        const data = await GlosasAPI.getFacturas({ estado: 'pendiente' });
        if (data.success) {
            renderizarFacturas(data.facturas);
        }
    } catch (error) {
        showError('Error al cargar facturas');
    }
}
```

## 📝 Checklist de Migración

### Fase 1: Autenticación ✅ (Ya implementado)
- [x] Endpoint /api/login
- [x] Endpoint /api/logout
- [x] Endpoint /api/verify-session
- [ ] Modificar WebServiceLogin.html
- [ ] Modificar mysiss_cloud.html
- [ ] Agregar verificación de sesión en todas las páginas

### Fase 2: Módulo de Seguridad
- [ ] Crear endpoints CRUD de usuarios
- [ ] Crear endpoints CRUD de roles
- [ ] Crear endpoints de asignación rol-usuario
- [ ] Crear endpoints de funcionalidades y actividades
- [ ] Modificar app/Seguridad/*.html

### Fase 3: Módulo de Glosas
- [ ] Diseñar tablas de glosas en DBInit.cls
- [ ] Crear endpoints de radicación
- [ ] Crear endpoints de gestión de glosas
- [ ] Crear endpoints de conciliación
- [ ] Crear endpoints de reportes
- [ ] Modificar app/Glosas/*.html

### Fase 4: Módulo de Honorarios
- [ ] Diseñar tablas de honorarios en DBInit.cls
- [ ] Crear endpoints de contratos
- [ ] Crear endpoints de liquidación
- [ ] Crear endpoints de validación
- [ ] Crear endpoints de reportes
- [ ] Modificar app/Honorarios/*.html

### Fase 5: Módulo de Auditoría
- [ ] Diseñar tablas de auditoría en DBInit.cls
- [ ] Crear endpoints de auditoría concurrente
- [ ] Crear endpoints de cuentas médicas
- [ ] Crear endpoints de configuración
- [ ] Modificar app/Auditoria/*.html

## 🏗️ Estructura de Endpoints Recomendada

```
/csp/mySissCloud/api/
├── /auth
│   ├── POST   /login
│   ├── POST   /logout
│   └── GET    /verify-session
│
├── /users
│   ├── GET    /           (listar)
│   ├── GET    /:id        (obtener uno)
│   ├── POST   /           (crear)
│   ├── PUT    /:id        (actualizar)
│   └── DELETE /:id        (eliminar)
│
├── /roles
│   ├── GET    /           (listar)
│   ├── POST   /           (crear)
│   ├── PUT    /:id        (actualizar)
│   └── DELETE /:id        (eliminar)
│
├── /glosas
│   ├── /facturas
│   │   ├── GET    /       (listar)
│   │   ├── POST   /       (radicar)
│   │   ├── PUT    /:id    (actualizar)
│   │   └── DELETE /:id    (anular)
│   ├── /glosas
│   │   ├── GET    /       (listar)
│   │   ├── POST   /       (crear)
│   │   └── PUT    /:id    (gestionar)
│   └── /reportes
│       └── GET    /       (generar)
│
├── /honorarios
│   ├── /contratos
│   ├── /liquidacion
│   └── /reportes
│
└── /auditoria
    ├── /concurrente
    ├── /cuentas
    └── /configuracion
```

## 🔒 Consideraciones de Seguridad

1. **Todas las páginas HTML** deben verificar sesión al cargar
2. **Todos los endpoints** deben validar autenticación
3. **Validar permisos** según el rol del usuario
4. **Sanitizar inputs** en frontend y backend
5. **Usar HTTPS** en producción
6. **Implementar rate limiting** para prevenir ataques
7. **Hashear contraseñas** con bcrypt (no texto plano)

## 📚 Recursos

- [Documentación IRIS REST](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GREST)
- [Fetch API MDN](https://developer.mozilla.org/es/docs/Web/API/Fetch_API)
- [Session Management Best Practices](https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html)

## 🎓 Ejemplo Completo: Página de Usuario

### Backend (API.cls)

```objectscript
/// Get all users
ClassMethod GetUsers() As %Status
{
  Try {
    // Check authentication
    Set userId = $Get(%session.Data("UserID"))
    If userId = "" Quit ..WriteError("No autenticado", 401)
    
    // Check permission
    // ... validar que tiene permiso SEG_USU_VER
    
    // Query users
    Set sql = "SELECT u.ID_user, u.Nombre_user, p.Nombre, p.Apellido, "_
              "u.Valido_de, u.Valido_hasta, u.Activo "_
              "FROM SG_User u "_
              "JOIN SG_Person p ON u.ID_Person = p.ID_Person "_
              "ORDER BY p.Nombre"
    
    Set stmt = ##class(%SQL.Statement).%New()
    Do stmt.%Prepare(sql)
    Set rset = stmt.%Execute()
    
    Set users = []
    While rset.%Next() {
      Set user = {
        "id": (rset.%Get("ID_user")),
        "username": (rset.%Get("Nombre_user")),
        "nombre": (rset.%Get("Nombre")),
        "apellido": (rset.%Get("Apellido")),
        "validoDe": (rset.%Get("Valido_de")),
        "validoHasta": (rset.%Get("Valido_hasta")),
        "activo": (rset.%Get("Activo"))
      }
      Do users.%Push(user)
    }
    
    Set obj = {}
    Set obj.success = 1
    Set obj.users = users
    
    Quit ..WriteJSON(obj)
    
  } Catch ex {
    Quit ..WriteError("Error: "_ex.DisplayString(), 500)
  }
}

/// Create new user
ClassMethod CreateUser() As %Status
{
  // Similar structure...
}
```

### Frontend (conf_usua_1.html)

```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios</title>
    <script src="../api-client.js"></script>
</head>
<body>
    <h1>Usuarios</h1>
    
    <button onclick="mostrarFormulario()">Nuevo Usuario</button>
    
    <div id="formulario" style="display:none;">
        <input type="text" id="nombre" placeholder="Nombre">
        <input type="text" id="username" placeholder="Usuario">
        <input type="password" id="password" placeholder="Contraseña">
        <button onclick="guardarUsuario()">Guardar</button>
        <button onclick="cancelar()">Cancelar</button>
    </div>
    
    <table id="tablaUsuarios">
        <thead>
            <tr>
                <th>ID</th>
                <th>Usuario</th>
                <th>Nombre</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
    
    <script>
        // Cargar usuarios al iniciar
        document.addEventListener('DOMContentLoaded', async () => {
            await checkSession(); // Definido en api-client.js
            await cargarUsuarios();
        });
        
        async function cargarUsuarios() {
            try {
                const response = await fetch('/csp/mySissCloud/api/users', {
                    credentials: 'include'
                });
                
                const data = await response.json();
                
                if (data.success) {
                    renderizarTabla(data.users);
                } else {
                    showError(data.error);
                }
            } catch (error) {
                showError('Error al cargar usuarios');
            }
        }
        
        function renderizarTabla(users) {
            const tbody = document.querySelector('#tablaUsuarios tbody');
            tbody.innerHTML = '';
            
            users.forEach(user => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${user.id}</td>
                    <td>${user.username}</td>
                    <td>${user.nombre} ${user.apellido}</td>
                    <td>${user.activo ? 'Activo' : 'Inactivo'}</td>
                    <td>
                        <button onclick="editarUsuario(${user.id})">Editar</button>
                        <button onclick="eliminarUsuario(${user.id})">Eliminar</button>
                    </td>
                `;
                tbody.appendChild(tr);
            });
        }
        
        async function guardarUsuario() {
            const userData = {
                nombre: document.getElementById('nombre').value,
                username: document.getElementById('username').value,
                password: document.getElementById('password').value
            };
            
            try {
                const response = await fetch('/csp/mySissCloud/api/users', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'include',
                    body: JSON.stringify(userData)
                });
                
                const data = await response.json();
                
                if (data.success) {
                    showSuccess('Usuario creado');
                    document.getElementById('formulario').style.display = 'none';
                    await cargarUsuarios();
                } else {
                    showError(data.error);
                }
            } catch (error) {
                showError('Error al guardar');
            }
        }
        
        function showSuccess(msg) {
            alert(msg); // Mejorar con toast/notification
        }
        
        function showError(msg) {
            alert('Error: ' + msg);
        }
    </script>
</body>
</html>
```

## ✅ Siguientes Pasos Inmediatos

1. **Actualizar WebServiceLogin.html** con el código de autenticación del API
2. **Crear api-client.js** con funciones comunes (checkSession, handleError, etc.)
3. **Probar login/logout** funcional
4. **Implementar un módulo completo** (ej: Usuarios) como prueba de concepto
5. **Replicar patrón** a los demás módulos

