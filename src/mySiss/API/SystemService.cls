Class mySiss.API.SystemService Extends %RegisteredObject
{

Include %occStatus

ClassMethod NewObj() As %DynamicObject
{
    Quit ##class(%DynamicObject).%New()
}

ClassMethod NewArr() As %DynamicArray
{
    Quit ##class(%DynamicArray).%New()
}

ClassMethod Obj(pK1 As %String = "", pV1 = "", pK2 As %String = "", pV2 = "", pK3 As %String = "", pV3 = "", pK4 As %String = "", pV4 = "", pK5 As %String = "", pV5 = "", pK6 As %String = "", pV6 = "", pK7 As %String = "", pV7 = "", pK8 As %String = "", pV8 = "", pK9 As %String = "", pV9 = "", pK10 As %String = "", pV10 = "", pK11 As %String = "", pV11 = "", pK12 As %String = "", pV12 = "") As %DynamicObject
{
    Set o = ..NewObj()
    If pK1'="" { Do o.%Set(pK1,pV1) }
    If pK2'="" { Do o.%Set(pK2,pV2) }
    If pK3'="" { Do o.%Set(pK3,pV3) }
    If pK4'="" { Do o.%Set(pK4,pV4) }
    If pK5'="" { Do o.%Set(pK5,pV5) }
    If pK6'="" { Do o.%Set(pK6,pV6) }
    If pK7'="" { Do o.%Set(pK7,pV7) }
    If pK8'="" { Do o.%Set(pK8,pV8) }
    If pK9'="" { Do o.%Set(pK9,pV9) }
    If pK10'="" { Do o.%Set(pK10,pV10) }
    If pK11'="" { Do o.%Set(pK11,pV11) }
    If pK12'="" { Do o.%Set(pK12,pV12) }
    Quit o
}

ClassMethod CurrentUserName() As %String
{
    Set tUser = $Get(%session.Data("username"))
    If tUser = "" {
        Set tUser = $Get(%request.CgiEnvs("HTTP_X_USER_NAME"))
    }
    Quit tUser
}

ClassMethod IsSuperUser() As %Boolean
{
    Set tExpected = ..Env("SUPERUSER_USERNAME", "ramiju")
    Quit ($ZConvert(..CurrentUserName(),"L") = $ZConvert(tExpected,"L"))
}

ClassMethod IsAdmin() As %Boolean
{
    Set tAdmin = ..Env("ADMIN_USERNAME", "mySiss")
    Set tUser = ..CurrentUserName()
    Quit ($ZConvert(tUser,"L") = $ZConvert(tAdmin,"L"))
}

ClassMethod Env(pName As %String, pDefault As %String = "") As %String
{
    Set tValue = $SYSTEM.Util.GetEnviron(pName)
    If tValue = "" {
        Quit pDefault
    }
    Quit tValue
}

ClassMethod GetSystemConfig() As %DynamicObject
{
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tRS = tStmt.%ExecDirect(, "SELECT TOP 1 ID_Config, environment, database_engine, backend_base_url, frontend_base_url, webapp_base_path, database_host, database_port, database_name, database_namespace, connection_status, last_check_at FROM mySiss_Config_MS.SystemConfig ORDER BY ID_Config")

    If 'tRS.%Next() {
        Set tObj = ..Obj("environment",..Env("MYSISS_ENV","local"),"database_engine",..Env("MYSISS_DB_ENGINE","iris"),"backend_base_url","","frontend_base_url","","webapp_base_path","/csp/mySissCloud","database_host",..Env("IRIS_HOST","localhost"),"database_port",+$Get(..Env("IRIS_SUPERSERVER","1972")),"database_name",..Env("IRIS_NAMESPACE","CNET"),"database_namespace",..Env("IRIS_NAMESPACE","CNET"),"connection_status","UNKNOWN","last_check_at","")
        Quit tObj
    }

    Set tObj = ..NewObj()
    Do tObj.%Set("id", +tRS.%Get("ID_Config"))
    Do tObj.%Set("environment", $Get(tRS.%Get("environment")))
    Do tObj.%Set("database_engine", $Get(tRS.%Get("database_engine")))
    Do tObj.%Set("backend_base_url", $Get(tRS.%Get("backend_base_url")))
    Do tObj.%Set("frontend_base_url", $Get(tRS.%Get("frontend_base_url")))
    Do tObj.%Set("webapp_base_path", $Get(tRS.%Get("webapp_base_path")))
    Do tObj.%Set("database_host", $Get(tRS.%Get("database_host")))
    Do tObj.%Set("database_port", +$Get(tRS.%Get("database_port")))
    Do tObj.%Set("database_name", $Get(tRS.%Get("database_name")))
    Do tObj.%Set("database_namespace", $Get(tRS.%Get("database_namespace")))
    Do tObj.%Set("connection_status", $Get(tRS.%Get("connection_status")))
    Do tObj.%Set("last_check_at", $ZDatetime($Get(tRS.%Get("last_check_at")),3,1))
    Quit tObj
}

ClassMethod SaveSystemConfig(pPayload As %DynamicObject) As %Status
{
    Set tCfg = ..SanitizeConfig(pPayload)
    Set tNow = $ZDATETIME($HOROLOG,3,1)
    Set tUser = ..CurrentUserName()

    Set tId = ..Scalar("SELECT TOP 1 ID_Config FROM mySiss_Config_MS.SystemConfig ORDER BY ID_Config")
    If tId = "" {
        Set tId = 1
        Quit ..Exec("INSERT INTO mySiss_Config_MS.SystemConfig (ID_Config, environment, database_engine, backend_base_url, frontend_base_url, webapp_base_path, database_host, database_port, database_name, database_namespace, connection_status, last_check_at, updated_at, updated_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, ?)", tId, tCfg.environment, tCfg.database_engine, tCfg.backend_base_url, tCfg.frontend_base_url, tCfg.webapp_base_path, tCfg.database_host, tCfg.database_port, tCfg.database_name, tCfg.database_namespace, "PENDING", tUser)
    }

    Quit ..Exec("UPDATE mySiss_Config_MS.SystemConfig SET environment = ?, database_engine = ?, backend_base_url = ?, frontend_base_url = ?, webapp_base_path = ?, database_host = ?, database_port = ?, database_name = ?, database_namespace = ?, updated_at = CURRENT_TIMESTAMP, updated_by = ? WHERE ID_Config = ?", tCfg.environment, tCfg.database_engine, tCfg.backend_base_url, tCfg.frontend_base_url, tCfg.webapp_base_path, tCfg.database_host, tCfg.database_port, tCfg.database_name, tCfg.database_namespace, tUser, tId)
}

ClassMethod SanitizeConfig(pPayload As %DynamicObject) As %DynamicObject
{
    Set t = ..NewObj()
    Set t.environment = ..NormalizeEnum($Get(pPayload.environment), "local", "dev", "prod", "local")
    Set t.database_engine = ..NormalizeEnum($Get(pPayload.database_engine), "iris", "sqlite", "iris")
    Set t.backend_base_url = $Extract($ZStrip($Get(pPayload.backend_base_url),"<>W"),1,500)
    Set t.frontend_base_url = $Extract($ZStrip($Get(pPayload.frontend_base_url),"<>W"),1,500)
    Set t.webapp_base_path = $Extract($ZStrip($Get(pPayload.webapp_base_path),"<>W"),1,200)
    Set t.database_host = $Extract($ZStrip($Get(pPayload.database_host),"<>W"),1,150)
    Set t.database_port = +$Get(pPayload.database_port)
    Set t.database_name = $Extract($ZStrip($Get(pPayload.database_name),"<>W"),1,150)
    Set t.database_namespace = $Extract($ZStrip($Get(pPayload.database_namespace),"<>W"),1,100)
    Quit t
}

