Class mySiss.API.SystemREST Extends %CSP.REST
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

ClassMethod Obj(pK1 As %String = "", pV1 = "", pK2 As %String = "", pV2 = "", pK3 As %String = "", pV3 = "", pK4 As %String = "", pV4 = "", pK5 As %String = "", pV5 = "", pK6 As %String = "", pV6 = "", pK7 As %String = "", pV7 = "") As %DynamicObject
{
    Set o = ..NewObj()
    If pK1'="" { Do o.%Set(pK1,pV1) }
    If pK2'="" { Do o.%Set(pK2,pV2) }
    If pK3'="" { Do o.%Set(pK3,pV3) }
    If pK4'="" { Do o.%Set(pK4,pV4) }
    If pK5'="" { Do o.%Set(pK5,pV5) }
    If pK6'="" { Do o.%Set(pK6,pV6) }
    If pK7'="" { Do o.%Set(pK7,pV7) }
    Quit o
}

Parameter CHARSET = "utf-8";
Parameter CONTENTTYPE = "application/json";

XData UrlMap
{
<Routes>
  <Route Url="/system/health" Method="GET" Call="Health" />
  <Route Url="/system/config" Method="GET" Call="GetConfig" />
  <Route Url="/system/config" Method="POST" Call="CreateConfig" />
  <Route Url="/system/config" Method="PUT" Call="UpdateConfig" />
  <Route Url="/system/database/status" Method="GET" Call="DatabaseStatus" />
  <Route Url="/auth/context" Method="GET" Call="AuthContext" />
  <Route Url="/auth/resolve-route" Method="GET" Call="ResolveRoute" />
  <Route Url="/auth/authorize-module/:slug" Method="GET" Call="AuthorizeModule" />
  <Route Url="/security/users" Method="GET" Call="ListSecurityUsers" />
  <Route Url="/security/users" Method="POST" Call="CreateSecurityUser" />
  <Route Url="/security/users/:id" Method="GET" Call="GetSecurityUser" />
  <Route Url="/security/users/:id" Method="PUT" Call="UpdateSecurityUser" />
  <Route Url="/security/users/:id/status" Method="PUT" Call="UpdateSecurityUserStatus" />
  <Route Url="/security/roles" Method="GET" Call="ListSecurityRoles" />
  <Route Url="/security/roles" Method="POST" Call="CreateSecurityRole" />
  <Route Url="/security/roles/:id" Method="GET" Call="GetSecurityRole" />
  <Route Url="/security/roles/:id" Method="PUT" Call="UpdateSecurityRole" />
  <Route Url="/security/roles/:id/status" Method="PUT" Call="UpdateSecurityRoleStatus" />
  <Route Url="/security/roles/:id/permissions" Method="GET" Call="GetSecurityRolePermissions" />
  <Route Url="/security/roles/:id/permissions" Method="PUT" Call="UpdateSecurityRolePermissions" />
  <Route Url="/security/catalog/clients" Method="GET" Call="SecurityClientsCatalog" />
  <Route Url="/security/catalog/modules" Method="GET" Call="SecurityModulesCatalog" />
  <Route Url="/ms/clients" Method="GET" Call="ListClients" />
  <Route Url="/ms/clients" Method="POST" Call="CreateClient" />
  <Route Url="/ms/clients/:id" Method="PUT" Call="UpdateClient" />
  <Route Url="/ms/clients/:id/status" Method="PUT" Call="UpdateClientStatus" />
  <Route Url="/ms/clients/:id/modules" Method="GET" Call="GetClientModules" />
  <Route Url="/ms/clients/:id/modules" Method="PUT" Call="SetClientModules" />
  <Route Url="/ms/modules/catalog" Method="GET" Call="GetModuleCatalog" />
  <Route Url="/ws/integrations" Method="GET" Call="ListWSIntegrations" />
  <Route Url="/ws/integrations" Method="POST" Call="CreateWSIntegration" />
  <Route Url="/ws/integrations/:id" Method="GET" Call="GetWSIntegration" />
  <Route Url="/ws/integrations/:id" Method="PUT" Call="UpdateWSIntegration" />
  <Route Url="/ws/integrations/:id/status" Method="PUT" Call="UpdateWSIntegrationStatus" />
  <Route Url="/ws/clients/:id/integrations" Method="GET" Call="ListWSClientIntegrations" />
  <Route Url="/ws/clients/:id/integrations" Method="PUT" Call="SaveWSClientIntegrations" />
  <Route Url="/ws/client-integrations/:id/status" Method="PUT" Call="UpdateWSClientIntegrationStatus" />
  <Route Url="/ws/execute" Method="POST" Call="ExecuteWSIntegration" />
  <Route Url="/ws/logs/integration/:id" Method="GET" Call="ListWSLogsByIntegration" />
  <Route Url="/ws/logs/client/:id" Method="GET" Call="ListWSLogsByClient" />
  <Route Url="/ws/logs/:id" Method="GET" Call="GetWSLogDetail" />
</Routes>
}

