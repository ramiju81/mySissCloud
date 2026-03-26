Class mySiss.Config.SG.SeedSuperUser Extends %RegisteredObject
{

ClassMethod Run(pUserName As %String = "ramiju", pPassword As %String = "Colombia01*", pNombre As %String = "Julian", pNombre2 As %String = "Alberto", pApellido As %String = "Ramirez", pApellido2 As %String = "Caicedo", pTipoDoc As %Integer = 1, pDocumento As %String = "TEMP-ADMIN-001", pCelular As %String = "3000000000", pEmail As %String = "juliram81@hotmail.com") As %Integer
{
    New $Namespace
    Set $Namespace = "MYSISS"

    Set tOK = 1

    Try {
        TSTART

        Set tRolId = ..GetOrCreateRol("SUPERADMIN")
        Set tCelId = ..GetOrCreateCelular(pCelular)
        Set tEmailId = ..GetOrCreateEmail(pEmail)
        Set tPassId = ..GetOrCreatePassword(..HashPassword(pPassword))
        Set tPersonId = ..GetOrCreatePerson(
            pNombre,
            pNombre2,
            pApellido,
            pApellido2,
            pTipoDoc,
            pDocumento,
            tCelId,
            tEmailId
        )
        Set tUserId = ..GetOrCreateUser(
            pUserName,
            tPersonId,
            tPassId
        )

        Do ..EnsureRolUser(tUserId, tRolId)
        Do ..EnsurePerValidez(tUserId)

        TCOMMIT
    } Catch ex {
        TROLLBACK
        Set tOK = 0
    }

    Quit tOK
}

ClassMethod RunSQL(pUserName As %String = "ramiju", pPassword As %String = "Colombia01*", pNombre As %String = "Julian", pNombre2 As %String = "Alberto", pApellido As %String = "Ramirez", pApellido2 As %String = "Caicedo", pTipoDoc As %Integer = 1, pDocumento As %String = "TEMP-ADMIN-001", pCelular As %String = "3000000000", pEmail As %String = "juliram81@hotmail.com") As %Integer [ SqlProc ]
{
    Quit ..Run(
        pUserName,
        pPassword,
        pNombre,
        pNombre2,
        pApellido,
        pApellido2,
        pTipoDoc,
        pDocumento,
        pCelular,
        pEmail
    )
}

ClassMethod HashPassword(pPassword As %String) As %String
{
    Quit pPassword
}

ClassMethod GetOrCreateRol(pRol As %String) As %Integer
{
    Set tId = ..Scalar("SELECT ID_rol FROM mySiss_Config_SG.Rol WHERE Rol = ?", pRol)
    If tId '= "" Quit +tId

    Set tId = ..NextId("mySiss_Config_SG.Rol","ID_rol")
    Do ..Exec("INSERT INTO mySiss_Config_SG.Rol (ID_rol, Rol, Fecha_crea, UserCreado) VALUES (?, ?, CURRENT_TIMESTAMP, 0)", tId, pRol)
    Quit tId
}

ClassMethod GetOrCreateCelular(pCelular As %String) As %Integer
{
    Set tId = ..Scalar("SELECT ID_Celular FROM mySiss_Config_SG.Celular WHERE Celular = ?", pCelular)
    If tId '= "" Quit +tId

    Set tId = ..NextId("mySiss_Config_SG.Celular","ID_Celular")
    Do ..Exec("INSERT INTO mySiss_Config_SG.Celular (ID_Celular, Celular, Fecha_crea, UserCreado) VALUES (?, ?, CURRENT_TIMESTAMP, 0)", tId, pCelular)
    Quit tId
}

ClassMethod GetOrCreateEmail(pEmail As %String) As %Integer
{
    Set tId = ..Scalar("SELECT ID_Email FROM mySiss_Config_SG.Email WHERE Email = ?", pEmail)
    If tId '= "" Quit +tId

    Set tId = ..NextId("mySiss_Config_SG.Email","ID_Email")
    Do ..Exec("INSERT INTO mySiss_Config_SG.Email (ID_Email, Email, Fecha_crea, UserCreado) VALUES (?, ?, CURRENT_TIMESTAMP, 0)", tId, pEmail)
    Quit tId
}

ClassMethod GetOrCreatePassword(pPasswHash As %String) As %Integer
{
    Set tId = ..Scalar("SELECT ID_Passw FROM mySiss_Config_SG.Passw WHERE Passw_hash = ?", pPasswHash)
    If tId '= "" Quit +tId

    Set tId = ..NextId("mySiss_Config_SG.Passw","ID_Passw")
    Do ..Exec("INSERT INTO mySiss_Config_SG.Passw (ID_Passw, Passw_hash, Fecha_crea, UserCreado) VALUES (?, ?, CURRENT_TIMESTAMP, 0)", tId, pPasswHash)
    Quit tId
}

ClassMethod GetOrCreatePerson(pNombre As %String, pNombre2 As %String, pApellido As %String, pApellido2 As %String, pTipoDoc As %Integer, pDocumento As %String, pCelId As %Integer, pEmailId As %Integer) As %Integer
{
    Set tId = ..Scalar("SELECT ID_Person FROM mySiss_Config_SG.Person WHERE Cedula = ?", pDocumento)
    If tId '= "" Quit +tId

    Set tId = ..NextId("mySiss_Config_SG.Person","ID_Person")
    Do ..Exec("INSERT INTO mySiss_Config_SG.Person (ID_Person, Nombre, Nombre2, Apellido, Apellido2, ID_Tipo_Doc, Cedula, ID_Celular, ID_Email, Fecha_crea, UserCreado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, 0)", tId, pNombre, pNombre2, pApellido, pApellido2, pTipoDoc, pDocumento, pCelId, pEmailId)
    Quit tId
}

ClassMethod GetOrCreateUser(pUserName As %String, pPersonId As %Integer, pPassId As %Integer) As %Integer
{
    Set tId = ..Scalar("SELECT ID_user FROM mySiss_Config_SG.""User"" WHERE Nombre_user = ?", pUserName)
    If tId '= "" Quit +tId

    Set tId = ..NextId("mySiss_Config_SG.""User""","ID_user")
    Do ..Exec("INSERT INTO mySiss_Config_SG.""User"" (ID_user, ID_Cliente, ID_Person, Nombre_user, ID_Password, Valido_de, Valido_hasta, Fecha_crea, UserCreado) VALUES (?, NULL, ?, ?, ?, CURRENT_DATE, '2099-12-31', CURRENT_TIMESTAMP, 0)", tId, pPersonId, pUserName, pPassId)
    Quit tId
}

ClassMethod EnsureRolUser(pUserId As %Integer, pRolId As %Integer)
{
    Set tId = ..Scalar("SELECT ID_roluser FROM mySiss_Config_SG.RolUser WHERE ID_user = ? AND ID_rol = ?", pUserId, pRolId)
    If tId '= "" Quit

    Set tId = ..NextId("mySiss_Config_SG.RolUser","ID_roluser")
    Do ..Exec("INSERT INTO mySiss_Config_SG.RolUser (ID_roluser, ID_user, ID_rol, Fecha_crea, UserCreado) VALUES (?, ?, ?, CURRENT_TIMESTAMP, 0)", tId, pUserId, pRolId)
    Quit
}

ClassMethod EnsurePerValidez(pUserId As %Integer)
{
    Set tMotivoId = ..GetOrCreateMotivo("ALTA INICIAL SUPERADMIN")

    Set tId = ..Scalar("SELECT ID_PerValidez FROM mySiss_Config_SG.PerValidez WHERE ID_user = ?", pUserId)
    If tId '= "" Quit

    Set tId = ..NextId("mySiss_Config_SG.PerValidez","ID_PerValidez")
    Do ..Exec("INSERT INTO mySiss_Config_SG.PerValidez (ID_PerValidez, ID_user, ID_motivo, status, valido_de, valido_hasta, Fecha_crea, UserCreado) VALUES (?, ?, ?, ?, CURRENT_DATE, '2099-12-31', CURRENT_TIMESTAMP, 0)", tId, pUserId, tMotivoId, "A")
    Quit
}

ClassMethod GetOrCreateMotivo(pMotivo As %String) As %Integer
{
    Set tId = ..Scalar("SELECT ID_motivo FROM mySiss_Config_SG.Motivo WHERE motivo = ?", pMotivo)
    If tId '= "" Quit +tId

    Set tId = ..NextId("mySiss_Config_SG.Motivo","ID_motivo")
    Do ..Exec("INSERT INTO mySiss_Config_SG.Motivo (ID_motivo, motivo, Fecha_crea, UserCreado) VALUES (?, ?, CURRENT_TIMESTAMP, 0)", tId, pMotivo)
    Quit tId
}

ClassMethod NextId(pTable As %String, pColumn As %String) As %Integer
{
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tRS = tStmt.%ExecDirect(, "SELECT COALESCE(MAX("_pColumn_"),0)+1 AS NextId FROM "_pTable)

    If tRS.%Next() {
        Quit +tRS.%Get("NextId")
    }

    Quit 1
}

ClassMethod Scalar(pSQL As %String, p1 As %String = "", p2 As %String = "") As %String
{
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tCode = tStmt.%Prepare(pSQL)
    If tCode '= 1 {
        Throw ##class(%Exception.General).%New("Error preparando SQL")
    }

    If p2 '= "" {
        Set tRS = tStmt.%Execute(p1, p2)
    } ElseIf p1 '= "" {
        Set tRS = tStmt.%Execute(p1)
    } Else {
        Set tRS = tStmt.%Execute()
    }

    If tRS.%Next() {
        Quit tRS.%Get(1)
    }

    Quit ""
}

ClassMethod Exec(pSQL As %String, p1 As %String = "", p2 As %String = "", p3 As %String = "", p4 As %String = "", p5 As %String = "", p6 As %String = "", p7 As %String = "", p8 As %String = "", p9 As %String = "")
{
    Set tStmt = ##class(%SQL.Statement).%New()
    Set tCode = tStmt.%Prepare(pSQL)
    If tCode '= 1 {
        Throw ##class(%Exception.General).%New("Error preparando SQL")
    }

    If p9 '= "" {
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

    If tStmt.%SQLCODE < 0 {
        Throw ##class(%Exception.General).%New("Error SQL")
    }

    Quit
}

}