ClassMethod NormalizeEnum(pValue As %String, pA As %String, pB As %String, pC As %String = "", pFallback As %String = "") As %String
{
    Set t = $ZConvert($Get(pValue),"L")
    If (t=$ZConvert(pA,"L"))!(t=$ZConvert(pB,"L")) {
        Quit t
    }
    If (pC '= "")&(t=$ZConvert(pC,"L")) {
        Quit t
    }
    Quit pFallback
}

ClassMethod GetDatabaseStatus() As %DynamicObject
{
    Set tCfg = ..GetSystemConfig()
    Set tEngine = $ZConvert($Get(tCfg.database_engine),"L")
    Set tEnv = $ZConvert($Get(tCfg.environment),"L")
    Set tStatus = ..NewObj()
    Do tStatus.%Set("engine", tEngine)

    If (tEnv="local")&(tEngine="sqlite") {
        Set tPath = ..Env("SQLITE_DB_PATH","")
        Do tStatus.%Set("sqlite_db_path", tPath)
        If tPath = "" {
            Do tStatus.%Set("status", "ERROR")
            Do tStatus.%Set("message", "SQLITE_DB_PATH no configurado")
            Quit tStatus
        }
                Set tExists = ##class(%File).Exists(tPath)
        If 'tExists {
            Set tFile=##class(%File).%New(tPath)
            Set tSC=tFile.Open("WSN")
            If $$$ISERR(tSC) {
                Do tStatus.%Set("status", "ERROR")
                Do tStatus.%Set("message", "No se pudo abrir archivo SQLite")
                Quit tStatus
            }
            Do tFile.Close()
        }
        Do tStatus.%Set("status", "OK")
        Do tStatus.%Set("message", "SQLite listo en ruta configurada")
        Quit tStatus
    }

    Try {
        Set tStmt = ##class(%SQL.Statement).%New()
        Set tRS = tStmt.%ExecDirect(, "SELECT 1 AS ok")
        If tRS.%Next() {
            Do tStatus.%Set("status", "OK")
            Do tStatus.%Set("message", "Conexion IRIS disponible")
        } Else {
            Do tStatus.%Set("status", "ERROR")
            Do tStatus.%Set("message", "Sin respuesta SQL")
        }
    } Catch ex {
        Do tStatus.%Set("status", "ERROR")
        Do tStatus.%Set("message", ex.DisplayString())
    }

    Quit tStatus
}

ClassMethod UpdateConnectionStatus() As %DynamicObject
{
    Set tStatus = ..GetDatabaseStatus()
    Set tId = ..Scalar("SELECT TOP 1 ID_Config FROM mySiss_Config_MS.SystemConfig ORDER BY ID_Config")
    If tId '= "" {
        Do ..Exec("UPDATE mySiss_Config_MS.SystemConfig SET connection_status = ?, last_check_at = CURRENT_TIMESTAMP WHERE ID_Config = ?", $Get(tStatus.status), tId)
    }
    Quit tStatus
}

ClassMethod ListClients() As %DynamicArray
{
    Set tArr = ..NewArr()
    Set tStmt = ##class(%SQL.Statement).%New()
    Set sql = "SELECT c.ID_Cliente, c.Nombre_Prest, c.Email_Prestador, CASE WHEN EXISTS (SELECT 1 FROM mySiss_Config_MS.ClienteMod cm WHERE cm.id_Prest = c.ID_Cliente AND cm.id_EstadoActual = 1) THEN 1 ELSE 0 END AS activo FROM mySiss_Config_MS.Cliente c ORDER BY c.ID_Cliente"
    Set tRS = tStmt.%ExecDirect(, sql)
    While tRS.%Next() {
        Do tArr.%Push(..Obj("id_cliente",+$Get(tRS.%Get("ID_Cliente")),"nombre",$Get(tRS.%Get("Nombre_Prest")),"email",$Get(tRS.%Get("Email_Prestador")),"activo",+$Get(tRS.%Get("activo"))))
    }
    Quit tArr
}

ClassMethod UpsertClient(pId As %Integer = 0, pPayload As %DynamicObject) As %Integer
{
    Set tNombre = $Extract($ZStrip($Get(pPayload.nombre_prest),"<>W"),1,250)
    Set tEmail = $Extract($ZStrip($Get(pPayload.email_prestador),"<>W"),1,180)
    If pId'>0 {
        Set pId = +..Scalar("SELECT COALESCE(MAX(ID_Cliente),0)+1 FROM mySiss_Config_MS.Cliente")
        Do ..Exec("INSERT INTO mySiss_Config_MS.Cliente (ID_Cliente, Nombre_Prest, Email_Prestador) VALUES (?, ?, ?)", pId, tNombre, tEmail)
        Quit pId
    }

    Do ..Exec("UPDATE mySiss_Config_MS.Cliente SET Nombre_Prest = ?, Email_Prestador = ? WHERE ID_Cliente = ?", tNombre, tEmail, pId)
    Quit pId
}

ClassMethod SetClientStatus(pClientId As %Integer, pActive As %Integer) As %Status
{
    Set tState = $Select(pActive=1:"ACTIVO",1:"INACTIVO")
    Set tClientModId = +..Scalar("SELECT TOP 1 ID_ClienteMod FROM mySiss_Config_MS.ClienteMod WHERE id_Prest = ? ORDER BY ID_ClienteMod DESC", pClientId)
    If tClientModId=0 {
        Set tClientModId = +..Scalar("SELECT COALESCE(MAX(ID_ClienteMod),0)+1 FROM mySiss_Config_MS.ClienteMod")
        Do ..Exec("INSERT INTO mySiss_Config_MS.ClienteMod (ID_ClienteMod, id_Prest, id_Mod, id_EstadoActual, Fecha_crea, UserCreado) VALUES (?, ?, NULL, ?, CURRENT_TIMESTAMP, 0)", tClientModId, pClientId, pActive)
    } Else {
        Do ..Exec("UPDATE mySiss_Config_MS.ClienteMod SET id_EstadoActual = ? WHERE ID_ClienteMod = ?", pActive, tClientModId)
    }

    Set tEstadoId = +..Scalar("SELECT COALESCE(MAX(ID_Estado),0)+1 FROM mySiss_Config_MS.ClienteModEstado")
    Quit ..Exec("INSERT INTO mySiss_Config_MS.ClienteModEstado (ID_Estado, ID_ClienteMod, Estado, Fecha_inicio, UserEvento, Fecha_evento) VALUES (?, ?, ?, CURRENT_TIMESTAMP, 0, CURRENT_TIMESTAMP)", tEstadoId, tClientModId, tState)
}

ClassMethod GetModuleCatalog() As %DynamicArray
{
    Set tArr = ..NewArr()
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tRS = tStmt.%ExecDirect(, "SELECT ID_Modulo, Cod_Modulo, Modulo FROM mySiss_Config_SG.Modulo WHERE $ZCONVERT(Modulo,'L') <> 'webservice' ORDER BY Modulo")
    While tRS.%Next() {
        Set tNombre = $Get(tRS.%Get("Modulo"))
        Set tSlug = ..NormalizeModuleSlug(tNombre)
        If tSlug'="" {
            Do tArr.%Push(..Obj("id_modulo",+tRS.%Get("ID_Modulo"),"codigo",$Get(tRS.%Get("Cod_Modulo")),"nombre",tNombre,"slug",tSlug,"entry_path",..ModuleSlugToPath(tSlug)))
        }
    }
    Quit tArr
}