ClassMethod Health() As %Status
{
    Set tDB = ##class(mySiss.API.SystemService).UpdateConnectionStatus()
    Set tResp = ..Obj("success",1,"status","OK","database",tDB)
    If $Get(tDB.status) '= "OK" {
        Set tResp.status = "ERROR"
    }
    Do ..WriteJSON(tResp)
    Quit $$$OK
}

ClassMethod GetConfig() As %Status
{
    Set tCfg = ##class(mySiss.API.SystemService).GetSystemConfig()
    Do ..WriteJSON(..Obj("success",1,"data",tCfg))
    Quit $$$OK
}

ClassMethod CreateConfig() As %Status
{
    Quit ..SaveConfigInternal()
}

ClassMethod UpdateConfig() As %Status
{
    Quit ..SaveConfigInternal()
}

ClassMethod SaveConfigInternal() As %Status
{
    If '##class(mySiss.API.SystemService).IsSuperUser() {
        Do ..WriteJSON(..Obj("success",0,"error","Solo superusuario puede actualizar configuración global."), 403)
        Quit $$$ERROR($$$GeneralError,"forbidden")
    }

    Set tPayload = ..ReadJSONBody()
    Set tSC = ##class(mySiss.API.SystemService).SaveSystemConfig(tPayload)
    If $$$ISERR(tSC) {
        Do ..WriteJSON(..Obj("success",0,"error","No se pudo guardar la configuración."), 500)
        Quit tSC
    }

    Set tCfg = ##class(mySiss.API.SystemService).GetSystemConfig()
    Do ..WriteJSON(..Obj("success",1,"data",tCfg))
    Quit $$$OK
}

ClassMethod DatabaseStatus() As %Status
{
    Set tDB = ##class(mySiss.API.SystemService).UpdateConnectionStatus()
    Set tCode = $Select($Get(tDB.status)="OK":200,1:500)
    Do ..WriteJSON(..Obj("success",1,"data",tDB), tCode)
    Quit $$$OK
}

ClassMethod AuthContext() As %Status
{
    Set tCtx = ##class(mySiss.API.SystemService).GetUserContext()
    Do ..WriteJSON(..Obj("success",1,"data",tCtx))
    Quit $$$OK
}

ClassMethod ResolveRoute() As %Status
{
    Set tData = ##class(mySiss.API.SystemService).ResolvePostLoginRoute()
    Do ..WriteJSON(..Obj("success",1,"data",tData))
    Quit $$$OK
}

