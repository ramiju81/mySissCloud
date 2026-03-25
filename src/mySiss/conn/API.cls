/// API REST para mySiss Cloud - Seguridad base (Entrega 2)
Class mySiss.conn.API Extends %CSP.REST
{

Parameter CHARSET = "utf-8";
Parameter CONVERTINPUTSTREAM = 1;

XData UrlMap
{
<Routes>
  <Route Url="/ping"            Method="GET"  Call="Ping"/>
  <Route Url="/login"           Method="POST" Call="Login"/>
  <Route Url="/logout"          Method="POST" Call="Logout"/>
  <Route Url="/verify-session"  Method="GET"  Call="VerifySession"/>
  <Route Url="/forgot-password" Method="POST" Call="ForgotPassword"/>
  <Route Url="/validate-token"  Method="POST" Call="ValidateToken"/>
  <Route Url="/reset-password"  Method="POST" Call="ResetPassword"/>
  <Route Url="/:rest"           Method="OPTIONS" Call="Options"/>
</Routes>
}

ClassMethod SetCORS() As %Status
{
  Set origin = $Get(%request.CgiEnvs("HTTP_ORIGIN"))
  Set allowed = ..GetParam("CORS_ALLOWED_ORIGIN", "http://localhost:52773")
  If origin = "" Set origin = allowed

  Do %response.SetHeader("Access-Control-Allow-Origin", origin)
  Do %response.SetHeader("Vary", "Origin")
  Do %response.SetHeader("Access-Control-Allow-Credentials", "true")
  Do %response.SetHeader("Access-Control-Allow-Headers", "Content-Type, Authorization")
  Do %response.SetHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
  Do %response.SetHeader("Cache-Control", "no-store")
  Set %response.ContentType = "application/json; charset=utf-8"
  Quit $$$OK
}

ClassMethod WriteJSON(pObj As %DynamicObject) As %Status
{
  Do ..SetCORS()
  Write pObj.%ToJSON()
  Quit $$$OK
}

ClassMethod WriteError(pMessage As %String, pCode As %Integer) As %Status
{
  Set obj = {}
  Set obj.success = 0
  Set obj.error = pMessage
  Set obj.code = pCode
  Set %response.Status = pCode
  Quit ..WriteJSON(obj)
}

ClassMethod ParseJSONRequest(Output pJSON As %DynamicObject) As %Status
{
  Set pJSON = {}
  Try {
    Set tContent = %request.Content
    Set pJSON = ##class(%DynamicObject).%FromJSON(tContent)
    Quit $$$OK
  } Catch ex {
    Do ..WriteError("Payload JSON invalido", 400)
    Quit $$$ERROR($$$GeneralError, "invalid_json")
  }
}

ClassMethod GetParam(pKey As %String, pDefault As %String = "") As %String
{
  Set val = ""
  &sql(SELECT SEGParamValor INTO :val
       FROM mySiss_SEGParametro
       WHERE SEGParamClave = :pKey)
  If SQLCODE '= 0 Quit pDefault
  Quit $Select(val="":pDefault,1:val)
}

ClassMethod HashPassword(pPassword As %String, pSalt As %String) As %String
{
  Quit $SYSTEM.Encryption.SHA256Hash(pPassword_pSalt)
}

ClassMethod NewSalt() As %String
{
  Quit $SYSTEM.Encryption.GenCryptToken(32)
}

ClassMethod NewToken() As %String
{
  Quit $SYSTEM.Encryption.GenCryptToken(8)
}

ClassMethod BuildExpiryTimestamp(pMinutes As %Integer = 10) As %String
{
  Set hDay = $Piece($Horolog,",",1)
  Set hSec = $Piece($Horolog,",",2) + (pMinutes*60)
  While hSec'<86400 {
    Set hDay = hDay + 1
    Set hSec = hSec - 86400
  }
  Set h = hDay_","_hSec
  Quit $ZDATETIME(h,3)
}

ClassMethod ToInt(pVal As %String, pDefault As %Integer = 0) As %Integer
{
  Quit $Select(+pVal>0:+pVal,1:pDefault)
}