ClassMethod GetClientModules(pClientId As %Integer) As %DynamicArray
{
    Set tArr = ..NewArr()
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tRS = tStmt.%ExecDirect(, "SELECT cm.ID_ClienteMod, cm.id_Mod, m.Modulo, cm.id_EstadoActual FROM mySiss_Config_MS.ClienteMod cm LEFT JOIN mySiss_Config_SG.Modulo m ON m.ID_Modulo = cm.id_Mod WHERE cm.id_Prest = ? AND cm.id_Mod IS NOT NULL ORDER BY m.Modulo", pClientId)
    While tRS.%Next() {
        Set tNombre = $Get(tRS.%Get("Modulo"))
        Set tSlug = ..NormalizeModuleSlug(tNombre)
        If tSlug'="" {
            Do tArr.%Push(..Obj("id_cliente_mod",+tRS.%Get("ID_ClienteMod"),"id_modulo",+tRS.%Get("id_Mod"),"modulo",tNombre,"slug",tSlug,"entry_path",..ModuleSlugToPath(tSlug),"activo",+$Get(tRS.%Get("id_EstadoActual"))))
        }
    }
    Quit tArr
}

ClassMethod ReplaceClientModules(pClientId As %Integer, pModules As %DynamicArray) As %Status
{
    Do ..Exec("DELETE FROM mySiss_Config_MS.ClienteMod WHERE id_Prest = ? AND id_Mod IS NOT NULL", pClientId)

    For i=1:1:pModules.%Size() {
        Set tModId = +pModules.%Get(i)
        If tModId>0 {
            Set tId = +..Scalar("SELECT COALESCE(MAX(ID_ClienteMod),0)+1 FROM mySiss_Config_MS.ClienteMod")
            Do ..Exec("INSERT INTO mySiss_Config_MS.ClienteMod (ID_ClienteMod, id_Prest, id_Mod, id_EstadoActual, Fecha_crea, UserCreado) VALUES (?, ?, ?, 1, CURRENT_TIMESTAMP, 0)", tId, pClientId, tModId)
        }
    }
    Quit $$$OK
}

ClassMethod GetUserContext() As %DynamicObject
{
    Set tUser = ..CurrentUserName()
    Set tCtx = ..Obj("authenticated",$Select(tUser'="":1,1:0),"username",tUser,"user_type","normal","client_id","","session_status",$Select(tUser'="":"ACTIVE",1:"NO_SESSION"),"modules",..NewArr(),"can_access_dashboard",0,"direct_module","","can_edit_sensitive_config",0)

    If tUser = "" Quit tCtx

    Set tIsSuper = ..IsSuperUser()
    Set tIsAdmin = ..IsAdmin()
    If tIsSuper {
        Do tCtx.%Set("user_type", "superusuario")
        Do tCtx.%Set("can_edit_sensitive_config", 1)
        Do tCtx.%Set("modules", ..GetModuleCatalog())
        Do tCtx.%Set("can_access_dashboard", 1)
        Quit tCtx
    }

    If tIsAdmin {
        Do tCtx.%Set("user_type", "administrador")
        Do tCtx.%Set("modules", ..GetModuleCatalog())
        Do tCtx.%Set("can_access_dashboard", 1)
        Quit tCtx
    }

    Set tClientId = +..Scalar("SELECT TOP 1 ID_Cliente FROM mySiss_Config_SG.""User"" WHERE Nombre_user = ?", tUser)
    If tClientId>0 {
        Do tCtx.%Set("client_id", tClientId)
        Do tCtx.%Set("modules", ..GetClientModules(tClientId))
    }

    Set tModules = $Get(tCtx.modules)
    Set tCount = $Select($IsObject(tModules):tModules.%Size(),1:0)
    If tCount>1 {
        Do tCtx.%Set("can_access_dashboard", 1)
    } ElseIf tCount=1 {
        Set tMod = tModules.%Get(1)
        Do tCtx.%Set("direct_module", $Get(tMod.slug))
    }

    Quit tCtx
}

ClassMethod ResolvePostLoginRoute() As %DynamicObject
{
    Set tCtx = ..GetUserContext()
    Set tResp = ..Obj("context",tCtx,"route","","route_type","dashboard")
    If '$Get(tCtx.authenticated) {
        Do tResp.%Set("route", "/csp/mySissCloud/app/Login/mySiss_Cloud_Login.html")
        Do tResp.%Set("route_type", "login")
        Quit tResp
    }

    If $Get(tCtx.user_type)="superusuario" {
        Do tResp.%Set("route", "/csp/mySissCloud/mysiss_cloud.html")
        Quit tResp
    }

    If $Get(tCtx.user_type)="administrador" {
        Do tResp.%Set("route", "/csp/mySissCloud/mysiss_cloud.html")
        Quit tResp
    }

    If $Get(tCtx.direct_module)'="" {
        Do tResp.%Set("route", ..ModuleSlugToPath($Get(tCtx.direct_module)))
        Do tResp.%Set("route_type", "direct_module")
        Quit tResp
    }

    If +$Get(tCtx.can_access_dashboard)=1 {
        Do tResp.%Set("route", "/csp/mySissCloud/mysiss_cloud.html")
        Quit tResp
    }

    Do tResp.%Set("route", "/csp/mySissCloud/mysiss_cloud.html?state=no-modules")
    Do tResp.%Set("route_type", "no_modules")
    Quit tResp
}

ClassMethod ModuleSlugToPath(pSlug As %String) As %String
{
    Set s = $ZConvert($Get(pSlug),"L")
    If s="auditoria" Quit "/csp/mySissCloud/app/Auditoria/Auditoria.html"
    If s="honorarios" Quit "/csp/mySissCloud/app/Honorarios/honorarios.html"
    If s="glosas" Quit "/csp/mySissCloud/app/Glosas/radicacion.html"
    If s="seguridad" Quit "/csp/mySissCloud/app/Seguridad/seg_gestion_usuario.html"
    If s="mysiss" Quit "/csp/mySissCloud/app/mySiss/system_base.html"
    Quit "/csp/mySissCloud/mysiss_cloud.html"
}

