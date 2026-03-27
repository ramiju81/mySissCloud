Include %occStatus

Class mySiss.init.SeedUsers Extends %RegisteredObject
{

ClassMethod Run() As %Integer
{
    Quit ..Process(0)
}

ClassMethod Rebuild() As %Integer
{
    Quit ..Process(1)
}

ClassMethod RunSQL() As %Integer [ SqlProc ]
{
    Quit ..Run()
}

ClassMethod Process(pReset As %Integer = 0) As %Integer
{
    New $Namespace
    Set $Namespace = "MYSISS"

    Set tOK = 1

    Try {
        TSTART

        If pReset = 1 {
            Do ..ResetSeedUsers()
        }

        Do ..SeedRamiju()
        Do ..SeedMySiss()

        TCOMMIT
        Write !, "Seed ejecutado correctamente", !
    } Catch ex {
        TROLLBACK
        Set tOK = 0
        Write !, "ERROR: ", ex.DisplayString(), !
    }

    Quit tOK
}

ClassMethod SeedRamiju()
{
    Set tRolRef   = ..GetOrCreateRol("SUPERADMIN")
    Set tCelRef   = ..GetOrCreateCelular("3183863532")
    Set tEmailRef = ..GetOrCreateEmail("juliram81@hotmail.com")
    Set tPassRef  = ..CreatePassword(..HashPassword("16931356Jr."))

    Set tPersonRef = ..GetOrCreatePerson(
        "Julian",
        "Alberto",
        "Ramirez",
        "Caicedo",
        1,
        "TEMP-ADMIN-001",
        tCelRef,
        tEmailRef
    )

    Set tUserRef = ..GetOrCreateUser("ramiju", tPersonRef, tPassRef)

    Do ..EnsureRolUser(tUserRef, tRolRef)
    Do ..EnsurePerValidez(tUserRef, "ALTA INICIAL SUPERADMIN")

    Write !, "Usuario ramiju procesado", !
    Quit
}

ClassMethod SeedMySiss()
{
    Set tRolRef   = ..GetOrCreateRol("ADMIN")
    Set tCelRef   = ..GetOrCreateCelular("3000000001")
    Set tEmailRef = ..GetOrCreateEmail("julian.ramirez@mysiss.com")
    Set tPassRef  = ..CreatePassword(..HashPassword("mySiss123."))

    Set tPersonRef = ..GetOrCreatePerson(
        "mySiss",
        "",
        "Admin",
        "",
        1,
        "TEMP-ADMIN-002",
        tCelRef,
        tEmailRef
    )

    Set tUserRef = ..GetOrCreateUser("mySiss", tPersonRef, tPassRef)

    Do ..EnsureRolUser(tUserRef, tRolRef)
    Do ..EnsurePerValidez(tUserRef, "ALTA INICIAL ADMIN")

    Write !, "Usuario mySiss procesado", !
    Quit
}

ClassMethod ResetSeedUsers()
{
    // 1) borrar relaciones de usuarios semilla
    Do ..DeleteUserChain("ramiju")
    Do ..DeleteUserChain("mySiss")

    // 2) borrar personas semilla
    Do ..Exec("DELETE FROM mySiss_Config_SG.Person WHERE ID_Tipo_Doc = ? AND Cedula = ?", 1, "TEMP-ADMIN-001")
    Do ..Exec("DELETE FROM mySiss_Config_SG.Person WHERE ID_Tipo_Doc = ? AND Cedula = ?", 1, "TEMP-ADMIN-002")

    // 3) borrar emails semilla
    Do ..Exec("DELETE FROM mySiss_Config_SG.Email WHERE Email = ?", "juliram81@hotmail.com")
    Do ..Exec("DELETE FROM mySiss_Config_SG.Email WHERE Email = ?", "admin@mysiss.com")

    // 4) borrar celulares semilla
    Do ..Exec("DELETE FROM mySiss_Config_SG.Celular WHERE Celular = ?", "3000000000")
    Do ..Exec("DELETE FROM mySiss_Config_SG.Celular WHERE Celular = ?", "3000000001")

    // 5) borrar passwords huérfanas
    Do ..Exec("DELETE FROM mySiss_Config_SG.Passw WHERE %ID NOT IN (SELECT ID_Password FROM mySiss_Config_SG.""User"")")

    Write !, "Reset de usuarios semilla completado", !
    Quit
}

ClassMethod DeleteUserChain(pUserName As %String)
{
    Set tUserRef = ..Scalar("SELECT %ID FROM mySiss_Config_SG.""User"" WHERE Nombre_user = ?", pUserName)
    If tUserRef="" Quit

    Do ..Exec("DELETE FROM mySiss_Config_SG.PerValidez WHERE ID_user = ?", tUserRef)
    Do ..Exec("DELETE FROM mySiss_Config_SG.RolUser WHERE ID_user = ?", tUserRef)
    Do ..Exec("DELETE FROM mySiss_Config_SG.""User"" WHERE %ID = ?", tUserRef)

    Quit
}

ClassMethod HashPassword(pPassword As %String) As %String
{
    Set tStream = ##class(%Stream.GlobalBinary).%New()
    Do tStream.Write(pPassword)

    Set tHash = $SYSTEM.Encryption.SHAHashStream(256, tStream)

    Quit $SYSTEM.Encryption.Base64Encode(tHash)
}

ClassMethod GetOrCreateRol(pRol As %String) As %Integer
{
    Set tObjId = ..Scalar("SELECT %ID FROM mySiss_Config_SG.Rol WHERE Rol = ?", pRol)
    If tObjId'="" Quit +tObjId

    Set tBusinessId = ..NextId("mySiss_Config_SG.Rol", "ID_rol")
    Do ..Exec("INSERT INTO mySiss_Config_SG.Rol (ID_rol, Rol, Fecha_crea, UserCreado) VALUES (?, ?, CURRENT_TIMESTAMP, 0)", tBusinessId, pRol)

    Set tObjId = ..Scalar("SELECT %ID FROM mySiss_Config_SG.Rol WHERE Rol = ?", pRol)
    If tObjId="" {
        Throw ##class(%Exception.General).%New("No se insertó Rol: "_pRol)
    }

    Quit +tObjId
}

ClassMethod GetOrCreateCelular(pCelular As %String) As %Integer
{
    Set tObjId = ..Scalar("SELECT %ID FROM mySiss_Config_SG.Celular WHERE Celular = ?", pCelular)
    If tObjId'="" Quit +tObjId

    Set tBusinessId = ..NextId("mySiss_Config_SG.Celular", "ID_Celular")
    Do ..Exec("INSERT INTO mySiss_Config_SG.Celular (ID_Celular, Celular, Fecha_crea, UserCreado) VALUES (?, ?, CURRENT_TIMESTAMP, 0)", tBusinessId, pCelular)

    Set tObjId = ..Scalar("SELECT %ID FROM mySiss_Config_SG.Celular WHERE Celular = ?", pCelular)
    If tObjId="" {
        Throw ##class(%Exception.General).%New("No se insertó Celular: "_pCelular)
    }

    Quit +tObjId
}

ClassMethod GetOrCreateEmail(pEmail As %String) As %Integer
{
    Set tObjId = ..Scalar("SELECT %ID FROM mySiss_Config_SG.Email WHERE Email = ?", pEmail)
    If tObjId'="" Quit +tObjId

    Set tBusinessId = ..NextId("mySiss_Config_SG.Email", "ID_Email")
    Do ..Exec("INSERT INTO mySiss_Config_SG.Email (ID_Email, Email) VALUES (?, ?)", tBusinessId, pEmail)

    Set tObjId = ..Scalar("SELECT %ID FROM mySiss_Config_SG.Email WHERE Email = ?", pEmail)
    If tObjId="" {
        Throw ##class(%Exception.General).%New("No se insertó Email: "_pEmail)
    }

    Quit +tObjId
}

ClassMethod CreatePassword(pPasswHash As %String) As %Integer
{
    Set tBusinessId = ..NextId("mySiss_Config_SG.Passw", "ID_Passw")
    Do ..Exec("INSERT INTO mySiss_Config_SG.Passw (ID_Passw, Passw_hash, Fecha_crea, UserCreado) VALUES (?, ?, CURRENT_TIMESTAMP, 0)", tBusinessId, pPasswHash)

    Set tObjId = ..Scalar("SELECT %ID FROM mySiss_Config_SG.Passw WHERE ID_Passw = ?", tBusinessId)
    If tObjId="" {
        Throw ##class(%Exception.General).%New("No se insertó Password. ID="_tBusinessId)
    }

    Quit +tObjId
}

ClassMethod GetOrCreatePerson(pNombre As %String, pNombre2 As %String, pApellido As %String, pApellido2 As %String, pTipoDoc As %Integer, pDocumento As %String, pCelObjId As %Integer, pEmailObjId As %Integer) As %Integer
{
    Set tObjId = ..Scalar("SELECT %ID FROM mySiss_Config_SG.Person WHERE ID_Tipo_Doc = ? AND Cedula = ?", pTipoDoc, pDocumento)
    If tObjId'="" Quit +tObjId

    Set tBusinessId = ..NextId("mySiss_Config_SG.Person", "ID_Person")
    Do ..Exec("INSERT INTO mySiss_Config_SG.Person (ID_Person, Nombre, Nombre2, Apellido, Apellido2, ID_Tipo_Doc, Cedula, ID_Celular, ID_Email, Fecha_crea, UserCreado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, 0)",
        tBusinessId, pNombre, pNombre2, pApellido, pApellido2, pTipoDoc, pDocumento, pCelObjId, pEmailObjId)

    Set tObjId = ..Scalar("SELECT %ID FROM mySiss_Config_SG.Person WHERE ID_Tipo_Doc = ? AND Cedula = ?", pTipoDoc, pDocumento)
    If tObjId="" {
        Throw ##class(%Exception.General).%New("No se insertó Person: "_pDocumento)
    }

    Quit +tObjId
}

ClassMethod GetOrCreateUser(pUserName As %String, pPersonObjId As %Integer, pPassObjId As %Integer) As %Integer
{
    Set tObjId = ..Scalar("SELECT %ID FROM mySiss_Config_SG.""User"" WHERE Nombre_user = ?", pUserName)
    If tObjId'="" Quit +tObjId

    Set tBusinessId = ..NextId("mySiss_Config_SG.""User""", "ID_user")
    Set tValidoDe = $PIECE($HOROLOG,",",1)
    Set tValidoHasta = $ZDATEH("2099-12-31",3)

    Do ..Exec("INSERT INTO mySiss_Config_SG.""User"" (ID_user, ID_Cliente, ID_Person, Nombre_user, ID_Password, Valido_de, Valido_hasta, Fecha_crea, UserCreado) VALUES (?, NULL, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, 0)",
        tBusinessId, pPersonObjId, pUserName, pPassObjId, tValidoDe, tValidoHasta)

    Set tObjId = ..Scalar("SELECT %ID FROM mySiss_Config_SG.""User"" WHERE Nombre_user = ?", pUserName)
    If tObjId="" {
        Throw ##class(%Exception.General).%New("No se insertó User: "_pUserName)
    }

    Quit +tObjId
}

ClassMethod EnsureRolUser(pUserObjId As %Integer, pRolObjId As %Integer)
{
    Set tId = ..Scalar("SELECT %ID FROM mySiss_Config_SG.RolUser WHERE ID_user = ? AND ID_rol = ?", pUserObjId, pRolObjId)
    If tId'="" Quit

    Set tBusinessId = ..NextId("mySiss_Config_SG.RolUser", "ID_roluser")
    Do ..Exec("INSERT INTO mySiss_Config_SG.RolUser (ID_roluser, ID_user, ID_rol, Fecha_crea, UserCreado) VALUES (?, ?, ?, CURRENT_TIMESTAMP, 0)",
        tBusinessId, pUserObjId, pRolObjId)

    Quit
}

ClassMethod EnsurePerValidez(pUserObjId As %Integer, pMotivo As %String)
{
    Set tMotivoObjId = ..GetOrCreateMotivo(pMotivo)

    Set tId = ..Scalar("SELECT %ID FROM mySiss_Config_SG.PerValidez WHERE ID_user = ?", pUserObjId)
    If tId'="" Quit

    Set tBusinessId = ..NextId("mySiss_Config_SG.PerValidez", "ID_PerValidez")
    Set tValidoDe = $PIECE($HOROLOG,",",1)
    Set tValidoHasta = $ZDATEH("2099-12-31",3)

    Do ..Exec("INSERT INTO mySiss_Config_SG.PerValidez (ID_PerValidez, ID_user, ID_motivo, status, valido_de, valido_hasta, Fecha_crea, UserCreado) VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, 0)",
        tBusinessId, pUserObjId, tMotivoObjId, "A", tValidoDe, tValidoHasta)

    Quit
}

ClassMethod GetOrCreateMotivo(pMotivo As %String) As %Integer
{
    Set tObjId = ..Scalar("SELECT %ID FROM mySiss_Config_SG.Motivo WHERE motivo = ?", pMotivo)
    If tObjId'="" Quit +tObjId

    Set tBusinessId = ..NextId("mySiss_Config_SG.Motivo", "ID_motivo")
    Do ..Exec("INSERT INTO mySiss_Config_SG.Motivo (ID_motivo, motivo, Fecha_crea, UserCreado) VALUES (?, ?, CURRENT_TIMESTAMP, 0)",
        tBusinessId, pMotivo)

    Set tObjId = ..Scalar("SELECT %ID FROM mySiss_Config_SG.Motivo WHERE motivo = ?", pMotivo)
    If tObjId="" {
        Throw ##class(%Exception.General).%New("No se insertó Motivo: "_pMotivo)
    }

    Quit +tObjId
}

ClassMethod NextId(pTable As %String, pColumn As %String) As %Integer
{
    Set tSQL = "SELECT COALESCE(MAX("_pColumn_"),0)+1 AS NextId FROM "_pTable
    Set tNextId = 1

    Try {
        Set tStmt = ##class(%SQL.Statement).%New()
        Set tSC = tStmt.%Prepare(tSQL)
        If $$$ISERR(tSC) {
            Throw ##class(%Exception.General).%New($System.Status.GetErrorText(tSC))
        }

        Set tRS = tStmt.%Execute()
        If tRS.%SQLCODE < 0 {
            Throw ##class(%Exception.General).%New("SQLCODE="_tRS.%SQLCODE_" MSG="_tRS.%Message)
        }

        If tRS.%Next() {
            Set tNextId = +tRS.%Get("NextId")
        }
    } Catch ex {
        Throw ##class(%Exception.General).%New("NextId error: "_ex.DisplayString()_" | SQL: "_tSQL)
    }

    Quit tNextId
}

ClassMethod CountParams(p1 As %String = "", p2 As %String = "", p3 As %String = "", p4 As %String = "", p5 As %String = "", p6 As %String = "", p7 As %String = "", p8 As %String = "", p9 As %String = "") As %Integer
{
    If p9'="" Quit 9
    If p8'="" Quit 8
    If p7'="" Quit 7
    If p6'="" Quit 6
    If p5'="" Quit 5
    If p4'="" Quit 4
    If p3'="" Quit 3
    If p2'="" Quit 2
    If p1'="" Quit 1
    Quit 0
}

ClassMethod Scalar(pSQL As %String, p1 As %String = "", p2 As %String = "") As %String
{
    Set tResult = ""

    Try {
        Set tStmt = ##class(%SQL.Statement).%New()
        Set tSC = tStmt.%Prepare(pSQL)
        If $$$ISERR(tSC) {
            Throw ##class(%Exception.General).%New($System.Status.GetErrorText(tSC))
        }

        Set tCount = ..CountParams(p1, p2)

        If tCount = 0 {
            Set tRS = tStmt.%Execute()
        } ElseIf tCount = 1 {
            Set tRS = tStmt.%Execute(p1)
        } ElseIf tCount = 2 {
            Set tRS = tStmt.%Execute(p1, p2)
        }

        If tRS.%SQLCODE < 0 {
            Throw ##class(%Exception.General).%New("SQLCODE="_tRS.%SQLCODE_" MSG="_tRS.%Message_" | SQL="_pSQL)
        }

        If tRS.%Next() {
            Set tResult = tRS.%GetData(1)
        }
    } Catch ex {
        Throw ##class(%Exception.General).%New("Scalar error: "_ex.DisplayString()_" | SQL: "_pSQL)
    }

    Quit tResult
}

ClassMethod Exec(pSQL As %String, p1 As %String = "", p2 As %String = "", p3 As %String = "", p4 As %String = "", p5 As %String = "", p6 As %String = "", p7 As %String = "", p8 As %String = "", p9 As %String = "")
{
    Try {
        Set tStmt = ##class(%SQL.Statement).%New()
        Set tSC = tStmt.%Prepare(pSQL)
        If $$$ISERR(tSC) {
            Throw ##class(%Exception.General).%New($System.Status.GetErrorText(tSC))
        }

        Set tCount = ..CountParams(p1,p2,p3,p4,p5,p6,p7,p8,p9)

        If tCount = 0 {
            Set tRS = tStmt.%Execute()
        } ElseIf tCount = 1 {
            Set tRS = tStmt.%Execute(p1)
        } ElseIf tCount = 2 {
            Set tRS = tStmt.%Execute(p1,p2)
        } ElseIf tCount = 3 {
            Set tRS = tStmt.%Execute(p1,p2,p3)
        } ElseIf tCount = 4 {
            Set tRS = tStmt.%Execute(p1,p2,p3,p4)
        } ElseIf tCount = 5 {
            Set tRS = tStmt.%Execute(p1,p2,p3,p4,p5)
        } ElseIf tCount = 6 {
            Set tRS = tStmt.%Execute(p1,p2,p3,p4,p5,p6)
        } ElseIf tCount = 7 {
            Set tRS = tStmt.%Execute(p1,p2,p3,p4,p5,p6,p7)
        } ElseIf tCount = 8 {
            Set tRS = tStmt.%Execute(p1,p2,p3,p4,p5,p6,p7,p8)
        } ElseIf tCount = 9 {
            Set tRS = tStmt.%Execute(p1,p2,p3,p4,p5,p6,p7,p8,p9)
        }

        If tRS.%SQLCODE < 0 {
            Throw ##class(%Exception.General).%New("SQLCODE="_tRS.%SQLCODE_" MSG="_tRS.%Message_" | SQL="_pSQL)
        }
    } Catch ex {
        Throw ##class(%Exception.General).%New("Exec error: "_ex.DisplayString()_" | SQL: "_pSQL)
    }

    Quit
}

}
