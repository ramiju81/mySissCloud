Class mySiss.API.SystemREST Extends %CSP.REST
{

Parameter CONTENTTYPE = "application/json";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/system/health" Method="GET" Call="Health"/>
<Route Url="/auth/context" Method="GET" Call="Context"/>
<Route Url="/auth/route" Method="GET" Call="Route"/>
<Route Url="/modules" Method="GET" Call="Modules"/>
</Routes>
}

ClassMethod WriteJSON(obj As %DynamicObject) As %Status
{
    Set %response.ContentType = ..#CONTENTTYPE
    Write obj.%ToJSON()
    Quit 1
}

ClassMethod Health() As %Status
{
    Set data = ##class(mySiss.API.SystemService).GetDatabaseStatus()
    Quit ..WriteJSON(data)
}

ClassMethod Context() As %Status
{
    Set data = ##class(mySiss.API.SystemService).GetUserContext()
    Quit ..WriteJSON(data)
}

ClassMethod Route() As %Status
{
    Set data = ##class(mySiss.API.SystemService).ResolvePostLoginRoute()
    Quit ..WriteJSON(data)
}

ClassMethod Modules() As %Status
{
    Set data = ##class(mySiss.API.SystemService).GetModuleCatalog()
    Quit ..WriteJSON(data)
}

}
