Class mySiss.init.FileUploader Extends %CSP.Page
{

Parameter CHARSET = "utf-8";

ClassMethod OnPage() As %Status
{
    #include %occStatus

    set %response.ContentType = "text/plain; charset=utf-8"

    set filename = $get(%request.Data("filename",1))
    if filename="" {
        write "ERROR: filename requerido"
        quit $$$ERROR($$$GeneralError,"filename requerido")
    }

    set basePath = "/usr/irissys/csp/mySissCloud/"
    set fullPath = basePath _ filename

    set dirPath = ..GetDirectoryPath(fullPath)
    if dirPath'="" {
        set sc = ..EnsureDirectory(dirPath)
        if $$$ISERR(sc) {
            write "ERROR: no fue posible crear la ruta destino: "_dirPath
            quit sc
        }
    }

    set inStream = %request.Content
    if '$isobject(inStream) {
        write "ERROR: no se recibió contenido en el body"
        quit $$$ERROR($$$GeneralError,"sin contenido")
    }

    set outStream = ##class(%Stream.FileBinary).%New()
    set outStream.Filename = fullPath
    set sc = outStream.Clear()
    if $$$ISERR(sc) {
        write "ERROR: no fue posible preparar el archivo destino"
        quit sc
    }

    do inStream.Rewind()
    while 'inStream.AtEnd {
        set chunk = inStream.Read(32000)
        do outStream.Write(chunk)
    }

    set sc = outStream.%Save()
    if $$$ISERR(sc) {
        write "ERROR: no fue posible guardar el archivo"
        quit sc
    }

    write "OK: "_filename_" subido correctamente"
    quit $$$OK
}

ClassMethod GetDirectoryPath(pFullPath As %String) As %String
{
    set pos = $length(pFullPath,"/")
    if pos<2 quit ""
    quit $piece(pFullPath,"/",1,pos-1)
}

ClassMethod EnsureDirectory(pDir As %String) As %Status
{
    #include %occStatus

    if pDir="" quit $$$OK

    set cmd = "mkdir -p """_pDir_""""
    set rc = $zf(-1,cmd)

    if rc'=0 {
        quit $$$ERROR($$$GeneralError,"no se pudo crear directorio "_pDir)
    }

    quit $$$OK
}

}
