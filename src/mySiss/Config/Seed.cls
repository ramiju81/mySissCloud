/// Datos semilla de mySiss Cloud
/// Inserta funcionalidades, roles base y asignaciones iniciales
Class mySiss.Config.Seed Extends %RegisteredObject
{

ClassMethod Run() As %Status
{
    Write "============================================================",!
    Write " mySiss Cloud - Cargando datos semilla",!
    Write "============================================================",!

    Do ..SeedFuncionalidades()
    Do ..SeedRolesBase()
    Do ..SeedRolFuncionalidad()

    Write !
    Write " Seed completado",!
    Quit $$$OK
}

ClassMethod SeedFuncionalidades() As %Status
{
    Write "--- Insertando funcionalidades ---",!
    // Módulo SEGURIDAD
    Do ..InsFunc(10,"Seguridad","Módulo de seguridad y accesos","SEGURIDAD","","lock",1,"")
    Do ..InsFunc(11,"Gestión de usuarios","Administrar usuarios del sistema","SEGURIDAD","app/Seguridad/seg_gestion_usuario.html","users",2,10)
    Do ..InsFunc(12,"Gestión de roles","Administrar roles del sistema","SEGURIDAD","app/Seguridad/conf_rol.html","shield",3,10)
    Do ..InsFunc(13,"Funcionalidades","Configurar funcionalidades","SEGURIDAD","app/Seguridad/conf_func_1.html","menu",4,10)
    Do ..InsFunc(14,"Configuración base","Parámetros del sistema","SEGURIDAD","app/Seguridad/conf_bas_1.html","settings",5,10)
    // Módulo AUDITORIA
    Do ..InsFunc(20,"Auditoría","Módulo de auditoría","AUDITORIA","","audit",10,"")
    Do ..InsFunc(21,"Auditoría concurrente","Gestión auditoría concurrente","AUDITORIA","app/Auditoria/Aconcurrente.html","clipboard",11,20)
    Do ..InsFunc(22,"Hallazgos","Registrar y consultar hallazgos","AUDITORIA","app/Auditoria/Aconcurrente-Hallazgos.html","alert-circle",12,20)
    Do ..InsFunc(23,"Planes de acción","Gestionar planes de acción","AUDITORIA","app/Auditoria/Aconcurrente-Placcion.html","check-square",13,20)
    Do ..InsFunc(24,"Resultados","Ver resultados de auditoría","AUDITORIA","app/Auditoria/Aconcurrente-Resultados.html","bar-chart",14,20)
    Do ..InsFunc(25,"Configuración auditoría","Configurar parámetros de auditoría","AUDITORIA","app/Auditoria/Configuracion.html","sliders",15,20)
    // Módulo GLOSAS
    Do ..InsFunc(30,"Glosas","Módulo de gestión de glosas","GLOSAS","","file-text",20,"")
    Do ..InsFunc(31,"Radicación","Radicar facturas","GLOSAS","app/Glosas/radicacion.html","upload",21,30)
    Do ..InsFunc(32,"Devoluciones","Gestionar devoluciones de facturas","GLOSAS","app/Glosas/con_dev.html","corner-down-left",22,30)
    Do ..InsFunc(33,"Objeciones","Cargue y gestión de objeciones","GLOSAS","app/Glosas/cargue.html","alert-triangle",23,30)
    Do ..InsFunc(34,"Gestión objeciones","Contestar y gestionar glosas","GLOSAS","app/Glosas/gestion.html","message-square",24,30)
    Do ..InsFunc(35,"Conciliación","Conciliación de glosas","GLOSAS","app/Glosas/conciliacion.html","git-merge",25,30)
    Do ..InsFunc(36,"Reportes glosas","Reportes del módulo","GLOSAS","app/Glosas/reportes.html","printer",26,30)
    // Módulo HONORARIOS
    Do ..InsFunc(40,"Honorarios","Módulo de honorarios médicos","HONORARIOS","","dollar-sign",30,"")
    Do ..InsFunc(41,"Contratos","Gestionar contratos médicos","HONORARIOS","app/Honorarios/contratos.html","file-plus",31,40)
    Do ..InsFunc(42,"Cargue producción","Cargar producción médica","HONORARIOS","app/Honorarios/cargue.html","upload-cloud",32,40)
    Do ..InsFunc(43,"Validación","Validar liquidaciones","HONORARIOS","app/Honorarios/validacion_liq.html","check",33,40)
    Do ..InsFunc(44,"Reportes honorarios","Reportes del módulo","HONORARIOS","app/Honorarios/reportes_liq.html","printer",34,40)
    // Módulo CUENTAS MEDICAS
    Do ..InsFunc(50,"Cuentas médicas","Módulo de cuentas médicas","CUENTAS","","clipboard",40,"")
    Do ..InsFunc(51,"Auditoría cuentas","Auditar cuentas médicas","CUENTAS","app/Auditoria/Cuentas medicas/AcuentasM.html","eye",41,50)
    Do ..InsFunc(52,"Estado cuentas","Consultar estado de cuentas","CUENTAS","app/Auditoria/Cuentas medicas/AcuentasM-EstCuenta.html","list",42,50)
    Do ..InsFunc(53,"Convenios EPS","Configurar convenios con EPS","CUENTAS","app/Auditoria/Cuentas medicas/AcuentasM-ConfConvenios.html","link",43,50)
    Do ..InsFunc(54,"Validaciones médicas","Validaciones de cuentas","CUENTAS","app/Auditoria/Cuentas medicas/AcuentasM-Validaciones.html","check-circle",44,50)
    Write " Funcionalidades insertadas",!
    Quit $$$OK
}

ClassMethod SeedRolesBase() As %Status
{
    Write "--- Insertando roles base ---",!
    // Rol 1 = SUPERADMIN ya existe desde DBInit
    Do ..InsRol(2, "ADMINISTRADOR",      "Administrador del sistema con acceso a seguridad y configuración")
    Do ..InsRol(3, "AUDITOR_CONCURRENTE","Auditor que gestiona auditorías concurrentes y hallazgos")
    Do ..InsRol(4, "LIDER_PROCESO",      "Líder de proceso que acepta planes de acción")
    Do ..InsRol(5, "GLOSADOR",           "Responsable de gestión de glosas y objeciones")
    Do ..InsRol(6, "LIQUIDADOR_HON",     "Encargado de liquidación de honorarios")
    Do ..InsRol(7, "AUDITOR_CUENTAS",    "Auditor de cuentas médicas")
    Do ..InsRol(8, "CONSULTA",           "Solo lectura en todos los módulos")
    Write " Roles base insertados",!
    Quit $$$OK
}

ClassMethod SeedRolFuncionalidad() As %Status
{
    Write "--- Asignando funcionalidades a roles ---",!
    // SUPERADMIN (1) → acceso a todo
    Set rs2 = ##class(%SQL.Statement).%New()
    If $$$ISOK(rs2.%Prepare("SELECT SEGFuncId FROM mySiss_SEGFuncionalidad")) {
        Set result = rs2.%Execute()
        While result.%Next() {
            Do ..InsRolFunc(1, result.%Get("SEGFuncId"), "S","S","S")
        }
    }
    // ADMINISTRADOR (2) → seguridad completa + consulta módulos
    For id=10,11,12,13,14 { Do ..InsRolFunc(2, id, "S","S","S") }
    For id=20,21,22,23,24,25,30,31,32,33,34,35,36,40,41,42,43,44,50,51,52,53,54 {
        Do ..InsRolFunc(2, id, "S","N","N")
    }
    // AUDITOR_CONCURRENTE (3) → auditoría completa + consulta cuentas
    For id=20,21,22,23,24,25 { Do ..InsRolFunc(3, id, "S","S","N") }
    For id=50,51,52,53,54    { Do ..InsRolFunc(3, id, "S","S","N") }
    // LIDER_PROCESO (4) → planes de acción
    For id=20,22,23,24       { Do ..InsRolFunc(4, id, "S","S","N") }
    // GLOSADOR (5) → glosas completo
    For id=30,31,32,33,34,35,36 { Do ..InsRolFunc(5, id, "S","S","S") }
    // LIQUIDADOR_HON (6) → honorarios completo
    For id=40,41,42,43,44    { Do ..InsRolFunc(6, id, "S","S","S") }
    // AUDITOR_CUENTAS (7) → cuentas médicas completo
    For id=50,51,52,53,54    { Do ..InsRolFunc(7, id, "S","S","N") }
    // CONSULTA (8) → solo lectura en todo
    Set rs3 = ##class(%SQL.Statement).%New()
    If $$$ISOK(rs3.%Prepare("SELECT SEGFuncId FROM mySiss_SEGFuncionalidad")) {
        Set result3 = rs3.%Execute()
        While result3.%Next() {
            Do ..InsRolFunc(8, result3.%Get("SEGFuncId"), "S","N","N")
        }
    }
    Write " Asignaciones de rol-funcionalidad completadas",!
    Quit $$$OK
}

ClassMethod InsFunc(id As %Integer, nombre As %String, desc As %String, modulo As %String, url As %String, icono As %String, orden As %Integer, padreId As %String) As %Status
{
    Set padreVal = $Select(padreId="":"NULL", 1:padreId)
    Set st = ##class(%SQL.Statement).%New()
    Set sc = st.%Prepare(
        "INSERT OR IGNORE INTO mySiss_SEGFuncionalidad"_
        " (SEGFuncId,SEGFuncNombre,SEGFuncDescripcion,SEGFuncModulo,SEGFuncUrl,SEGFuncIcono,SEGFuncOrden,SEGFuncPadreId,SEGFuncEstado)"_
        " VALUES (?,?,?,?,?,?,?,?,'A')")
    If $$$ISOK(sc) {
        If padreId="" {
            Do st.%Execute(id,nombre,desc,modulo,url,icono,orden,{})
        } Else {
            Do st.%Execute(id,nombre,desc,modulo,url,icono,orden,padreId)
        }
    }
    Quit $$$OK
}

ClassMethod InsRol(id As %Integer, nombre As %String, desc As %String) As %Status
{
    Set st = ##class(%SQL.Statement).%New()
    Set sc = st.%Prepare(
        "INSERT OR IGNORE INTO mySiss_SEGRol (SEGRolId,SEGRolNombre,SEGRolDescripcion,SEGRolEstado,SEGRolCreadoPor)"_
        " VALUES (?,'"+nombre+"','"+desc+"','A','SYSTEM')")
    If $$$ISOK(sc) { Do st.%Execute(id) }
    Quit $$$OK
}

ClassMethod InsRolFunc(rolId As %Integer, funcId As %Integer, leer As %String, escribir As %String, eliminar As %String) As %Status
{
    Set st = ##class(%SQL.Statement).%New()
    Set sc = st.%Prepare(
        "INSERT OR IGNORE INTO mySiss_SEGRolFuncionalidad"_
        " (SEGRolFuncRolId,SEGRolFuncFuncId,SEGRolFuncPuedeLeer,SEGRolFuncPuedeEscribir,SEGRolFuncPuedeEliminar,SEGRolFuncAsignadoPor)"_
        " VALUES (?,?,?,?,?,'SYSTEM')")
    If $$$ISOK(sc) { Do st.%Execute(rolId,funcId,leer,escribir,eliminar) }
    Quit $$$OK
}

}