ClassMethod CountCharsByType(pText As %String, pType As %String) As %Integer
{
  Set count = 0
  Set i = 1
  For i=1:1:$Length(pText) {
    Set c = $Extract(pText,i)
    Set a = $ASCII(c)
    If (pType="upper")&&(a'<65)&&(a'>90) Set count = count + 1
    If (pType="lower")&&(a'<97)&&(a'>122) Set count = count + 1
    If (pType="digit")&&(a'<48)&&(a'>57) Set count = count + 1
    If (pType="special")&&((a<48)!((a>57)&(a<65))!((a>90)&(a<97))!(a>122)) Set count = count + 1
  }
  Quit count
}

ClassMethod ValidatePasswordPolicy(pPassword As %String, pUserId As %Integer = "", Output pMessage As %String) As %Boolean
{
  Set pMessage = ""
  Set minLen = ..ToInt(..GetParam("PASSWORD_MIN_LENGTH", "8"), 8)
  Set minUpper = ..ToInt(..GetParam("PASSWORD_REQUIRE_UPPER", "1"), 1)
  Set minLower = ..ToInt(..GetParam("PASSWORD_REQUIRE_LOWER", "1"), 1)
  Set minNum = ..ToInt(..GetParam("PASSWORD_REQUIRE_NUMBER", "1"), 1)
  Set minSpec = ..ToInt(..GetParam("PASSWORD_REQUIRE_SPECIAL", "1"), 1)

  If $Length(pPassword) < minLen {
    Set pMessage = "La contraseña no cumple longitud minima"
    Quit 0
  }
  If ..CountCharsByType(pPassword,"upper") < minUpper {
    Set pMessage = "La contraseña no cumple minimo de mayusculas"
    Quit 0
  }
  If ..CountCharsByType(pPassword,"lower") < minLower {
    Set pMessage = "La contraseña no cumple minimo de minusculas"
    Quit 0
  }
  If ..CountCharsByType(pPassword,"digit") < minNum {
    Set pMessage = "La contraseña no cumple minimo de numeros"
    Quit 0
  }
  If ..CountCharsByType(pPassword,"special") < minSpec {
    Set pMessage = "La contraseña no cumple minimo de caracteres especiales"
    Quit 0
  }

  If pUserId'="" {
    &sql(SELECT SEGUsuPasswordHash, SEGUsuSalt INTO :oldHash, :oldSalt
         FROM mySiss_SEGUsuario WHERE SEGUsuId = :pUserId)
    If SQLCODE = 0 {
      Set newHash = ..HashPassword(pPassword, oldSalt)
      If newHash = oldHash {
        Set pMessage = "No puede reutilizar la contraseña actual"
        Quit 0
      }
    }
  }

  Quit 1
}

ClassMethod AuditAccess(pUsuId As %String = "", pLogin As %String = "", pTipo As %String = "", pDetalle As %String = "") As %Status
{
  Set ip = $Get(%request.CgiEnvs("REMOTE_ADDR"),"")
  &sql(SELECT COALESCE(MAX(SEGAudAccId),0)+1 INTO :newId FROM mySiss_SEGAuditoriaAcceso)
  If SQLCODE '= 0 Quit $$$OK

  &sql(INSERT INTO mySiss_SEGAuditoriaAcceso
       (SEGAudAccId, SEGAudAccUsuId, SEGAudAccLogin, SEGAudAccTipo, SEGAudAccIp, SEGAudAccDetalle)
       VALUES (:newId, :pUsuId, :pLogin, :pTipo, :ip, :pDetalle))
  Quit $$$OK
}

ClassMethod GetRoles(pUserId As %Integer) As %DynamicArray
{
  Set roles = []
  &sql(DECLARE C1 CURSOR FOR
       SELECT r.SEGRolNombre
       FROM mySiss_SEGUsuarioRol ur
       JOIN mySiss_SEGRol r ON ur.SEGUsuRolRolId = r.SEGRolId
       WHERE ur.SEGUsuRolUsuId = :pUserId
         AND ur.SEGUsuRolEstado = 'A'
         AND r.SEGRolEstado = 'A')
  &sql(OPEN C1)
  &sql(FETCH C1 INTO :rolNombre)
  While (SQLCODE = 0) {
    Do roles.%Push(rolNombre)
    &sql(FETCH C1 INTO :rolNombre)
  }
  &sql(CLOSE C1)
  Quit roles
}

