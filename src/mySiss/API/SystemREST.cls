Class mySiss.API.SystemREST Extends %CSP.REST
{

Include %occStatus

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
  <Route Url="/ms/clients" Method="GET" Call="ListClients" />
  <Route Url="/ms/clients" Method="POST" Call="CreateClient" />
  <Route Url="/ms/clients/:id" Method="PUT" Call="UpdateClient" />
  <Route Url="/ms/clients/:id/status" Method="PUT" Call="UpdateClientStatus" />
  <Route Url="/ms/clients/:id/modules" Method="GET" Call="GetClientModules" />
  <Route Url="/ms/clients/:id/modules" Method="PUT" Call="SetClientModules" />
  <Route Url="/ms/modules/catalog" Method="GET" Call="GetModuleCatalog" />
</Routes>
}

ClassMethod Health() As %Status
{
    Set tDB = ##class(mySiss.API.SystemService).UpdateConnectionStatus()
    Set tResp = {"success":1,"status":"OK","database":tDB}
    If $Get(tDB.status) '= "OK" {
        Set tResp.status = "ERROR"
    }
    Do ..WriteJSON(tResp)
    Quit $$$OK
}

ClassMethod GetConfig() As %Status
{
    Set tCfg = ##class(mySiss.API.SystemService).GetSystemConfig()
    Do ..WriteJSON({"success":1,"data":tCfg})
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
        Do ..WriteJSON({"success":0,"error":"Solo superusuario puede actualizar configuración global."}, 403)
        Quit $$$ERROR($$$GeneralError,"forbidden")
    }

    Set tPayload = ..ReadJSONBody()
    Set tSC = ##class(mySiss.API.SystemService).SaveSystemConfig(tPayload)
    If $$$ISERR(tSC) {
        Do ..WriteJSON({"success":0,"error":"No se pudo guardar la configuración."}, 500)
        Quit tSC
    }

    Set tCfg = ##class(mySiss.API.SystemService).GetSystemConfig()
    Do ..WriteJSON({"success":1,"data":tCfg})
    Quit $$$OK
}

ClassMethod DatabaseStatus() As %Status
{
    Set tDB = ##class(mySiss.API.SystemService).UpdateConnectionStatus()
    Set tCode = $Select($Get(tDB.status)="OK":200,1:500)
    Do ..WriteJSON({"success":1,"data":tDB}, tCode)
    Quit $$$OK
}

ClassMethod ListClients() As %Status
{
    Set tData = ##class(mySiss.API.SystemService).ListClients()
    Do ..WriteJSON({"success":1,"data":tData})
    Quit $$$OK
}

ClassMethod CreateClient() As %Status
{
    If '(##class(mySiss.API.SystemService).IsSuperUser() || ##class(mySiss.API.SystemService).IsAdmin()) {
        Do ..WriteJSON({"success":0,"error":"No autorizado."}, 403)
        Quit $$$ERROR($$$GeneralError,"forbidden")
    }

    Set tPayload = ..ReadJSONBody()
    Set tId = ##class(mySiss.API.SystemService).UpsertClient(0, tPayload)
    Do ..WriteJSON({"success":1,"id_cliente":tId})
    Quit $$$OK
}

ClassMethod UpdateClient(id As %String) As %Status
{
    If '(##class(mySiss.API.SystemService).IsSuperUser() || ##class(mySiss.API.SystemService).IsAdmin()) {
        Do ..WriteJSON({"success":0,"error":"No autorizado."}, 403)
        Quit $$$ERROR($$$GeneralError,"forbidden")
    }

    Set tPayload = ..ReadJSONBody()
    Set tId = ##class(mySiss.API.SystemService).UpsertClient(+id, tPayload)
    Do ..WriteJSON({"success":1,"id_cliente":tId})
    Quit $$$OK
}

ClassMethod UpdateClientStatus(id As %String) As %Status
{
    If '(##class(mySiss.API.SystemService).IsSuperUser() || ##class(mySiss.API.SystemService).IsAdmin()) {
        Do ..WriteJSON({"success":0,"error":"No autorizado."}, 403)
        Quit $$$ERROR($$$GeneralError,"forbidden")
    }

    Set tPayload = ..ReadJSONBody()
    Set tSC = ##class(mySiss.API.SystemService).SetClientStatus(+id, +$Get(tPayload.activo))
    If $$$ISERR(tSC) {
        Do ..WriteJSON({"success":0,"error":"No se pudo actualizar estado del cliente."}, 500)
        Quit tSC
    }

    Do ..WriteJSON({"success":1})
    Quit $$$OK
}

ClassMethod GetClientModules(id As %String) As %Status
{
    Set tData = ##class(mySiss.API.SystemService).GetClientModules(+id)
    Do ..WriteJSON({"success":1,"data":tData})
    Quit $$$OK
}

ClassMethod SetClientModules(id As %String) As %Status
{
    If '(##class(mySiss.API.SystemService).IsSuperUser() || ##class(mySiss.API.SystemService).IsAdmin()) {
        Do ..WriteJSON({"success":0,"error":"No autorizado."}, 403)
        Quit $$$ERROR($$$GeneralError,"forbidden")
    }

    Set tPayload = ..ReadJSONBody()
    Set tModules = $Get(tPayload.modulos)
    If '$IsObject(tModules) {
        Set tModules = []
    }

    Set tSC = ##class(mySiss.API.SystemService).ReplaceClientModules(+id, tModules)
    If $$$ISERR(tSC) {
        Do ..WriteJSON({"success":0,"error":"No se pudo guardar módulos del cliente."}, 500)
        Quit tSC
    }

    Do ..WriteJSON({"success":1})
    Quit $$$OK
}

ClassMethod GetModuleCatalog() As %Status
{
    Set tData = ##class(mySiss.API.SystemService).GetModuleCatalog()
    Do ..WriteJSON({"success":1,"data":tData})
    Quit $$$OK
}

ClassMethod ReadJSONBody() As %DynamicObject
{
    Set tRaw = ""
    While '%request.Content.AtEnd {
        Set tRaw = tRaw_%request.Content.Read()
    }
    If tRaw = "" Quit {}

    Try {
        Quit {}.%FromJSON(tRaw)
    } Catch ex {
        Quit {}
    }
}

ClassMethod WriteJSON(pObj As %DynamicObject, pStatus As %Integer = 200)
{
    Set %response.Status = pStatus
    Do %response.SetHeader("Content-Type", "application/json; charset=utf-8")
    Write pObj.%ToJSON()
}

}