ClassMethod AuthorizeModule(slug As %String) As %Status
{
    Set tCtx = ##class(mySiss.API.SystemService).GetUserContext()
    If '$Get(tCtx.authenticated) {
        Do ..WriteJSON(..Obj("success",0,"allowed",0,"redirect","/csp/mySissCloud/app/Login/mySiss_Cloud_Login.html","error","Sesión no válida."), 401)
        Quit $$$OK
    }

    Set tAllowed = 0
    For i=1:1:tCtx.modules.%Size() {
        If $Get(tCtx.modules.%Get(i).slug)=$ZConvert(slug,"L") {
            Set tAllowed = 1
            Quit
        }
    }

    If ($Get(tCtx.user_type)="superusuario")!($Get(tCtx.user_type)="administrador") {
        Set tAllowed = 1
    }

    If 'tAllowed {
        Do ..WriteJSON(..Obj("success",0,"allowed",0,"redirect","/csp/mySissCloud/mysiss_cloud.html?state=no-access"), 403)
        Quit $$$OK
    }

    Do ..WriteJSON(..Obj("success",1,"allowed",1))
    Quit $$$OK
}

ClassMethod ListClients() As %Status
{
    Set tData = ##class(mySiss.API.SystemService).ListClients()
    Do ..WriteJSON(..Obj("success",1,"data",tData))
    Quit $$$OK
}

ClassMethod CreateClient() As %Status
{
    If '(##class(mySiss.API.SystemService).IsSuperUser() ! ##class(mySiss.API.SystemService).IsAdmin()) {
        Do ..WriteJSON(..Obj("success",0,"error","No autorizado."), 403)
        Quit $$$ERROR($$$GeneralError,"forbidden")
    }

    Set tPayload = ..ReadJSONBody()
    Set tId = ##class(mySiss.API.SystemService).UpsertClient(0, tPayload)
    Do ..WriteJSON(..Obj("success",1,"id_cliente",tId))
    Quit $$$OK
}

ClassMethod UpdateClient(id As %String) As %Status
{
    If '(##class(mySiss.API.SystemService).IsSuperUser() ! ##class(mySiss.API.SystemService).IsAdmin()) {
        Do ..WriteJSON(..Obj("success",0,"error","No autorizado."), 403)
        Quit $$$ERROR($$$GeneralError,"forbidden")
    }

    Set tPayload = ..ReadJSONBody()
    Set tId = ##class(mySiss.API.SystemService).UpsertClient(+id, tPayload)
    Do ..WriteJSON(..Obj("success",1,"id_cliente",tId))
    Quit $$$OK
}

ClassMethod UpdateClientStatus(id As %String) As %Status
{
    If '(##class(mySiss.API.SystemService).IsSuperUser() ! ##class(mySiss.API.SystemService).IsAdmin()) {
        Do ..WriteJSON(..Obj("success",0,"error","No autorizado."), 403)
        Quit $$$ERROR($$$GeneralError,"forbidden")
    }

    Set tPayload = ..ReadJSONBody()
    Set tSC = ##class(mySiss.API.SystemService).SetClientStatus(+id, +$Get(tPayload.activo))
    If $$$ISERR(tSC) {
        Do ..WriteJSON(..Obj("success",0,"error","No se pudo actualizar estado del cliente."), 500)
        Quit tSC
    }

    Do ..WriteJSON(..Obj("success",1))
    Quit $$$OK
}

ClassMethod GetClientModules(id As %String) As %Status
{
    Set tData = ##class(mySiss.API.SystemService).GetClientModules(+id)
    Do ..WriteJSON(..Obj("success",1,"data",tData))
    Quit $$$OK
}

ClassMethod SetClientModules(id As %String) As %Status
{
    If '(##class(mySiss.API.SystemService).IsSuperUser() ! ##class(mySiss.API.SystemService).IsAdmin()) {
        Do ..WriteJSON(..Obj("success",0,"error","No autorizado."), 403)
        Quit $$$ERROR($$$GeneralError,"forbidden")
    }

    Set tPayload = ..ReadJSONBody()
    Set tModules = $Get(tPayload.modulos)
    If '$IsObject(tModules) {
        Set tModules = ..NewArr()
    }

    Set tSC = ##class(mySiss.API.SystemService).ReplaceClientModules(+id, tModules)
    If $$$ISERR(tSC) {
        Do ..WriteJSON(..Obj("success",0,"error","No se pudo guardar módulos del cliente."), 500)
        Quit tSC
    }

    Do ..WriteJSON(..Obj("success",1))
    Quit $$$OK
}