ClassMethod Ping() As %Status
{
  Set obj = {}
  Set obj.ok = 1
  Set obj.service = "mySissCloud API"
  Set obj.timestamp = $ZDATETIME($HOROLOG,3)
  Set obj.security = "enabled"
  Quit ..WriteJSON(obj)
}

ClassMethod Login() As %Status
{
  Set sc = ..ParseJSONRequest(.tJSON)
  If $$$ISERR(sc) Quit sc

  Set identifier = $ZStrip($Get(tJSON.email), "<>W")
  If identifier = "" Set identifier = $ZStrip($Get(tJSON.username), "<>W")
  Set password = $Get(tJSON.password)
  Set rememberMe = +$Get(tJSON.rememberMe)

  If (identifier = "") || (password = "") {
    Quit ..WriteError("Credenciales requeridas", 400)
  }

  &sql(SELECT SEGUsuId, SEGUsuLogin, SEGUsuCorreo, SEGUsuNombre, SEGUsuApellido,
               SEGUsuPasswordHash, SEGUsuSalt, SEGUsuEstado, COALESCE(SEGUsuIntentosFallidos,0)
       INTO :uid, :login, :correo, :nombre, :apellido, :dbHash, :dbSalt, :estado, :intentos
       FROM mySiss_SEGUsuario
       WHERE (SEGUsuLogin = :identifier OR SEGUsuCorreo = :identifier))

  If SQLCODE '= 0 {
    Do ..AuditAccess("",identifier,"LOGIN_FAIL","Usuario no encontrado")
    Quit ..WriteError("Credenciales invalidas", 401)
  }

  If estado = "B" {
    Do ..AuditAccess(uid,login,"LOGIN_FAIL","Usuario bloqueado")
    Quit ..WriteError("Usuario bloqueado", 423)
  }

  If estado '= "A" {
    Do ..AuditAccess(uid,login,"LOGIN_FAIL","Usuario inactivo")
    Quit ..WriteError("Usuario inactivo", 403)
  }

  Set maxIntentos = ..ToInt(..GetParam("MAX_INTENTOS_FALLIDOS","5"), 5)
  Set calcHash = ..HashPassword(password, dbSalt)

  If calcHash '= dbHash {
    Set newIntentos = intentos + 1
    Set newEstado = $Select(newIntentos'<maxIntentos:"B",1:"A")
    If newEstado = "B" {
      &sql(UPDATE mySiss_SEGUsuario
           SET SEGUsuIntentosFallidos = :newIntentos,
               SEGUsuEstado = :newEstado,
               SEGUsuFechaBloqueo = CURRENT_TIMESTAMP
           WHERE SEGUsuId = :uid)
    } Else {
      &sql(UPDATE mySiss_SEGUsuario
           SET SEGUsuIntentosFallidos = :newIntentos,
               SEGUsuEstado = :newEstado,
               SEGUsuFechaBloqueo = NULL
           WHERE SEGUsuId = :uid)
    }

    Do ..AuditAccess(uid,login,"LOGIN_FAIL","Password invalida")
    If newEstado = "B" Quit ..WriteError("Usuario bloqueado por intentos fallidos", 423)
    Quit ..WriteError("Credenciales invalidas", 401)
  }

  // Resetea contador y actualiza último acceso
  &sql(UPDATE mySiss_SEGUsuario
       SET SEGUsuIntentosFallidos = 0,
           SEGUsuFechaBloqueo = NULL,
           SEGUsuFechaUltimoAcceso = CURRENT_TIMESTAMP
       WHERE SEGUsuId = :uid)

  Set timeoutMin = ..ToInt(..GetParam("SESSION_TIMEOUT_MIN","30"), 30)
  Set %session.AppTimeout = timeoutMin
  Set %session.Data("UserID") = uid
  Set %session.Data("Login") = login
  Set %session.Data("Email") = correo
  Set %session.Data("FullName") = nombre_" "_apellido
  Set %session.Data("RememberMe") = rememberMe

  Set roles = ..GetRoles(uid)
  Set %session.Data("Roles") = roles.%ToJSON()

  Do ..AuditAccess(uid,login,"LOGIN_OK","Ingreso exitoso")

  Set obj = {}
  Set obj.success = 1
  Set obj.user = {
    "id": (uid),
    "username": (login),
    "email": (correo),
    "fullName": (nombre_" "_apellido),
    "roles": (roles)
  }
  Set obj.session = {
    "authenticated": 1,
    "timeoutMin": (timeoutMin),
    "rememberMe": (rememberMe)
  }

  Quit ..WriteJSON(obj)
}