ClassMethod NormalizeModuleSlug(pName As %String) As %String
{
    Set n = $ZConvert($Get(pName),"L")
    If n["honor" Quit "honorarios"
    If n["glosa" Quit "glosas"
    If n["audit" Quit "auditoria"
    If n["segur" Quit "seguridad"
    If n["mysiss" Quit "mysiss"
    If n["webservice" Quit ""
    Quit $ZStrip(n, "<>W")
}

ClassMethod IsSecurityAdmin() As %Boolean
{
    Quit (..IsSuperUser() ! ..IsAdmin())
}

ClassMethod ListSecurityUsers() As %DynamicArray
{
    Set tArr = ..NewArr()
    Set sql = "SELECT u.ID_user, u.Nombre_user, u.ID_Cliente, p.Nombre, p.Apellido, COALESCE(pv.status,'A') AS status, ru.ID_rol, r.Rol FROM mySiss_Config_SG.""User"" u LEFT JOIN mySiss_Config_SG.Person p ON p.ID_Person = u.ID_Person LEFT JOIN mySiss_Config_SG.RolUser ru ON ru.ID_user = u.ID_user LEFT JOIN mySiss_Config_SG.Rol r ON r.ID_rol = ru.ID_rol LEFT JOIN mySiss_Config_SG.PerValidez pv ON pv.ID_user = u.ID_user ORDER BY u.ID_user"
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tRS = tStmt.%ExecDirect(, sql)
    While tRS.%Next() {
        Set tUserName = $Get(tRS.%Get("Nombre_user"))
        Do tArr.%Push(..Obj("id_user",+tRS.%Get("ID_user"),"username",tUserName,"full_name",$ZStrip($Get(tRS.%Get("Nombre"))_" "_$Get(tRS.%Get("Apellido")),"<>W"),"id_cliente",+$Get(tRS.%Get("ID_Cliente")),"status",$Select($Get(tRS.%Get("status"))="I":"INACTIVE",1:"ACTIVE"),"id_rol",+$Get(tRS.%Get("ID_rol")),"rol",$Get(tRS.%Get("Rol")),"is_superuser",$Select($ZConvert(tUserName,"L")=$ZConvert(..Env("SUPERUSER_USERNAME","ramiju"),"L"):1,1:0),"is_admin_base",$Select($ZConvert(tUserName,"L")=$ZConvert(..Env("ADMIN_USERNAME","mySiss"),"L"):1,1:0)))
    }
    Quit tArr
}

ClassMethod GetSecurityUserDetail(pUserId As %Integer) As %DynamicObject
{
    Set tStmt = ##class(%SQL.Statement).%New()
    Set sql = "SELECT TOP 1 u.ID_user, u.Nombre_user, u.ID_Cliente, u.ID_Person, u.ID_Password, p.Nombre, p.Apellido, COALESCE(pv.status,'A') AS status, ru.ID_rol, r.Rol FROM mySiss_Config_SG.""User"" u LEFT JOIN mySiss_Config_SG.Person p ON p.ID_Person = u.ID_Person LEFT JOIN mySiss_Config_SG.RolUser ru ON ru.ID_user = u.ID_user LEFT JOIN mySiss_Config_SG.Rol r ON r.ID_rol = ru.ID_rol LEFT JOIN mySiss_Config_SG.PerValidez pv ON pv.ID_user = u.ID_user WHERE u.ID_user = ?"
    Set tRS = tStmt.%ExecDirect(, sql, pUserId)
    If 'tRS.%Next() Quit ..NewObj()
    Set tUserName = $Get(tRS.%Get("Nombre_user"))
    Quit ..Obj("id_user",+tRS.%Get("ID_user"),"username",tUserName,"nombre",$Get(tRS.%Get("Nombre")),"apellido",$Get(tRS.%Get("Apellido")),"id_cliente",+$Get(tRS.%Get("ID_Cliente")),"status",$Select($Get(tRS.%Get("status"))="I":"INACTIVE",1:"ACTIVE"),"id_rol",+$Get(tRS.%Get("ID_rol")),"rol",$Get(tRS.%Get("Rol")),"is_superuser",$Select($ZConvert(tUserName,"L")=$ZConvert(..Env("SUPERUSER_USERNAME","ramiju"),"L"):1,1:0),"is_admin_base",$Select($ZConvert(tUserName,"L")=$ZConvert(..Env("ADMIN_USERNAME","mySiss"),"L"):1,1:0))
}

ClassMethod SaveSecurityUser(pUserId As %Integer = 0, pPayload As %DynamicObject) As %DynamicObject
{
    Set tUsername = $Extract($ZStrip($Get(pPayload.username),"<>W"),1,60)
    Set tNombre = $Extract($ZStrip($Get(pPayload.nombre),"<>W"),1,100)
    Set tApellido = $Extract($ZStrip($Get(pPayload.apellido),"<>W"),1,100)
    Set tPassword = $Extract($Get(pPayload.password),1,255)
    Set tClientId = +$Get(pPayload.id_cliente)
    Set tRolId = +$Get(pPayload.id_rol)

    If tUsername="" Quit ..Obj("ok",0,"error","USERNAME_REQUIRED")

    Set tExisting = +..Scalar("SELECT TOP 1 ID_user FROM mySiss_Config_SG.""User"" WHERE Nombre_user = ?", tUsername)
    If (pUserId=0),(tExisting>0) Quit ..Obj("ok",0,"error","USERNAME_DUPLICATE")
    If (pUserId>0),(tExisting>0),(tExisting'=pUserId) Quit ..Obj("ok",0,"error","USERNAME_DUPLICATE")

    If pUserId=0 {
        Set pUserId = +..Scalar("SELECT COALESCE(MAX(ID_user),0)+1 FROM mySiss_Config_SG.""User""")
        Set tPersonId = +..Scalar("SELECT COALESCE(MAX(ID_Person),0)+1 FROM mySiss_Config_SG.Person")
        Set tPassId = +..Scalar("SELECT COALESCE(MAX(ID_Passw),0)+1 FROM mySiss_Config_SG.Passw")
        Do ..Exec("INSERT INTO mySiss_Config_SG.Person (ID_Person, Nombre, Apellido, Fecha_crea, UserCreado) VALUES (?, ?, ?, CURRENT_TIMESTAMP, 0)", tPersonId, tNombre, tApellido)
        Do ..Exec("INSERT INTO mySiss_Config_SG.Passw (ID_Passw, Passw_hash, Fecha_crea, UserCreado) VALUES (?, ?, CURRENT_TIMESTAMP, 0)", tPassId, tPassword)
        Do ..Exec("INSERT INTO mySiss_Config_SG.""User"" (ID_user, ID_Cliente, ID_Person, Nombre_user, ID_Password, Valido_de, Valido_hasta, Fecha_crea, UserCreado) VALUES (?, ?, ?, ?, ?, CURRENT_DATE, '2099-12-31', CURRENT_TIMESTAMP, 0)", pUserId, $Select(tClientId>0:tClientId,1:""), tPersonId, tUsername, tPassId)
    } Else {
        Set tCurrent = ..GetSecurityUserDetail(pUserId)
        If '$IsObject(tCurrent) Quit ..Obj("ok",0,"error","USER_NOT_FOUND")
        Set tPersonId = +..Scalar("SELECT ID_Person FROM mySiss_Config_SG.""User"" WHERE ID_user = ?", pUserId)
        If tPersonId>0 {
            Do ..Exec("UPDATE mySiss_Config_SG.Person SET Nombre = ?, Apellido = ?, Fecha_modif = CURRENT_TIMESTAMP WHERE ID_Person = ?", tNombre, tApellido, tPersonId)
        }
        Do ..Exec("UPDATE mySiss_Config_SG.""User"" SET Nombre_user = ?, ID_Cliente = ?, Fecha_modif = CURRENT_TIMESTAMP WHERE ID_user = ?", tUsername, $Select(tClientId>0:tClientId,1:""), pUserId)
        If tPassword'="" {
            Set tPassId = +..Scalar("SELECT ID_Password FROM mySiss_Config_SG.""User"" WHERE ID_user = ?", pUserId)
            If tPassId>0 {
                Do ..Exec("UPDATE mySiss_Config_SG.Passw SET Passw_hash = ?, Fecha_modif = CURRENT_TIMESTAMP WHERE ID_Passw = ?", tPassword, tPassId)
            }
        }
    }

    Do ..SetUserRole(pUserId, tRolId)
    Do ..EnsureUserStatusRow(pUserId)
    Quit ..Obj("ok",1,"id_user",pUserId)
}

ClassMethod EnsureUserStatusRow(pUserId As %Integer)
{
    Set tId = +..Scalar("SELECT TOP 1 ID_PerValidez FROM mySiss_Config_SG.PerValidez WHERE ID_user = ?", pUserId)
    If tId>0 Quit
    Set tId = +..Scalar("SELECT COALESCE(MAX(ID_PerValidez),0)+1 FROM mySiss_Config_SG.PerValidez")
    Set tMotivo = +..Scalar("SELECT TOP 1 ID_motivo FROM mySiss_Config_SG.Motivo")
    If tMotivo=0 {
        Set tMotivo = +..Scalar("SELECT COALESCE(MAX(ID_motivo),0)+1 FROM mySiss_Config_SG.Motivo")
        Do ..Exec("INSERT INTO mySiss_Config_SG.Motivo (ID_motivo, motivo, Fecha_crea, UserCreado) VALUES (?, 'ALTA USUARIO', CURRENT_TIMESTAMP, 0)", tMotivo)
    }
    Do ..Exec("INSERT INTO mySiss_Config_SG.PerValidez (ID_PerValidez, ID_user, ID_motivo, status, valido_de, valido_hasta, Fecha_crea, UserCreado) VALUES (?, ?, ?, 'A', CURRENT_DATE, '2099-12-31', CURRENT_TIMESTAMP, 0)", tId, pUserId, tMotivo)
}

ClassMethod SetSecurityUserStatus(pUserId As %Integer, pActive As %Boolean) As %Status
{
    Do ..EnsureUserStatusRow(pUserId)
    Set tStatus = $Select(pActive:"A",1:"I")
    Quit ..Exec("UPDATE mySiss_Config_SG.PerValidez SET status = ?, Fecha_modif = CURRENT_TIMESTAMP WHERE ID_user = ?", tStatus, pUserId)
}

ClassMethod SetUserRole(pUserId As %Integer, pRolId As %Integer)
{
    Do ..Exec("DELETE FROM mySiss_Config_SG.RolUser WHERE ID_user = ?", pUserId)
    If pRolId>0 {
        Set tId = +..Scalar("SELECT COALESCE(MAX(ID_roluser),0)+1 FROM mySiss_Config_SG.RolUser")
        Do ..Exec("INSERT INTO mySiss_Config_SG.RolUser (ID_roluser, ID_user, ID_rol, Fecha_crea, UserCreado) VALUES (?, ?, ?, CURRENT_TIMESTAMP, 0)", tId, pUserId, pRolId)
    }
}

ClassMethod ListSecurityRoles() As %DynamicArray
{
    Set tArr = ..NewArr()
    Set tStmt = ##class(%SQL.Statement).%New()
    Set sql = "SELECT r.ID_rol, r.Rol, COALESCE(rs.status,'ACTIVE') AS status FROM mySiss_Config_SG.Rol r LEFT JOIN mySiss_Config_SG.RolStatus rs ON rs.ID_rol = r.ID_rol ORDER BY r.ID_rol"
    Set tRS = tStmt.%ExecDirect(, sql)
    While tRS.%Next() {
        Do tArr.%Push(..Obj("id_rol",+tRS.%Get("ID_rol"),"rol",$Get(tRS.%Get("Rol")),"status",$Get(tRS.%Get("status"))))
    }
    Quit tArr
}

ClassMethod SaveSecurityRole(pRolId As %Integer = 0, pPayload As %DynamicObject) As %DynamicObject
{
    Set tName = $Extract($ZStrip($Get(pPayload.rol),"<>W"),1,120)
    If tName="" Quit ..Obj("ok",0,"error","ROL_REQUIRED")
    Set tExisting = +..Scalar("SELECT TOP 1 ID_rol FROM mySiss_Config_SG.Rol WHERE Rol = ?", tName)
    If (pRolId=0),(tExisting>0) Quit ..Obj("ok",0,"error","ROL_DUPLICATE")
    If (pRolId>0),(tExisting>0),(tExisting'=pRolId) Quit ..Obj("ok",0,"error","ROL_DUPLICATE")
    If pRolId=0 {
        Set pRolId = +..Scalar("SELECT COALESCE(MAX(ID_rol),0)+1 FROM mySiss_Config_SG.Rol")
        Do ..Exec("INSERT INTO mySiss_Config_SG.Rol (ID_rol, Rol, Fecha_crea, UserCreado) VALUES (?, ?, CURRENT_TIMESTAMP, 0)", pRolId, tName)
    } Else {
        Do ..Exec("UPDATE mySiss_Config_SG.Rol SET Rol = ?, Fecha_modif = CURRENT_TIMESTAMP WHERE ID_rol = ?", tName, pRolId)
    }
    Do ..EnsureRoleStatus(pRolId)
    Quit ..Obj("ok",1,"id_rol",pRolId)
}

ClassMethod EnsureRoleStatus(pRolId As %Integer)
{
    Set tId = +..Scalar("SELECT TOP 1 ID_RolStatus FROM mySiss_Config_SG.RolStatus WHERE ID_rol = ?", pRolId)
    If tId>0 Quit
    Set tId = +..Scalar("SELECT COALESCE(MAX(ID_RolStatus),0)+1 FROM mySiss_Config_SG.RolStatus")
    Do ..Exec("INSERT INTO mySiss_Config_SG.RolStatus (ID_RolStatus, ID_rol, status, updated_at) VALUES (?, ?, 'ACTIVE', CURRENT_TIMESTAMP)", tId, pRolId)
}

ClassMethod SetSecurityRoleStatus(pRolId As %Integer, pActive As %Boolean) As %Status
{
    Do ..EnsureRoleStatus(pRolId)
    Set tStatus = $Select(pActive:"ACTIVE",1:"INACTIVE")
    Quit ..Exec("UPDATE mySiss_Config_SG.RolStatus SET status = ?, updated_at = CURRENT_TIMESTAMP WHERE ID_rol = ?", tStatus, pRolId)
}

ClassMethod GetRolePermissions(pRolId As %Integer) As %DynamicArray
{
    Set tArr = ..NewArr()
    Set sql = "SELECT rm.ID_actividad, a.Actividad, f.Funcion, m.Modulo, rm.Crear, rm.Modificar, rm.Visualizar, rm.Eliminar FROM mySiss_Config_SG.RolModulo rm LEFT JOIN mySiss_Config_SG.Actividad a ON a.ID_actividad = rm.ID_actividad LEFT JOIN mySiss_Config_SG.Funcion f ON f.ID_Funcion = a.ID_funcion LEFT JOIN mySiss_Config_SG.Modulo m ON m.ID_Modulo = f.ID_Modulo WHERE rm.ID_rol = ? ORDER BY m.Modulo, f.Funcion, a.Actividad"
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tRS = tStmt.%ExecDirect(, sql, pRolId)
    While tRS.%Next() {
        Do tArr.%Push(..Obj("id_actividad",+tRS.%Get("ID_actividad"),"modulo",$Get(tRS.%Get("Modulo")),"funcion",$Get(tRS.%Get("Funcion")),"actividad",$Get(tRS.%Get("Actividad")),"crear",$Get(tRS.%Get("Crear")),"modificar",$Get(tRS.%Get("Modificar")),"visualizar",$Get(tRS.%Get("Visualizar")),"eliminar",$Get(tRS.%Get("Eliminar"))))
    }
    Quit tArr
}

ClassMethod SaveRolePermissions(pRolId As %Integer, pPermissions As %DynamicArray) As %Status
{
    Do ..Exec("DELETE FROM mySiss_Config_SG.RolModulo WHERE ID_rol = ?", pRolId)
    For i=1:1:pPermissions.%Size() {
        Set tItem = pPermissions.%Get(i)
        Set tAct = +$Get(tItem.id_actividad)
        If tAct>0 {
            Set tId = +..Scalar("SELECT COALESCE(MAX(ID_rolmodulo),0)+1 FROM mySiss_Config_SG.RolModulo")
            Do ..Exec("INSERT INTO mySiss_Config_SG.RolModulo (ID_rolmodulo, ID_rol, ID_actividad, Crear, Modificar, Visualizar, Eliminar, Fecha_crea, UserCreado) VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, 0)", tId, pRolId, tAct, $Select(+$Get(tItem.crear)=1:"Y",1:"N"), $Select(+$Get(tItem.modificar)=1:"Y",1:"N"), $Select(+$Get(tItem.visualizar)=1:"Y",1:"N"), $Select(+$Get(tItem.eliminar)=1:"Y",1:"N"))
        }
    }
    Quit $$$OK
}

ClassMethod ListSecurityClients() As %DynamicArray
{
    Set tArr = ..NewArr()
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tRS = tStmt.%ExecDirect(, "SELECT ID_Cliente, Nombre_Prest FROM mySiss_Config_MS.Cliente ORDER BY Nombre_Prest")
    While tRS.%Next() {
        Do tArr.%Push(..Obj("id_cliente",+tRS.%Get("ID_Cliente"),"nombre",$Get(tRS.%Get("Nombre_Prest"))))
    }
    Quit tArr
}

ClassMethod Scalar(pSQL As %String, p1 = "", p2 = "") As %String
{
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tCode = tStmt.%Prepare(pSQL)
    If tCode '= 1 Quit ""

    If p2 '= "" {
        Set tRS = tStmt.%Execute(p1,p2)
    } ElseIf p1 '= "" {
        Set tRS = tStmt.%Execute(p1)
    } Else {
        Set tRS = tStmt.%Execute()
    }

    If tRS.%Next() Quit tRS.%Get(1)
    Quit ""
}

ClassMethod Exec(pSQL As %String, p1 = "", p2 = "", p3 = "", p4 = "", p5 = "", p6 = "", p7 = "", p8 = "", p9 = "", p10 = "", p11 = "") As %Status
{
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tSC = tStmt.%Prepare(pSQL)
    If tSC '= 1 Quit $$$ERROR($$$GeneralError, "Error preparando SQL")

    If p11 '= "" {
        Set tRS = tStmt.%Execute(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11)
    } ElseIf p10 '= "" {
        Set tRS = tStmt.%Execute(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10)
    } ElseIf p9 '= "" {
        Set tRS = tStmt.%Execute(p1,p2,p3,p4,p5,p6,p7,p8,p9)
    } ElseIf p8 '= "" {
        Set tRS = tStmt.%Execute(p1,p2,p3,p4,p5,p6,p7,p8)
    } ElseIf p7 '= "" {
        Set tRS = tStmt.%Execute(p1,p2,p3,p4,p5,p6,p7)
    } ElseIf p6 '= "" {
        Set tRS = tStmt.%Execute(p1,p2,p3,p4,p5,p6)
    } ElseIf p5 '= "" {
        Set tRS = tStmt.%Execute(p1,p2,p3,p4,p5)
    } ElseIf p4 '= "" {
        Set tRS = tStmt.%Execute(p1,p2,p3,p4)
    } ElseIf p3 '= "" {
        Set tRS = tStmt.%Execute(p1,p2,p3)
    } ElseIf p2 '= "" {
        Set tRS = tStmt.%Execute(p1,p2)
    } ElseIf p1 '= "" {
        Set tRS = tStmt.%Execute(p1)
    } Else {
        Set tRS = tStmt.%Execute()
    }

    If tStmt.%SQLCODE < 0 Quit $$$ERROR($$$GeneralError, "Error ejecutando SQL")
    Quit $$$OK
}