ClassMethod GetModuleCatalog() As %Status
{
    Set tData = ##class(mySiss.API.SystemService).GetModuleCatalog()
    Do ..WriteJSON(..Obj("success",1,"data",tData))
    Quit $$$OK
}

ClassMethod RequireSecurityAdmin() As %Boolean
{
    If '##class(mySiss.API.SystemService).IsSecurityAdmin() {
        Do ..WriteJSON(..Obj("success",0,"error","No autorizado"), 403)
        Quit 0
    }
    Quit 1
}

ClassMethod ListSecurityUsers() As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Do ..WriteJSON(..Obj("success",1,"data",##class(mySiss.API.SystemService).ListSecurityUsers()))
    Quit $$$OK
}

ClassMethod CreateSecurityUser() As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tRes = ##class(mySiss.API.SystemService).SaveSecurityUser(0, ..ReadJSONBody())
    If +$Get(tRes.ok)'=1 {
        Do ..WriteJSON(..Obj("success",0,"error",$Get(tRes.error)), 400)
        Quit $$$OK
    }
    Do ..WriteJSON(..Obj("success",1,"data",tRes), 201)
    Quit $$$OK
}

ClassMethod GetSecurityUser(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tData = ##class(mySiss.API.SystemService).GetSecurityUserDetail(+id)
    If '$IsObject(tData) {
        Do ..WriteJSON(..Obj("success",0,"error","USER_NOT_FOUND"), 404)
        Quit $$$OK
    }
    Do ..WriteJSON(..Obj("success",1,"data",tData))
    Quit $$$OK
}

ClassMethod UpdateSecurityUser(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tRes = ##class(mySiss.API.SystemService).SaveSecurityUser(+id, ..ReadJSONBody())
    If +$Get(tRes.ok)'=1 {
        Do ..WriteJSON(..Obj("success",0,"error",$Get(tRes.error)), 400)
        Quit $$$OK
    }
    Do ..WriteJSON(..Obj("success",1,"data",tRes))
    Quit $$$OK
}

ClassMethod UpdateSecurityUserStatus(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tPayload = ..ReadJSONBody()
    Set tSC = ##class(mySiss.API.SystemService).SetSecurityUserStatus(+id, +$Get(tPayload.active))
    If $$$ISERR(tSC) {
        Do ..WriteJSON(..Obj("success",0,"error","STATUS_UPDATE_FAILED"), 400)
        Quit $$$OK
    }
    Do ..WriteJSON(..Obj("success",1))
    Quit $$$OK
}

ClassMethod ListSecurityRoles() As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Do ..WriteJSON(..Obj("success",1,"data",##class(mySiss.API.SystemService).ListSecurityRoles()))
    Quit $$$OK
}

ClassMethod CreateSecurityRole() As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tRes = ##class(mySiss.API.SystemService).SaveSecurityRole(0, ..ReadJSONBody())
    If +$Get(tRes.ok)'=1 {
        Do ..WriteJSON(..Obj("success",0,"error",$Get(tRes.error)), 400)
        Quit $$$OK
    }
    Do ..WriteJSON(..Obj("success",1,"data",tRes), 201)
    Quit $$$OK
}

ClassMethod GetSecurityRole(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tRoles = ##class(mySiss.API.SystemService).ListSecurityRoles()
    For i=1:1:tRoles.%Size() {
        If +$Get(tRoles.%Get(i).id_rol)=+id {
            Do ..WriteJSON(..Obj("success",1,"data",tRoles.%Get(i)))
            Quit $$$OK
        }
    }
    Do ..WriteJSON(..Obj("success",0,"error","ROLE_NOT_FOUND"), 404)
    Quit $$$OK
}