ClassMethod VerifySession() As %Status
{
  Set userId = $Get(%session.Data("UserID"))
  If userId = "" Quit ..WriteError("No autenticado", 401)

  Set rolesJSON = $Get(%session.Data("Roles"), "[]")
  Set roles = ##class(%DynamicArray).%FromJSON(rolesJSON)

  Set obj = {}
  Set obj.authenticated = 1
  Set obj.user = {
    "id": (userId),
    "username": ($Get(%session.Data("Login"))),
    "email": ($Get(%session.Data("Email"))),
    "fullName": ($Get(%session.Data("FullName"))),
    "roles": (roles)
  }
  Set obj.session = {
    "timeoutMin": (%session.AppTimeout)
  }

  Quit ..WriteJSON(obj)
}

ClassMethod Logout() As %Status
{
  Set uid = $Get(%session.Data("UserID"))
  Set login = $Get(%session.Data("Login"))
  Do ..AuditAccess(uid,login,"LOGOUT","Cierre de sesion")

  Kill %session
  Set obj = {}
  Set obj.success = 1
  Set obj.message = "Sesion cerrada"
  Quit ..WriteJSON(obj)
}

ClassMethod ForgotPassword() As %Status
{
  Set sc = ..ParseJSONRequest(.tJSON)
  If $$$ISERR(sc) Quit sc

  Set email = $ZStrip($Get(tJSON.email), "<>W")
  If email = "" Quit ..WriteError("Email requerido", 400)

  Set cooldown = 60
  Set responseObj = {}
  Set responseObj.success = 1
  Set responseObj.message = "Si el correo existe, se enviara un token"
  Set responseObj.cooldownSec = cooldown

  &sql(SELECT SEGUsuId, SEGUsuLogin, SEGUsuEstado
       INTO :uid, :login, :estado
       FROM mySiss_SEGUsuario
       WHERE SEGUsuCorreo = :email)

  If SQLCODE '= 0 {
    Do ..AuditAccess("",email,"RECOVERY_REQUEST","Correo no encontrado")
    Quit ..WriteJSON(responseObj)
  }

  If estado '= "A" {
    Do ..AuditAccess(uid,login,"RECOVERY_REQUEST","Usuario no activo")
    Quit ..WriteJSON(responseObj)
  }

  Set token = ..NewToken()
  Set expMin = ..ToInt(..GetParam("TOKEN_EXPIRACION_MINUTOS", "10"), 10)
  Set expTs = ..BuildExpiryTimestamp(expMin)

  &sql(SELECT COALESCE(MAX(SEGTokId),0)+1 INTO :newTokId FROM mySiss_SEGTokenRecuperacion)
  &sql(INSERT INTO mySiss_SEGTokenRecuperacion
       (SEGTokId, SEGTokUsuId, SEGTokToken, SEGTokFechaExpiracion, SEGTokUsado, SEGTokIpSolicitud)
       VALUES (:newTokId, :uid, :token, :expTs, 'N', $Get(%request.CgiEnvs("REMOTE_ADDR"),"")))

  Do ..AuditAccess(uid,login,"RECOVERY_TOKEN_CREATED","Token de recuperacion creado")

  // Punto desacoplado para integración real de correo
  Set responseObj.delivery = {
    "status": "pending_integration",
    "channel": "email"
  }

  Quit ..WriteJSON(responseObj)
}