ClassMethod IsWSAdmin() As %Boolean
{
    Quit ..IsSecurityAdmin()
}

ClassMethod SanitizeWSIntegrationPayload(pPayload As %DynamicObject) As %DynamicObject
{
    Set t = ..NewObj()
    Set t.nombre = $Extract($ZStrip($Get(pPayload.nombre),"<>W"),1,150)
    Set t.descripcion = $Extract($Get(pPayload.descripcion),1,500)
    Set t.metodo_http = ..NormalizeEnum($Get(pPayload.metodo_http),"GET","POST","","GET")
    Set t.url_base = $Extract($Get(pPayload.url_base),1,500)
    Set t.endpoint = $Extract($Get(pPayload.endpoint),1,500)
    Set t.tipo_autenticacion = $Extract($ZStrip($Get(pPayload.tipo_autenticacion),"<>W"),1,40)
    Set t.headers = $Extract($Get(pPayload.headers),1,4000)
    Set t.body_template = $Extract($Get(pPayload.body_template),1,8000)
    Set t.timeout = +$Get(pPayload.timeout)
    If t.timeout'>0 Set t.timeout = 30
    If t.timeout>120 Set t.timeout = 120
    Set t.activo = $Select(+$Get(pPayload.activo)=0:0,1:1)
    Quit t
}

