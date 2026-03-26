Class mySiss.API.SystemService Extends %RegisteredObject
{

Include %occStatus

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
        Set tObj = {
            "environment":(..Env("MYSISS_ENV","local")),
            "database_engine":(..Env("MYSISS_DB_ENGINE","iris")),
            "backend_base_url":"",
            "frontend_base_url":"",
            "webapp_base_path":"/csp/mySissCloud",
            "database_host":(..Env("IRIS_HOST","localhost")),
            "database_port":+$Get(..Env("IRIS_SUPERSERVER","1972")),
            "database_name":(..Env("IRIS_NAMESPACE","CNET")),
            "database_namespace":(..Env("IRIS_NAMESPACE","CNET")),
            "connection_status":"UNKNOWN",
            "last_check_at":""
        }
        Quit tObj
    }

    Set tObj = {}
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
    Set t = {}
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
    If (pC '= "")&&(t=$ZConvert(pC,"L")) {
        Quit t
    }
    Quit pFallback
}

ClassMethod GetDatabaseStatus() As %DynamicObject
{
    Set tCfg = ..GetSystemConfig()
    Set tEngine = $ZConvert($Get(tCfg.database_engine),"L")
    Set tEnv = $ZConvert($Get(tCfg.environment),"L")
    Set tStatus = {}
    Do tStatus.%Set("engine", tEngine)

    If (tEnv="local")&&(tEngine="sqlite") {
        Set tPath = ..Env("SQLITE_DB_PATH","")
        Do tStatus.%Set("sqlite_db_path", tPath)
        If tPath = "" {
            Do tStatus.%Set("status", "ERROR")
            Do tStatus.%Set("message", "SQLITE_DB_PATH no configurado")
            Quit tStatus
        }
        Set tSC = ##class(%File).NormalizeDirectory($Piece(tPath,"/",1,*-1), .tDir)
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
    Set tArr = []
    Set tStmt = ##class(%SQL.Statement).%New()
    Set sql = "SELECT c.ID_Cliente, c.Nombre_Prest, c.Email_Prestador, CASE WHEN EXISTS (SELECT 1 FROM mySiss_Config_MS.ClienteMod cm WHERE cm.id_Prest = c.ID_Cliente AND cm.id_EstadoActual = 1) THEN 1 ELSE 0 END AS activo FROM mySiss_Config_MS.Cliente c ORDER BY c.ID_Cliente"
    Set tRS = tStmt.%ExecDirect(, sql)
    While tRS.%Next() {
        Do tArr.%Push({
            "id_cliente": +tRS.%Get("ID_Cliente"),
            "nombre": $Get(tRS.%Get("Nombre_Prest")),
            "email": $Get(tRS.%Get("Email_Prestador")),
            "activo": +tRS.%Get("activo")
        })
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
    Set tArr = []
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tRS = tStmt.%ExecDirect(, "SELECT ID_Modulo, Cod_Modulo, Modulo FROM mySiss_Config_SG.Modulo WHERE $ZCONVERT(Modulo,'L') <> 'webservice' ORDER BY Modulo")
    While tRS.%Next() {
        Do tArr.%Push({"id_modulo":+tRS.%Get("ID_Modulo"),"codigo":$Get(tRS.%Get("Cod_Modulo")),"nombre":$Get(tRS.%Get("Modulo"))})
    }
    Quit tArr
}

ClassMethod GetClientModules(pClientId As %Integer) As %DynamicArray
{
    Set tArr = []
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tRS = tStmt.%ExecDirect(, "SELECT cm.ID_ClienteMod, cm.id_Mod, m.Modulo, cm.id_EstadoActual FROM mySiss_Config_MS.ClienteMod cm LEFT JOIN mySiss_Config_SG.Modulo m ON m.ID_Modulo = cm.id_Mod WHERE cm.id_Prest = ? AND cm.id_Mod IS NOT NULL ORDER BY m.Modulo", pClientId)
    While tRS.%Next() {
        Do tArr.%Push({"id_cliente_mod":+tRS.%Get("ID_ClienteMod"),"id_modulo":+tRS.%Get("id_Mod"),"modulo":$Get(tRS.%Get("Modulo")),"activo":+$Get(tRS.%Get("id_EstadoActual"))})
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

}