ClassMethod ValidateToken() As %Status
{
  Set sc = ..ParseJSONRequest(.tJSON)
  If $$$ISERR(sc) Quit sc

  Set email = $ZStrip($Get(tJSON.email), "<>W")
  Set token = $Get(tJSON.token)
  If (email="") || (token="") Quit ..WriteError("Email y token requeridos", 400)

  &sql(SELECT u.SEGUsuId, u.SEGUsuLogin, t.SEGTokId
       INTO :uid, :login, :tokId
       FROM mySiss_SEGUsuario u
       JOIN mySiss_SEGTokenRecuperacion t ON t.SEGTokUsuId = u.SEGUsuId
       WHERE u.SEGUsuCorreo = :email
         AND t.SEGTokToken = :token
         AND t.SEGTokUsado = 'N'
         AND t.SEGTokFechaExpiracion >= CURRENT_TIMESTAMP)

  If SQLCODE '= 0 {
    Do ..AuditAccess("",email,"RECOVERY_TOKEN_INVALID","Token invalido o expirado")
    Quit ..WriteError("Token invalido o expirado", 401)
  }

  Do ..AuditAccess(uid,login,"RECOVERY_TOKEN_OK","Token validado")

  Set obj = {}
  Set obj.success = 1
  Set obj.tokenValid = 1
  Set obj.message = "Token valido"
  Quit ..WriteJSON(obj)
}

ClassMethod ResetPassword() As %Status
{
  Set sc = ..ParseJSONRequest(.tJSON)
  If $$$ISERR(sc) Quit sc

  Set email = $ZStrip($Get(tJSON.email), "<>W")
  Set token = $Get(tJSON.token)
  Set newPassword = $Get(tJSON.newPassword)
  Set confirmPassword = $Get(tJSON.confirmPassword)

  If (email="") || (token="") || (newPassword="") || (confirmPassword="") {
    Quit ..WriteError("Datos incompletos", 400)
  }
  If newPassword '= confirmPassword {
    Quit ..WriteError("La confirmacion de contraseña no coincide", 400)
  }

  &sql(SELECT u.SEGUsuId, u.SEGUsuLogin, t.SEGTokId
       INTO :uid, :login, :tokId
       FROM mySiss_SEGUsuario u
       JOIN mySiss_SEGTokenRecuperacion t ON t.SEGTokUsuId = u.SEGUsuId
       WHERE u.SEGUsuCorreo = :email
         AND t.SEGTokToken = :token
         AND t.SEGTokUsado = 'N'
         AND t.SEGTokFechaExpiracion >= CURRENT_TIMESTAMP)

  If SQLCODE '= 0 {
    Quit ..WriteError("Token invalido o expirado", 401)
  }

  Set validPwd = ..ValidatePasswordPolicy(newPassword, uid, .policyMsg)
  If 'validPwd Quit ..WriteError(policyMsg, 400)

  Set salt = ..NewSalt()
  Set hash = ..HashPassword(newPassword, salt)

  &sql(UPDATE mySiss_SEGUsuario
       SET SEGUsuPasswordHash = :hash,
           SEGUsuSalt = :salt,
           SEGUsuIntentosFallidos = 0,
           SEGUsuEstado = 'A'
       WHERE SEGUsuId = :uid)

  &sql(UPDATE mySiss_SEGTokenRecuperacion
       SET SEGTokUsado = 'S'
       WHERE SEGTokId = :tokId)

  Do ..AuditAccess(uid,login,"PASSWORD_RESET","Contraseña restablecida")

  Set obj = {}
  Set obj.success = 1
  Set obj.message = "Contrasena actualizada"
  Quit ..WriteJSON(obj)
}

ClassMethod Options(rest As %String = "") As %Status
{
  Do ..SetCORS()
  Quit $$$OK
}

}
