/// Configuración de WebApp REST en IRIS
/// Corrige: Access Denied creando namespace CNET si no existe
Class mySiss.Config.WebApp Extends %RegisteredObject
{

ClassMethod Run() As %Status
{
    Write "--- Configurando WebApp mySiss ---",!

    // 1. Crear namespace CNET si no existe
    Do ..EnsureNamespace()

    // 2. Configurar CSP para HTML
    Do ..SetupCSPApp()

    // 3. Configurar REST API
    Do ..SetupRESTApp()

    // 4. Crear usuario IRIS ABAP
    Do ..SetupUser()

    Write " WebApp configurada OK",!
    Quit $$$OK
}

ClassMethod EnsureNamespace() As %Status
{
    // Verificar si CNET existe
    If ##class(Config.Namespaces).Exists("CNET") {
        Write " Namespace CNET ya existe",!
        Quit $$$OK
    }

    Write " Creando namespace CNET...",!

    // Crear database si no existe
    Set dbPath = "/dur/irisdata/CNET/"
    If '##class(%Library.File).DirectoryExists(dbPath) {
        Do ##class(%Library.File).CreateDirectoryChain(dbPath)
    }

    // Crear la base de datos
    Set dbProps = ##class(Config.Databases).%New()
    Set dbProps.Directory = dbPath
    Set sc = ##class(Config.Databases).Create("CNET", dbProps)
    If $$$ISERR(sc) {
        // Intentar con path alternativo
        Set dbPath = "/home/irisowner/irisdata/CNET/"
        Do ##class(%Library.File).CreateDirectoryChain(dbPath)
        Set dbProps.Directory = dbPath
        Set sc = ##class(Config.Databases).Create("CNET", dbProps)
        If $$$ISERR(sc) {
            Write " [WARN] No se pudo crear DB CNET: ",$system.Status.GetErrorText(sc),!
            Write " Intentando usar USER namespace...",!
            // Fallback a USER
            Set ^mySiss.Namespace = "USER"
            Quit $$$OK
        }
    }

    // Crear namespace CNET
    Set nsProps = ##class(Config.Namespaces).%New()
    Set nsProps.Globals  = "CNET"
    Set nsProps.Routines = "CNET"
    Set sc = ##class(Config.Namespaces).Create("CNET", nsProps)
    If $$$ISERR(sc) {
        Write " [WARN] Error creando namespace: ",$system.Status.GetErrorText(sc),!
    } Else {
        Write " Namespace CNET creado",!
        Set ^mySiss.Namespace = "CNET"
    }
    Quit $$$OK
}

ClassMethod SetupCSPApp() As %Status
{
    Set appName = "/csp/mySissCloud"
    If ##class(Security.Applications).Exists(appName) {
        Write " CSP App ya existe: "_appName,!
        Quit $$$OK
    }
    Set app = ##class(Security.Applications).%New()
    Set app.Name         = appName
    Set app.Path         = "/usr/irissys/csp/mySissCloud/"
    Set app.NameSpace    = $Get(^mySiss.Namespace, "USER")
    Set app.Enabled      = $$$YES
    Set app.AutheEnabled = 32   // Unauthenticated
    Set app.Description  = "mySiss Cloud - Frontend"
    Set sc = app.%Save()
    If $$$ISERR(sc) {
        Write " [WARN] CSP App: ",$system.Status.GetErrorText(sc),!
    } Else {
        Write " CSP App creada: "_appName,!
    }
    Quit $$$OK
}

ClassMethod SetupRESTApp() As %Status
{
    Set appName = "/csp/mySissCloud/api"
    If ##class(Security.Applications).Exists(appName) {
        Write " REST App ya existe: "_appName,!
        Quit $$$OK
    }
    Set app = ##class(Security.Applications).%New()
    Set app.Name          = appName
    Set app.NameSpace     = $Get(^mySiss.Namespace, "USER")
    Set app.Enabled       = $$$YES
    Set app.AutheEnabled  = 32
    Set app.DispatchClass = "mySiss.conn.API"
    Set app.Description   = "mySiss Cloud - REST API"
    Set sc = app.%Save()
    If $$$ISERR(sc) {
        Write " [WARN] REST App: ",$system.Status.GetErrorText(sc),!
    } Else {
        Write " REST App creada: "_appName,!
    }
    Quit $$$OK
}

ClassMethod SetupUser() As %Status
{
    If ##class(Security.Users).Exists("ABAP") {
        Write " Usuario IRIS ABAP ya existe",!
        Quit $$$OK
    }
    Set sc = ##class(Security.Users).Create("ABAP", "%All", "ABAPMYSISS")
    If $$$ISERR(sc) {
        Write " [WARN] No se pudo crear usuario ABAP: ",$system.Status.GetErrorText(sc),!
    } Else {
        Write " Usuario IRIS ABAP creado (password: ABAPMYSISS)",!
    }
    Quit $$$OK
}

}