ClassMethod UpdateSecurityRole(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tRes = ##class(mySiss.API.SystemService).SaveSecurityRole(+id, ..ReadJSONBody())
    If +$Get(tRes.ok)'=1 {
        Do ..WriteJSON(..Obj("success",0,"error",$Get(tRes.error)), 400)
        Quit $$$OK
    }
    Do ..WriteJSON(..Obj("success",1,"data",tRes))
    Quit $$$OK
}

ClassMethod UpdateSecurityRoleStatus(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tPayload = ..ReadJSONBody()
    Set tSC = ##class(mySiss.API.SystemService).SetSecurityRoleStatus(+id, +$Get(tPayload.active))
    If $$$ISERR(tSC) {
        Do ..WriteJSON(..Obj("success",0,"error","ROLE_STATUS_UPDATE_FAILED"), 400)
        Quit $$$OK
    }
    Do ..WriteJSON(..Obj("success",1))
    Quit $$$OK
}

ClassMethod GetSecurityRolePermissions(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Do ..WriteJSON(..Obj("success",1,"data",##class(mySiss.API.SystemService).GetRolePermissions(+id)))
    Quit $$$OK
}

ClassMethod UpdateSecurityRolePermissions(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tPayload = ..ReadJSONBody()
    Set tPerms = $Get(tPayload.permissions)
    If '$IsObject(tPerms) Set tPerms = ..NewArr()
    Set tSC = ##class(mySiss.API.SystemService).SaveRolePermissions(+id, tPerms)
    If $$$ISERR(tSC) {
        Do ..WriteJSON(..Obj("success",0,"error","ROLE_PERMISSIONS_UPDATE_FAILED"), 400)
        Quit $$$OK
    }
    Do ..WriteJSON(..Obj("success",1))
    Quit $$$OK
}

ClassMethod SecurityClientsCatalog() As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Do ..WriteJSON(..Obj("success",1,"data",##class(mySiss.API.SystemService).ListSecurityClients()))
    Quit $$$OK
}

ClassMethod SecurityModulesCatalog() As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Do ..WriteJSON(..Obj("success",1,"data",##class(mySiss.API.SystemService).GetModuleCatalog()))
    Quit $$$OK
}



ClassMethod ListWSIntegrations() As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Do ..WriteJSON(..Obj("success",1,"data",##class(mySiss.API.SystemService).ListWSIntegrations()))
    Quit $$$OK
}

ClassMethod CreateWSIntegration() As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tRes = ##class(mySiss.API.SystemService).SaveWSIntegration(0, ..ReadJSONBody())
    If +$Get(tRes.ok)'=1 {
        Do ..WriteJSON(..Obj("success",0,"error",$Get(tRes.error)), 400)
        Quit $$$OK
    }
    Do ..WriteJSON(..Obj("success",1,"data",tRes), 201)
    Quit $$$OK
}

ClassMethod GetWSIntegration(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tData = ##class(mySiss.API.SystemService).GetWSIntegration(+id)
    If +$Get(tData.id_integracion)=0 {
        Do ..WriteJSON(..Obj("success",0,"error","INTEGRATION_NOT_FOUND"), 404)
        Quit $$$OK
    }
    Do ..WriteJSON(..Obj("success",1,"data",tData))
    Quit $$$OK
}

ClassMethod UpdateWSIntegration(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tRes = ##class(mySiss.API.SystemService).SaveWSIntegration(+id, ..ReadJSONBody())
    If +$Get(tRes.ok)'=1 {
        Do ..WriteJSON(..Obj("success",0,"error",$Get(tRes.error)), 400)
        Quit $$$OK
    }
    Do ..WriteJSON(..Obj("success",1,"data",tRes))
    Quit $$$OK
}

ClassMethod UpdateWSIntegrationStatus(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tPayload = ..ReadJSONBody()
    Set tSC = ##class(mySiss.API.SystemService).SetWSIntegrationStatus(+id, +$Get(tPayload.activo))
    If $$$ISERR(tSC) {
        Do ..WriteJSON(..Obj("success",0,"error","INTEGRATION_STATUS_UPDATE_FAILED"), 400)
        Quit $$$OK
    }
    Do ..WriteJSON(..Obj("success",1))
    Quit $$$OK
}

ClassMethod ListWSClientIntegrations(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Do ..WriteJSON(..Obj("success",1,"data",##class(mySiss.API.SystemService).ListWSClientIntegrations(+id)))
    Quit $$$OK
}

ClassMethod SaveWSClientIntegrations(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tPayload = ..ReadJSONBody()
    Set tItems = $Get(tPayload.items)
    If '$IsObject(tItems) Set tItems = ..NewArr()
    Set tSC = ##class(mySiss.API.SystemService).SaveWSClientIntegrations(+id, tItems)
    If $$$ISERR(tSC) {
        Do ..WriteJSON(..Obj("success",0,"error","CLIENT_INTEGRATIONS_UPDATE_FAILED"), 400)
        Quit $$$OK
    }
    Do ..WriteJSON(..Obj("success",1))
    Quit $$$OK
}

ClassMethod UpdateWSClientIntegrationStatus(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tPayload = ..ReadJSONBody()
    Set tSC = ##class(mySiss.API.SystemService).SetWSClientIntegrationStatus(+id, +$Get(tPayload.activo))
    If $$$ISERR(tSC) {
        Do ..WriteJSON(..Obj("success",0,"error","CLIENT_INTEGRATION_STATUS_UPDATE_FAILED"), 400)
        Quit $$$OK
    }
    Do ..WriteJSON(..Obj("success",1))
    Quit $$$OK
}

ClassMethod ExecuteWSIntegration() As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tRes = ##class(mySiss.API.SystemService).ExecuteWSIntegration(..ReadJSONBody())
    Set tCode = $Select(+$Get(tRes.ok)=1:200,1:500)
    Do ..WriteJSON(..Obj("success",1,"data",tRes), tCode)
    Quit $$$OK
}

ClassMethod ListWSLogsByIntegration(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Do ..WriteJSON(..Obj("success",1,"data",##class(mySiss.API.SystemService).ListWSLogsByIntegration(+id)))
    Quit $$$OK
}

ClassMethod ListWSLogsByClient(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Do ..WriteJSON(..Obj("success",1,"data",##class(mySiss.API.SystemService).ListWSLogsByClient(+id)))
    Quit $$$OK
}

ClassMethod GetWSLogDetail(id As %String) As %Status
{
    If (..RequireSecurityAdmin()=0) { Quit $$$OK }
    Set tData = ##class(mySiss.API.SystemService).GetWSLogDetail(+id)
    If +$Get(tData.id_log)=0 {
        Do ..WriteJSON(..Obj("success",0,"error","LOG_NOT_FOUND"), 404)
        Quit $$$OK
    }
    Do ..WriteJSON(..Obj("success",1,"data",tData))
    Quit $$$OK
}

ClassMethod ReadJSONBody() As %DynamicObject
{
    Set tRaw = ""
    While '%request.Content.AtEnd {
        Set tRaw = tRaw_%request.Content.Read()
    }
    If tRaw = "" Quit ..NewObj()

    Try {
        Set tParsed = ##class(%DynamicAbstractObject).%FromJSON(tRaw)
        If $IsObject(tParsed),($IsA(tParsed,"%DynamicObject")) {
            Quit tParsed
        }
        Quit ..NewObj()
    } Catch ex {
        Quit ..NewObj()
    }
}

ClassMethod WriteJSON(pObj As %DynamicObject, pStatus As %Integer = 200)
{
    Set %response.Status = pStatus
    Do %response.SetHeader("Content-Type", "application/json; charset=utf-8")
    Write pObj.%ToJSON()
}

}