ClassMethod ListWSIntegrations() As %DynamicArray
{
    Set tArr = ..NewArr()
    Set sql = "SELECT id_integracion, nombre, descripcion, metodo_http, url_base, endpoint, tipo_autenticacion, headers, body_template, timeout, activo, fecha_creacion, fecha_actualizacion FROM mySiss_Config_WS.WSIntegracion ORDER BY id_integracion"
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tRS = tStmt.%ExecDirect(, sql)
    While tRS.%Next() {
        Do tArr.%Push(..Obj("id_integracion",+$Get(tRS.%Get("id_integracion")),"nombre",$Get(tRS.%Get("nombre")),"descripcion",$Get(tRS.%Get("descripcion")),"metodo_http",$Get(tRS.%Get("metodo_http")),"url_base",$Get(tRS.%Get("url_base")),"endpoint",$Get(tRS.%Get("endpoint")),"tipo_autenticacion",$Get(tRS.%Get("tipo_autenticacion")),"headers",$Get(tRS.%Get("headers")),"body_template",$Get(tRS.%Get("body_template")),"timeout",+$Get(tRS.%Get("timeout")),"activo",+$Get(tRS.%Get("activo")),"fecha_creacion",$ZDATETIME($Get(tRS.%Get("fecha_creacion")),3,1),"fecha_actualizacion",$ZDATETIME($Get(tRS.%Get("fecha_actualizacion")),3,1)))
    }
    Quit tArr
}

ClassMethod GetWSIntegration(pId As %Integer) As %DynamicObject
{
    Set tStmt = ##class(%SQL.Statement).%New()
    Set sql = "SELECT TOP 1 id_integracion, nombre, descripcion, metodo_http, url_base, endpoint, tipo_autenticacion, headers, body_template, timeout, activo, fecha_creacion, fecha_actualizacion FROM mySiss_Config_WS.WSIntegracion WHERE id_integracion = ?"
    Set tRS = tStmt.%ExecDirect(, sql, pId)
    If 'tRS.%Next() Quit ..NewObj()
    Quit ..Obj("id_integracion",+$Get(tRS.%Get("id_integracion")),"nombre",$Get(tRS.%Get("nombre")),"descripcion",$Get(tRS.%Get("descripcion")),"metodo_http",$Get(tRS.%Get("metodo_http")),"url_base",$Get(tRS.%Get("url_base")),"endpoint",$Get(tRS.%Get("endpoint")),"tipo_autenticacion",$Get(tRS.%Get("tipo_autenticacion")),"headers",$Get(tRS.%Get("headers")),"body_template",$Get(tRS.%Get("body_template")),"timeout",+$Get(tRS.%Get("timeout")),"activo",+$Get(tRS.%Get("activo")),"fecha_creacion",$ZDATETIME($Get(tRS.%Get("fecha_creacion")),3,1),"fecha_actualizacion",$ZDATETIME($Get(tRS.%Get("fecha_actualizacion")),3,1))
}

