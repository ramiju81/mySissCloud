Class mySiss.API.SystemService Extends %RegisteredObject
{

ClassMethod NewObject() As %DynamicObject
{
    Quit ##class(%DynamicObject).%New()
}

ClassMethod NewArray() As %DynamicArray
{
    Quit ##class(%DynamicArray).%New()
}

ClassMethod Env(pName As %String, pDefault As %String = "") As %String
{
    Set val = $SYSTEM.Util.GetEnviron(pName)
    If val = "" Set val = pDefault
    Quit val
}

ClassMethod CurrentUserName() As %String
{
    Quit $Get(%session.Data("username"))
}

ClassMethod IsSuperUser() As %Boolean
{
    Quit ($ZConvert(..CurrentUserName(),"L") = $ZConvert(..Env("SUPERUSER_USERNAME","ramiju"),"L"))
}

ClassMethod IsAdmin() As %Boolean
{
    Quit ($ZConvert(..CurrentUserName(),"L") = $ZConvert(..Env("ADMIN_USERNAME","mysiss"),"L"))
}

ClassMethod IsSecurityAdmin() As %Boolean
{
    If ..IsSuperUser() Quit 1
    If ..IsAdmin() Quit 1
    Quit 0
}

ClassMethod GetSystemConfig() As %DynamicObject
{
    Set obj = ..NewObject()

    Do obj.%Set("environment", ..Env("MYSISS_ENV","local"))
    Do obj.%Set("database_engine", ..Env("MYSISS_DB_ENGINE","iris"))
    Do obj.%Set("namespace","MYSISS")

    Quit obj
}

ClassMethod GetDatabaseStatus() As %DynamicObject
{
    Set obj = ..NewObject()

    Try {
        Set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT 1")
        If rs.%Next() {
            Do obj.%Set("status","OK")
        } Else {
            Do obj.%Set("status","ERROR")
        }
    } Catch ex {
        Do obj.%Set("status","ERROR")
        Do obj.%Set("message",ex.DisplayString())
    }

    Quit obj
}

ClassMethod GetModuleCatalog() As %DynamicArray
{
    Set arr = ..NewArray()

    Do arr.%Push(..Module("seguridad","Seguridad","/Seguridad/seg_gestion_usuario.html"))
    Do arr.%Push(..Module("honorarios","Honorarios","/Honorarios/honorarios.html"))
    Do arr.%Push(..Module("auditoria","Auditoria","/Auditoria/Auditoria.html"))
    Do arr.%Push(..Module("glosas","Glosas","/Glosas/radicacion.html"))
    Do arr.%Push(..Module("mysiss","mySiss","/mySiss/system_base.html"))

    Quit arr
}

ClassMethod Module(pSlug, pName, pPath) As %DynamicObject
{
    Set obj = ..NewObject()
    Do obj.%Set("slug",pSlug)
    Do obj.%Set("nombre",pName)
    Do obj.%Set("entry_path","/csp/mySissCloud/app"_pPath)
    Quit obj
}

ClassMethod GetUserContext() As %DynamicObject
{
    Set obj = ..NewObject()
    Set user = ..CurrentUserName()

    Do obj.%Set("username",user)
    Do obj.%Set("authenticated",$Select(user'="":1,1:0))

    If ..IsSuperUser() {
        Do obj.%Set("type","super")
        Do obj.%Set("modules",..GetModuleCatalog())
        Quit obj
    }

    If ..IsAdmin() {
        Do obj.%Set("type","admin")
        Do obj.%Set("modules",..GetModuleCatalog())
        Quit obj
    }

    Do obj.%Set("type","user")
    Do obj.%Set("modules",..NewArray())

    Quit obj
}

ClassMethod ResolvePostLoginRoute() As %DynamicObject
{
    Set obj = ..NewObject()
    Set ctx = ..GetUserContext()

    If +$Get(ctx.%Get("authenticated"))=0 {
        Do obj.%Set("route","/csp/mySissCloud/app/Login/mySiss_Cloud_Login.html")
        Quit obj
    }

    If $Get(ctx.%Get("type"))="super" {
        Do obj.%Set("route","/csp/mySissCloud/app/mySiss/system_base.html")
        Quit obj
    }

    Do obj.%Set("route","/csp/mySissCloud/app/Login/mysiss_cloud.html")
    Quit obj
}

}