ClassMethod SaveWSIntegration(pId As %Integer = 0, pPayload As %DynamicObject) As %DynamicObject
{
    Set tData = ..SanitizeWSIntegrationPayload(pPayload)
    If $Get(tData.nombre)="" Quit ..Obj("ok",0,"error","NOMBRE_REQUIRED")

    If pId'>0 {
        Set pId = +..Scalar("SELECT COALESCE(MAX(id_integracion),0)+1 FROM mySiss_Config_WS.WSIntegracion")
        Set tSC = ..Exec("INSERT INTO mySiss_Config_WS.WSIntegracion (id_integracion, nombre, descripcion, metodo_http, url_base, endpoint, tipo_autenticacion, headers, body_template, timeout, activo, fecha_creacion, fecha_actualizacion) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)", pId, tData.nombre, tData.descripcion, tData.metodo_http, tData.url_base, tData.endpoint, tData.tipo_autenticacion, tData.headers, tData.body_template, tData.timeout, tData.activo)
        If $$$ISERR(tSC) Quit ..Obj("ok",0,"error","INSERT_FAILED")
        Quit ..Obj("ok",1,"id_integracion",pId)
    }

    Set tSC = ..Exec("UPDATE mySiss_Config_WS.WSIntegracion SET nombre = ?, descripcion = ?, metodo_http = ?, url_base = ?, endpoint = ?, tipo_autenticacion = ?, headers = ?, body_template = ?, timeout = ?, activo = ?, fecha_actualizacion = CURRENT_TIMESTAMP WHERE id_integracion = ?", tData.nombre, tData.descripcion, tData.metodo_http, tData.url_base, tData.endpoint, tData.tipo_autenticacion, tData.headers, tData.body_template, tData.timeout, tData.activo, pId)
    If $$$ISERR(tSC) Quit ..Obj("ok",0,"error","UPDATE_FAILED")
    Quit ..Obj("ok",1,"id_integracion",pId)
}

ClassMethod SetWSIntegrationStatus(pId As %Integer, pActive As %Integer) As %Status
{
    Quit ..Exec("UPDATE mySiss_Config_WS.WSIntegracion SET activo = ?, fecha_actualizacion = CURRENT_TIMESTAMP WHERE id_integracion = ?", $Select(pActive=1:1,1:0), pId)
}

ClassMethod ListWSClientIntegrations(pClientId As %Integer) As %DynamicArray
{
    Set tArr = ..NewArr()
    Set sql = "SELECT r.id_rel, r.id_cliente, r.id_integracion, r.activo, r.configuracion, i.nombre, i.metodo_http, i.url_base, i.endpoint, i.activo AS integracion_activa FROM mySiss_Config_WS.WSClienteIntegracion r INNER JOIN mySiss_Config_WS.WSIntegracion i ON i.id_integracion = r.id_integracion WHERE r.id_cliente = ? ORDER BY i.nombre"
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tRS = tStmt.%ExecDirect(, sql, pClientId)
    While tRS.%Next() {
        Do tArr.%Push(..Obj("id_rel",+$Get(tRS.%Get("id_rel")),"id_cliente",+$Get(tRS.%Get("id_cliente")),"id_integracion",+$Get(tRS.%Get("id_integracion")),"nombre",$Get(tRS.%Get("nombre")),"metodo_http",$Get(tRS.%Get("metodo_http")),"url_base",$Get(tRS.%Get("url_base")),"endpoint",$Get(tRS.%Get("endpoint")),"activo",+$Get(tRS.%Get("activo")),"integracion_activa",+$Get(tRS.%Get("integracion_activa")),"configuracion",$Get(tRS.%Get("configuracion"))))
    }
    Quit tArr
}

ClassMethod SaveWSClientIntegrations(pClientId As %Integer, pItems As %DynamicArray) As %Status
{
    For i=1:1:pItems.%Size() {
        Set tItem = pItems.%Get(i)
        Set tIntId = +$Get(tItem.id_integracion)
        Set tActive = $Select(+$Get(tItem.activo)=0:0,1:1)
        Set tCfg = $Extract($Get(tItem.configuracion),1,4000)
        If tIntId>0 {
            Set tRelId = +..Scalar("SELECT TOP 1 id_rel FROM mySiss_Config_WS.WSClienteIntegracion WHERE id_cliente = ? AND id_integracion = ?", pClientId, tIntId)
            If tRelId>0 {
                Set tSC = ..Exec("UPDATE mySiss_Config_WS.WSClienteIntegracion SET activo = ?, configuracion = ?, fecha_actualizacion = CURRENT_TIMESTAMP WHERE id_rel = ?", tActive, tCfg, tRelId)
            } Else {
                Set tRelId = +..Scalar("SELECT COALESCE(MAX(id_rel),0)+1 FROM mySiss_Config_WS.WSClienteIntegracion")
                Set tSC = ..Exec("INSERT INTO mySiss_Config_WS.WSClienteIntegracion (id_rel, id_cliente, id_integracion, activo, configuracion, fecha_creacion, fecha_actualizacion) VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)", tRelId, pClientId, tIntId, tActive, tCfg)
            }
            If $$$ISERR(tSC) Quit tSC
        }
    }
    Quit $$$OK
}

ClassMethod SetWSClientIntegrationStatus(pRelId As %Integer, pActive As %Integer) As %Status
{
    Quit ..Exec("UPDATE mySiss_Config_WS.WSClienteIntegracion SET activo = ?, fecha_actualizacion = CURRENT_TIMESTAMP WHERE id_rel = ?", $Select(pActive=1:1,1:0), pRelId)
}

ClassMethod SaveWSExecutionLog(pIntegrationId As %Integer, pClientId As %Integer, pEstado As %String, pMensaje As %String, pResponse As %String, pError As %String, pHttpCode As %Integer, pModulo As %String = "") As %Integer
{
    Set tLogId = +..Scalar("SELECT COALESCE(MAX(id_log),0)+1 FROM mySiss_Config_WS.WSIntegracionLog")
    Set tUser = ..CurrentUserName()
    Set tEstado = ..NormalizeEnum(pEstado, "OK", "ERROR", "", "ERROR")
    Do ..Exec("INSERT INTO mySiss_Config_WS.WSIntegracionLog (id_log, id_integracion, id_cliente, fecha_ejecucion, estado, mensaje, response_resumido, error, usuario_ejecucion, modulo_origen, codigo_http) VALUES (?, ?, ?, CURRENT_TIMESTAMP, ?, ?, ?, ?, ?, ?, ?)", tLogId, pIntegrationId, pClientId, tEstado, $Extract(pMensaje,1,500), $Extract(pResponse,1,4000), $Extract(pError,1,4000), $Extract(tUser,1,120), $Extract(pModulo,1,80), pHttpCode)
    Quit tLogId
}

ClassMethod ExecuteWSIntegration(pPayload As %DynamicObject) As %DynamicObject
{
    Set tIntegrationId = +$Get(pPayload.id_integracion)
    Set tClientId = +$Get(pPayload.id_cliente)
    Set tModulo = $Extract($Get(pPayload.modulo_origen),1,80)
    Set tBody = $Get(pPayload.body)
    Set tResult = ..Obj("ok",0,"estado","ERROR","mensaje","EXECUTION_FAILED","status_code",0,"response","","error","")

    Set tIntegration = ..GetWSIntegration(tIntegrationId)
    If '$IsObject(tIntegration) Quit tResult
    If +$Get(tIntegration.id_integracion)=0 {
        Set tResult.mensaje = "INTEGRATION_NOT_FOUND"
        Do ..SaveWSExecutionLog(tIntegrationId, tClientId, "ERROR", "INTEGRATION_NOT_FOUND", "", "No existe integración", 0, tModulo)
        Quit tResult
    }

    If +$Get(tIntegration.activo)'=1 {
        Set tResult.mensaje = "INTEGRATION_INACTIVE"
        Do ..SaveWSExecutionLog(tIntegrationId, tClientId, "ERROR", "INTEGRATION_INACTIVE", "", "Integración inactiva", 0, tModulo)
        Quit tResult
    }

    If tClientId>0 {
        Set tRelActive = +..Scalar("SELECT TOP 1 activo FROM mySiss_Config_WS.WSClienteIntegracion WHERE id_cliente = ? AND id_integracion = ?", tClientId, tIntegrationId)
        If tRelActive'=1 {
            Set tResult.mensaje = "CLIENT_INTEGRATION_INACTIVE"
            Do ..SaveWSExecutionLog(tIntegrationId, tClientId, "ERROR", "CLIENT_INTEGRATION_INACTIVE", "", "Cliente sin integración activa", 0, tModulo)
            Quit tResult
        }
    }

    Set tHttp = ##class(%Net.HttpRequest).%New()
    Set tTimeout = +$Get(tIntegration.timeout)
    If tTimeout'>0 Set tTimeout = 30
    Set tHttp.Timeout = tTimeout

    Set tURLBase = $Get(tIntegration.url_base)
    Set tEndpoint = $Get(tIntegration.endpoint)
    Set tUrl = tURLBase_tEndpoint

    Try {
        Set tHeaders = $Get(tIntegration.headers)
        If tHeaders'="" {
            Set tHeadObj = ##class(%DynamicAbstractObject).%FromJSON(tHeaders)
            If $IsObject(tHeadObj),($IsA(tHeadObj,"%DynamicObject")) {
                Set tIter = tHeadObj.%GetIterator()
                While tIter.%GetNext(.k,.v) {
                    Do tHttp.SetHeader(k,$Get(v))
                }
            }
        }
    } Catch ex {
    }

    Set tMethod = ..NormalizeEnum($Get(tIntegration.metodo_http),"GET","POST","","GET")
    Try {
        If tMethod="POST" {
            Set tRawBody = $Get(tBody)
            If tRawBody="" {
                Set tRawBody = $Get(tIntegration.body_template)
            }
            If tRawBody'="" {
                Do tHttp.EntityBody.Write(tRawBody)
                Do tHttp.SetHeader("Content-Type","application/json")
            }
            Set tSC = tHttp.Post(tUrl)
        } Else {
            Set tSC = tHttp.Get(tUrl)
        }

        If $$$ISERR(tSC) {
            Set tErr = $SYSTEM.Status.GetErrorText(tSC)
            Set tResult.error = tErr
            Set tResult.mensaje = "HTTP_REQUEST_FAILED"
            Do ..SaveWSExecutionLog(tIntegrationId, tClientId, "ERROR", "HTTP_REQUEST_FAILED", "", tErr, 0, tModulo)
            Quit tResult
        }

        Set tResp = ""
        If $IsObject(tHttp.HttpResponse.Data) {
            Set tResp = tHttp.HttpResponse.Data.Read()
        }

        Set tCode = +$Get(tHttp.HttpResponse.StatusCode)
        Set tOk = $Select((tCode>=200)&(tCode<300):1,1:0)
        Do tResult.%Set("ok", tOk)
        Do tResult.%Set("estado", $Select(tOk=1:"OK",1:"ERROR"))
        Do tResult.%Set("mensaje", $Select(tOk=1:"EXECUTION_OK",1:"HTTP_STATUS_ERROR"))
        Do tResult.%Set("status_code", tCode)
        Do tResult.%Set("response", $Extract(tResp,1,4000))
        If tOk=0 {
            Do tResult.%Set("error", "Respuesta HTTP no exitosa")
        }
        Do ..SaveWSExecutionLog(tIntegrationId, tClientId, $Get(tResult.estado), $Get(tResult.mensaje), $Get(tResult.response), $Get(tResult.error), tCode, tModulo)
    } Catch ex {
        Set tErr = ex.DisplayString()
        Do tResult.%Set("ok", 0)
        Do tResult.%Set("estado", "ERROR")
        Do tResult.%Set("mensaje", "EXCEPTION")
        Do tResult.%Set("error", tErr)
        Do ..SaveWSExecutionLog(tIntegrationId, tClientId, "ERROR", "EXCEPTION", "", tErr, 0, tModulo)
    }

    Quit tResult
}

ClassMethod ListWSLogsByIntegration(pIntegrationId As %Integer) As %DynamicArray
{
    Set tArr = ..NewArr()
    Set sql = "SELECT id_log, id_integracion, id_cliente, fecha_ejecucion, estado, mensaje, response_resumido, error, usuario_ejecucion, modulo_origen, codigo_http FROM mySiss_Config_WS.WSIntegracionLog WHERE id_integracion = ? ORDER BY id_log DESC"
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tRS = tStmt.%ExecDirect(, sql, pIntegrationId)
    While tRS.%Next() {
        Do tArr.%Push(..Obj("id_log",+$Get(tRS.%Get("id_log")),"id_integracion",+$Get(tRS.%Get("id_integracion")),"id_cliente",+$Get(tRS.%Get("id_cliente")),"fecha_ejecucion",$ZDATETIME($Get(tRS.%Get("fecha_ejecucion")),3,1),"estado",$Get(tRS.%Get("estado")),"mensaje",$Get(tRS.%Get("mensaje")),"response_resumido",$Get(tRS.%Get("response_resumido")),"error",$Get(tRS.%Get("error")),"usuario_ejecucion",$Get(tRS.%Get("usuario_ejecucion")),"modulo_origen",$Get(tRS.%Get("modulo_origen")),"codigo_http",+$Get(tRS.%Get("codigo_http"))))
    }
    Quit tArr
}

ClassMethod ListWSLogsByClient(pClientId As %Integer) As %DynamicArray
{
    Set tArr = ..NewArr()
    Set sql = "SELECT id_log, id_integracion, id_cliente, fecha_ejecucion, estado, mensaje, response_resumido, error, usuario_ejecucion, modulo_origen, codigo_http FROM mySiss_Config_WS.WSIntegracionLog WHERE id_cliente = ? ORDER BY id_log DESC"
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tRS = tStmt.%ExecDirect(, sql, pClientId)
    While tRS.%Next() {
        Do tArr.%Push(..Obj("id_log",+$Get(tRS.%Get("id_log")),"id_integracion",+$Get(tRS.%Get("id_integracion")),"id_cliente",+$Get(tRS.%Get("id_cliente")),"fecha_ejecucion",$ZDATETIME($Get(tRS.%Get("fecha_ejecucion")),3,1),"estado",$Get(tRS.%Get("estado")),"mensaje",$Get(tRS.%Get("mensaje")),"response_resumido",$Get(tRS.%Get("response_resumido")),"error",$Get(tRS.%Get("error")),"usuario_ejecucion",$Get(tRS.%Get("usuario_ejecucion")),"modulo_origen",$Get(tRS.%Get("modulo_origen")),"codigo_http",+$Get(tRS.%Get("codigo_http"))))
    }
    Quit tArr
}

ClassMethod GetWSLogDetail(pLogId As %Integer) As %DynamicObject
{
    Set tStmt = ##class(%SQL.Statement).%New()
    Set sql = "SELECT TOP 1 id_log, id_integracion, id_cliente, fecha_ejecucion, estado, mensaje, response_resumido, error, usuario_ejecucion, modulo_origen, codigo_http FROM mySiss_Config_WS.WSIntegracionLog WHERE id_log = ?"
    Set tRS = tStmt.%ExecDirect(, sql, pLogId)
    If 'tRS.%Next() Quit ..NewObj()
    Quit ..Obj("id_log",+$Get(tRS.%Get("id_log")),"id_integracion",+$Get(tRS.%Get("id_integracion")),"id_cliente",+$Get(tRS.%Get("id_cliente")),"fecha_ejecucion",$ZDATETIME($Get(tRS.%Get("fecha_ejecucion")),3,1),"estado",$Get(tRS.%Get("estado")),"mensaje",$Get(tRS.%Get("mensaje")),"response_resumido",$Get(tRS.%Get("response_resumido")),"error",$Get(tRS.%Get("error")),"usuario_ejecucion",$Get(tRS.%Get("usuario_ejecucion")),"modulo_origen",$Get(tRS.%Get("modulo_origen")),"codigo_http",+$Get(tRS.%Get("codigo_http")))
}

}
