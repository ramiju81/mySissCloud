/// Inicialización de base de datos mySiss Cloud
/// Crea todas las tablas, constraints e índices para todos los módulos
/// Nomenclatura: sin guión bajo en nombres de tabla/campo (ObjectScript)
/// Módulos: Seguridad (SEG), Auditoría (AUD), Glosas (GLO), Honorarios (HON), Cuentas Médicas (CUE)
Class mySiss.Config.DBInit Extends %RegisteredObject
{

/// Método principal: ejecuta toda la inicialización
ClassMethod Run() As %Status
{
    Set sc = $$$OK

    Write "============================================================",!
    Write " mySiss Cloud - Inicialización de Base de Datos",!
    Write "============================================================",!
    Write !

    // ---- Módulo Seguridad ----
    Do ..CreateSegTables()

    // ---- Módulo Auditoría ----
    Do ..CreateAudTables()

    // ---- Módulo Glosas ----
    Do ..CreateGloTables()

    // ---- Módulo Honorarios ----
    Do ..CreateHonTables()

    // ---- Módulo Cuentas Médicas ----
    Do ..CreateCueTables()

    // ---- Módulo Clientes Multi-tenant (MS) ----
    Do ..CreateMSTables()

    // ---- Superusuario ----
    Do ..CreateSuperUser()

    Write !
    Write "============================================================",!
    Write " Inicialización completada exitosamente",!
    Write "============================================================",!

    Quit sc
}

// ===========================================================

//  MÓDULO SEGURIDAD (SEG)

// ===========================================================

ClassMethod CreateSegTables() As %Status
{
    Write "--- Módulo Seguridad (SEG) ---",!

    // SEG001 - Perfil / Módulo del sistema
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_SEGPerfil ("_
        " SEGPerfilId        INTEGER NOT NULL,"_
        " SEGPerfilNombre    VARCHAR(100) NOT NULL,"_
        " SEGPerfilDescripcion VARCHAR(255),"_
        " SEGPerfilEstado    CHAR(1) NOT NULL DEFAULT 'A',"_  // A=Activo, I=Inactivo
        " SEGPerfilFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " SEGPerfilCreadoPor VARCHAR(50),"_
        " CONSTRAINT PK_SEGPerfil PRIMARY KEY (SEGPerfilId),"_
        " CONSTRAINT CHK_SEGPerfilEstado CHECK (SEGPerfilEstado IN ('A','I'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGPerfil_Nombre ON mySiss_SEGPerfil(SEGPerfilNombre)")

    // SEG002 - Rol
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_SEGRol ("_
        " SEGRolId           INTEGER NOT NULL,"_
        " SEGRolNombre       VARCHAR(100) NOT NULL,"_
        " SEGRolDescripcion  VARCHAR(255),"_
        " SEGRolEstado       CHAR(1) NOT NULL DEFAULT 'A',"_
        " SEGRolFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " SEGRolCreadoPor    VARCHAR(50),"_
        " CONSTRAINT PK_SEGRol PRIMARY KEY (SEGRolId),"_
        " CONSTRAINT UK_SEGRol_Nombre UNIQUE (SEGRolNombre),"_
        " CONSTRAINT CHK_SEGRolEstado CHECK (SEGRolEstado IN ('A','I'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGRol_Nombre ON mySiss_SEGRol(SEGRolNombre)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGRol_Estado ON mySiss_SEGRol(SEGRolEstado)")

    // SEG003 - Funcionalidad (menú/opción del sistema)
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_SEGFuncionalidad ("_
        " SEGFuncId          INTEGER NOT NULL,"_
        " SEGFuncNombre      VARCHAR(150) NOT NULL,"_
        " SEGFuncDescripcion VARCHAR(255),"_
        " SEGFuncModulo      VARCHAR(50),"_     // SEGURIDAD, AUDITORIA, GLOSAS, HONORARIOS, CUENTAS
        " SEGFuncUrl         VARCHAR(500),"_
        " SEGFuncIcono       VARCHAR(100),"_
        " SEGFuncOrden       INTEGER DEFAULT 0,"_
        " SEGFuncPadreId     INTEGER,"_          // Para jerarquía de menú
        " SEGFuncEstado      CHAR(1) NOT NULL DEFAULT 'A',"_
        " CONSTRAINT PK_SEGFuncionalidad PRIMARY KEY (SEGFuncId),"_
        " CONSTRAINT FK_SEGFunc_Padre FOREIGN KEY (SEGFuncPadreId) REFERENCES mySiss_SEGFuncionalidad(SEGFuncId),"_
        " CONSTRAINT CHK_SEGFuncEstado CHECK (SEGFuncEstado IN ('A','I'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGFunc_Modulo ON mySiss_SEGFuncionalidad(SEGFuncModulo)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGFunc_Padre  ON mySiss_SEGFuncionalidad(SEGFuncPadreId)")

    // SEG004 - Rol-Funcionalidad (permisos por rol)
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_SEGRolFuncionalidad ("_
        " SEGRolFuncRolId    INTEGER NOT NULL,"_
        " SEGRolFuncFuncId   INTEGER NOT NULL,"_
        " SEGRolFuncPuedeLeer  CHAR(1) DEFAULT 'S',"_
        " SEGRolFuncPuedeEscribir CHAR(1) DEFAULT 'N',"_
        " SEGRolFuncPuedeEliminar CHAR(1) DEFAULT 'N',"_
        " SEGRolFuncFechaAsignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " SEGRolFuncAsignadoPor VARCHAR(50),"_
        " CONSTRAINT PK_SEGRolFunc PRIMARY KEY (SEGRolFuncRolId, SEGRolFuncFuncId),"_
        " CONSTRAINT FK_SEGRolFunc_Rol  FOREIGN KEY (SEGRolFuncRolId)  REFERENCES mySiss_SEGRol(SEGRolId),"_
        " CONSTRAINT FK_SEGRolFunc_Func FOREIGN KEY (SEGRolFuncFuncId) REFERENCES mySiss_SEGFuncionalidad(SEGFuncId)"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGRolFunc_Rol  ON mySiss_SEGRolFuncionalidad(SEGRolFuncRolId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGRolFunc_Func ON mySiss_SEGRolFuncionalidad(SEGRolFuncFuncId)")

    // SEG005 - Usuario
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_SEGUsuario ("_
        " SEGUsuId           INTEGER NOT NULL,"_
        " SEGUsuLogin        VARCHAR(50) NOT NULL,"_
        " SEGUsuPasswordHash VARCHAR(256) NOT NULL,"_   // SHA-256 con salt
        " SEGUsuSalt         VARCHAR(64) NOT NULL,"_
        " SEGUsuNombre       VARCHAR(100) NOT NULL,"_
        " SEGUsuApellido     VARCHAR(100) NOT NULL,"_
        " SEGUsuCorreo       VARCHAR(200) NOT NULL,"_
        " SEGUsuTelefono     VARCHAR(20),"_
        " SEGUsuCelular      VARCHAR(20),"_             // Para envío de token
        " SEGUsuDocTipo      VARCHAR(10),"_             // CC, CE, PAS, NIT
        " SEGUsuDocNumero    VARCHAR(20),"_
        " SEGUsuCargo        VARCHAR(100),"_
        " SEGUsuArea         VARCHAR(100),"_
        " SEGUsuTipoUsuario  VARCHAR(20) NOT NULL DEFAULT 'NORMAL',"_  // SUPER, ADMIN, NORMAL
        " SEGUsuEstado       CHAR(1) NOT NULL DEFAULT 'A',"_           // A=Activo, I=Inactivo, B=Bloqueado
        " SEGUsuPrimerIngreso CHAR(1) NOT NULL DEFAULT 'S',"_         // S=debe cambiar clave, N=ya la cambió
        " SEGUsuIntentosFallidos INTEGER DEFAULT 0,"_
        " SEGUsuFechaBloqueo  TIMESTAMP,"_
        " SEGUsuFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " SEGUsuCreadoPor    VARCHAR(50),"_
        " SEGUsuFechaUltimoAcceso TIMESTAMP,"_
        " CONSTRAINT PK_SEGUsuario  PRIMARY KEY (SEGUsuId),"_
        " CONSTRAINT UK_SEGUsuLogin UNIQUE (SEGUsuLogin),"_
        " CONSTRAINT UK_SEGUsuCorreo UNIQUE (SEGUsuCorreo),"_
        " CONSTRAINT CHK_SEGUsuEstado CHECK (SEGUsuEstado IN ('A','I','B')),"_
        " CONSTRAINT CHK_SEGUsuTipo  CHECK (SEGUsuTipoUsuario IN ('SUPER','ADMIN','NORMAL'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGUsu_Login   ON mySiss_SEGUsuario(SEGUsuLogin)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGUsu_Correo  ON mySiss_SEGUsuario(SEGUsuCorreo)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGUsu_Estado  ON mySiss_SEGUsuario(SEGUsuEstado)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGUsu_Tipo    ON mySiss_SEGUsuario(SEGUsuTipoUsuario)")

    // SEG006 - Usuario-Rol
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_SEGUsuarioRol ("_
        " SEGUsuRolUsuId     INTEGER NOT NULL,"_
        " SEGUsuRolRolId     INTEGER NOT NULL,"_
        " SEGUsuRolFechaAsignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " SEGUsuRolAsignadoPor VARCHAR(50),"_
        " SEGUsuRolEstado    CHAR(1) NOT NULL DEFAULT 'A',"_
        " CONSTRAINT PK_SEGUsuarioRol PRIMARY KEY (SEGUsuRolUsuId, SEGUsuRolRolId),"_
        " CONSTRAINT FK_SEGUsuRol_Usu FOREIGN KEY (SEGUsuRolUsuId) REFERENCES mySiss_SEGUsuario(SEGUsuId),"_
        " CONSTRAINT FK_SEGUsuRol_Rol FOREIGN KEY (SEGUsuRolRolId) REFERENCES mySiss_SEGRol(SEGRolId)"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGUsuRol_Usu ON mySiss_SEGUsuarioRol(SEGUsuRolUsuId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGUsuRol_Rol ON mySiss_SEGUsuarioRol(SEGUsuRolRolId)")

    // SEG007 - Token de recuperación de contraseña (enviado al correo/celular)
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_SEGTokenRecuperacion ("_
        " SEGTokId           INTEGER NOT NULL,"_
        " SEGTokUsuId        INTEGER NOT NULL,"_
        " SEGTokToken        VARCHAR(20) NOT NULL,"_   // token numérico/alfanumérico
        " SEGTokFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " SEGTokFechaExpiracion TIMESTAMP NOT NULL,"_  // +10 minutos
        " SEGTokUsado        CHAR(1) NOT NULL DEFAULT 'N',"_
        " SEGTokIpSolicitud  VARCHAR(50),"_
        " CONSTRAINT PK_SEGTok PRIMARY KEY (SEGTokId),"_
        " CONSTRAINT FK_SEGTok_Usu FOREIGN KEY (SEGTokUsuId) REFERENCES mySiss_SEGUsuario(SEGUsuId),"_
        " CONSTRAINT CHK_SEGTokUsado CHECK (SEGTokUsado IN ('S','N'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGTok_Usu   ON mySiss_SEGTokenRecuperacion(SEGTokUsuId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGTok_Token ON mySiss_SEGTokenRecuperacion(SEGTokToken)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGTok_Exp   ON mySiss_SEGTokenRecuperacion(SEGTokFechaExpiracion)")

    // SEG008 - Auditoría de accesos (log de sesiones)
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_SEGAuditoriaAcceso ("_
        " SEGAudAccId        INTEGER NOT NULL,"_
        " SEGAudAccUsuId     INTEGER,"_
        " SEGAudAccLogin     VARCHAR(50),"_
        " SEGAudAccFecha     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " SEGAudAccTipo      VARCHAR(20),"_   // LOGIN_OK, LOGIN_FAIL, LOGOUT, CAMBIO_CLAVE
        " SEGAudAccIp        VARCHAR(50),"_
        " SEGAudAccDetalle   VARCHAR(500),"_
        " CONSTRAINT PK_SEGAudAcc PRIMARY KEY (SEGAudAccId)"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGAudAcc_Usu   ON mySiss_SEGAuditoriaAcceso(SEGAudAccUsuId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGAudAcc_Fecha ON mySiss_SEGAuditoriaAcceso(SEGAudAccFecha)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_SEGAudAcc_Tipo  ON mySiss_SEGAuditoriaAcceso(SEGAudAccTipo)")

    // SEG009 - Parámetros de seguridad del sistema
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_SEGParametro ("_
        " SEGParamClave      VARCHAR(100) NOT NULL,"_
        " SEGParamValor      VARCHAR(500) NOT NULL,"_
        " SEGParamDescripcion VARCHAR(255),"_
        " SEGParamFechaModificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " SEGParamModificadoPor VARCHAR(50),"_
        " CONSTRAINT PK_SEGParam PRIMARY KEY (SEGParamClave)"_
        ")")

    Write " Tablas SEG creadas OK",!
    Quit $$$OK
}

// ===========================================================

//  MÓDULO AUDITORÍA (AUD)

// ===========================================================

ClassMethod CreateAudTables() As %Status
{
    Write "--- Módulo Auditoría (AUD) ---",!

    // AUD001 - Configuración general de auditoría
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_AUDConfiguracion ("_
        " AUDConfigId        INTEGER NOT NULL,"_
        " AUDConfigNombre    VARCHAR(100) NOT NULL,"_
        " AUDConfigDescripcion VARCHAR(500),"_
        " AUDConfigTipo      VARCHAR(50),"_   // CONCURRENTE, CALIDAD, CUENTAS
        " AUDConfigVersion   VARCHAR(20),"_
        " AUDConfigEstado    CHAR(1) NOT NULL DEFAULT 'A',"_
        " AUDConfigFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " AUDConfigCreadoPor VARCHAR(50),"_
        " AUDConfigFechaModificacion TIMESTAMP,"_
        " AUDConfigModificadoPor VARCHAR(50),"_
        " CONSTRAINT PK_AUDConfig PRIMARY KEY (AUDConfigId),"_
        " CONSTRAINT CHK_AUDConfigEstado CHECK (AUDConfigEstado IN ('A','I'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_AUDConfig_Tipo   ON mySiss_AUDConfiguracion(AUDConfigTipo)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_AUDConfig_Estado ON mySiss_AUDConfiguracion(AUDConfigEstado)")

    // AUD002 - Campos de auditoría configurables
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_AUDConfigCampo ("_
        " AUDCampoId         INTEGER NOT NULL,"_
        " AUDCampoConfigId   INTEGER NOT NULL,"_
        " AUDCampoNombre     VARCHAR(100) NOT NULL,"_
        " AUDCampoTipo       VARCHAR(50),"_    // TEXTO, NUMERO, FECHA, SELECCION, BOOLEANO
        " AUDCampoObligatorio CHAR(1) DEFAULT 'N',"_
        " AUDCampoOrden      INTEGER DEFAULT 0,"_
        " AUDCampoOpciones   VARCHAR(1000),"_  // JSON con opciones si es selección
        " AUDCampoEstado     CHAR(1) NOT NULL DEFAULT 'A',"_
        " CONSTRAINT PK_AUDCampo PRIMARY KEY (AUDCampoId),"_
        " CONSTRAINT FK_AUDCampo_Config FOREIGN KEY (AUDCampoConfigId) REFERENCES mySiss_AUDConfiguracion(AUDConfigId),"_
        " CONSTRAINT CHK_AUDCampoEstado CHECK (AUDCampoEstado IN ('A','I'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_AUDCampo_Config ON mySiss_AUDConfigCampo(AUDCampoConfigId)")

    // AUD003 - Auditoría concurrente (cabecera)
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_AUDAuditoriaConcurrente ("_
        " AUDConcId          INTEGER NOT NULL,"_
        " AUDConcConfigId    INTEGER NOT NULL,"_
        " AUDConcNumero      VARCHAR(30) NOT NULL,"_    // Número consecutivo
        " AUDConcFecha       DATE NOT NULL,"_
        " AUDConcInstitucion VARCHAR(200),"_
        " AUDConcServicio    VARCHAR(200),"_
        " AUDConcPacienteDoc VARCHAR(30),"_
        " AUDConcPacienteNombre VARCHAR(200),"_
        " AUDConcPacienteEPS  VARCHAR(100),"_
        " AUDConcAuditorId   INTEGER,"_
        " AUDConcLiderProcId INTEGER,"_
        " AUDConcEstado      VARCHAR(20) NOT NULL DEFAULT 'ABIERTA',"_  // ABIERTA, CERRADA, ANULADA
        " AUDConcFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " AUDConcCreadoPor   VARCHAR(50),"_
        " AUDConcFechaModificacion TIMESTAMP,"_
        " AUDConcModificadoPor VARCHAR(50),"_
        " CONSTRAINT PK_AUDConc PRIMARY KEY (AUDConcId),"_
        " CONSTRAINT UK_AUDConc_Numero UNIQUE (AUDConcNumero),"_
        " CONSTRAINT FK_AUDConc_Config FOREIGN KEY (AUDConcConfigId) REFERENCES mySiss_AUDConfiguracion(AUDConfigId),"_
        " CONSTRAINT CHK_AUDConcEstado CHECK (AUDConcEstado IN ('ABIERTA','CERRADA','ANULADA'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_AUDConc_Config ON mySiss_AUDAuditoriaConcurrente(AUDConcConfigId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_AUDConc_Fecha  ON mySiss_AUDAuditoriaConcurrente(AUDConcFecha)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_AUDConc_Estado ON mySiss_AUDAuditoriaConcurrente(AUDConcEstado)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_AUDConc_PacDoc ON mySiss_AUDAuditoriaConcurrente(AUDConcPacienteDoc)")

    // AUD004 - Hallazgos de auditoría concurrente
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_AUDHallazgo ("_
        " AUDHallId          INTEGER NOT NULL,"_
        " AUDHallConcId      INTEGER NOT NULL,"_
        " AUDHallNumero      INTEGER NOT NULL,"_
        " AUDHallCampoId     INTEGER,"_
        " AUDHallDescripcion VARCHAR(2000) NOT NULL,"_
        " AUDHallClasificacion VARCHAR(50),"_   // CRITICO, MAYOR, MENOR, OBSERVACION
        " AUDHallResponsable VARCHAR(200),"_
        " AUDHallFechaLimite DATE,"_
        " AUDHallEstado      VARCHAR(20) NOT NULL DEFAULT 'ABIERTO',"_  // ABIERTO, EN_PROCESO, CERRADO
        " AUDHallFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " AUDHallCreadoPor   VARCHAR(50),"_
        " CONSTRAINT PK_AUDHall PRIMARY KEY (AUDHallId),"_
        " CONSTRAINT FK_AUDHall_Conc  FOREIGN KEY (AUDHallConcId)  REFERENCES mySiss_AUDAuditoriaConcurrente(AUDConcId),"_
        " CONSTRAINT FK_AUDHall_Campo FOREIGN KEY (AUDHallCampoId) REFERENCES mySiss_AUDConfigCampo(AUDCampoId),"_
        " CONSTRAINT CHK_AUDHallClasif CHECK (AUDHallClasificacion IN ('CRITICO','MAYOR','MENOR','OBSERVACION')),"_
        " CONSTRAINT CHK_AUDHallEstado CHECK (AUDHallEstado IN ('ABIERTO','EN_PROCESO','CERRADO'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_AUDHall_Conc   ON mySiss_AUDHallazgo(AUDHallConcId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_AUDHall_Estado ON mySiss_AUDHallazgo(AUDHallEstado)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_AUDHall_Clasif ON mySiss_AUDHallazgo(AUDHallClasificacion)")

    // AUD005 - Plan de acción sobre hallazgo
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_AUDPlanAccion ("_
        " AUDPlanId          INTEGER NOT NULL,"_
        " AUDPlanHallId      INTEGER NOT NULL,"_
        " AUDPlanDescripcion VARCHAR(2000) NOT NULL,"_
        " AUDPlanResponsable VARCHAR(200),"_
        " AUDPlanFechaLimite DATE,"_
        " AUDPlanFechaEjecucion DATE,"_
        " AUDPlanEstado      VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',"_ // PENDIENTE, EN_EJECUCION, CUMPLIDO, VENCIDO
        " AUDPlanEvidencia   VARCHAR(500),"_
        " AUDPlanFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " AUDPlanCreadoPor   VARCHAR(50),"_
        " CONSTRAINT PK_AUDPlan PRIMARY KEY (AUDPlanId),"_
        " CONSTRAINT FK_AUDPlan_Hall FOREIGN KEY (AUDPlanHallId) REFERENCES mySiss_AUDHallazgo(AUDHallId),"_
        " CONSTRAINT CHK_AUDPlanEstado CHECK (AUDPlanEstado IN ('PENDIENTE','EN_EJECUCION','CUMPLIDO','VENCIDO'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_AUDPlan_Hall   ON mySiss_AUDPlanAccion(AUDPlanHallId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_AUDPlan_Estado ON mySiss_AUDPlanAccion(AUDPlanEstado)")

    // AUD006 - Resultados / Informe de auditoría
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_AUDResultado ("_
        " AUDResId           INTEGER NOT NULL,"_
        " AUDResConcId       INTEGER NOT NULL,"_
        " AUDResNumInforme   VARCHAR(30),"_
        " AUDResFecha        DATE NOT NULL,"_
        " AUDResResumen      VARCHAR(4000),"_
        " AUDResConclusion   VARCHAR(4000),"_
        " AUDResRecomendacion VARCHAR(4000),"_
        " AUDResEstado       VARCHAR(20) NOT NULL DEFAULT 'BORRADOR',"_ // BORRADOR, REVISADO, APROBADO, ENVIADO
        " AUDResElaboradoPor VARCHAR(50),"_
        " AUDResFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " CONSTRAINT PK_AUDRes PRIMARY KEY (AUDResId),"_
        " CONSTRAINT FK_AUDRes_Conc FOREIGN KEY (AUDResConcId) REFERENCES mySiss_AUDAuditoriaConcurrente(AUDConcId),"_
        " CONSTRAINT CHK_AUDResEstado CHECK (AUDResEstado IN ('BORRADOR','REVISADO','APROBADO','ENVIADO'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_AUDRes_Conc  ON mySiss_AUDResultado(AUDResConcId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_AUDRes_Fecha ON mySiss_AUDResultado(AUDResFecha)")

    Write " Tablas AUD creadas OK",!
    Quit $$$OK
}

// ===========================================================

//  MÓDULO GLOSAS (GLO)

// ===========================================================

ClassMethod CreateGloTables() As %Status
{
    Write "--- Módulo Glosas (GLO) ---",!

    // GLO001 - Aseguradora / EPS / Pagador
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_GLOAseguradora ("_
        " GLOAseId           INTEGER NOT NULL,"_
        " GLOAseNit          VARCHAR(20) NOT NULL,"_
        " GLOAseNombre       VARCHAR(200) NOT NULL,"_
        " GLOAseEmail        VARCHAR(200),"_
        " GLOAseTelefono     VARCHAR(30),"_
        " GLOAseDireccion    VARCHAR(300),"_
        " GLOAseEstado       CHAR(1) NOT NULL DEFAULT 'A',"_
        " GLOAseFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " CONSTRAINT PK_GLOAse PRIMARY KEY (GLOAseId),"_
        " CONSTRAINT UK_GLOAse_Nit UNIQUE (GLOAseNit),"_
        " CONSTRAINT CHK_GLOAseEstado CHECK (GLOAseEstado IN ('A','I'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLOAse_Nit ON mySiss_GLOAseguradora(GLOAseNit)")

    // GLO002 - Convenio entre IPS y Aseguradora
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_GLOConvenio ("_
        " GLOConvId          INTEGER NOT NULL,"_
        " GLOConvAseId       INTEGER NOT NULL,"_
        " GLOConvNombre      VARCHAR(200) NOT NULL,"_
        " GLOConvNumero      VARCHAR(50),"_
        " GLOConvFechaInicio DATE NOT NULL,"_
        " GLOConvFechaFin    DATE,"_
        " GLOConvTiempo      INTEGER,"_   // días hábiles para respuesta
        " GLOConvEstado      CHAR(1) NOT NULL DEFAULT 'A',"_
        " GLOConvFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " CONSTRAINT PK_GLOConv PRIMARY KEY (GLOConvId),"_
        " CONSTRAINT FK_GLOConv_Ase FOREIGN KEY (GLOConvAseId) REFERENCES mySiss_GLOAseguradora(GLOAseId),"_
        " CONSTRAINT CHK_GLOConvEstado CHECK (GLOConvEstado IN ('A','I'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLOConv_Ase    ON mySiss_GLOConvenio(GLOConvAseId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLOConv_Estado ON mySiss_GLOConvenio(GLOConvEstado)")

    // GLO003 - Factura radicada
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_GLOFactura ("_
        " GLOFactId          INTEGER NOT NULL,"_
        " GLOFactNumero      VARCHAR(50) NOT NULL,"_
        " GLOFactFechaRadicacion DATE NOT NULL,"_
        " GLOFactFechaFactura DATE NOT NULL,"_
        " GLOFactAseId       INTEGER NOT NULL,"_
        " GLOFactConvId      INTEGER,"_
        " GLOFactValorTotal  DECIMAL(18,2) NOT NULL,"_
        " GLOFactValorGlosado DECIMAL(18,2) DEFAULT 0,"_
        " GLOFactValorAceptado DECIMAL(18,2) DEFAULT 0,"_
        " GLOFactPacienteDoc VARCHAR(30),"_
        " GLOFactPacienteNombre VARCHAR(200),"_
        " GLOFactPacienteEps  VARCHAR(100),"_
        " GLOFactTipoServicio VARCHAR(100),"_
        " GLOFactEstado      VARCHAR(30) NOT NULL DEFAULT 'RADICADA',"_  // RADICADA, EN_PROCESO, DEVUELTA, PAGADA, GLOSADA
        " GLOFactFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " GLOFactCreadoPor   VARCHAR(50),"_
        " GLOFactFechaModificacion TIMESTAMP,"_
        " GLOFactModificadoPor VARCHAR(50),"_
        " CONSTRAINT PK_GLOFact PRIMARY KEY (GLOFactId),"_
        " CONSTRAINT UK_GLOFact_Numero UNIQUE (GLOFactNumero),"_
        " CONSTRAINT FK_GLOFact_Ase  FOREIGN KEY (GLOFactAseId)  REFERENCES mySiss_GLOAseguradora(GLOAseId),"_
        " CONSTRAINT FK_GLOFact_Conv FOREIGN KEY (GLOFactConvId) REFERENCES mySiss_GLOConvenio(GLOConvId),"_
        " CONSTRAINT CHK_GLOFactEstado CHECK (GLOFactEstado IN ('RADICADA','EN_PROCESO','DEVUELTA','PAGADA','GLOSADA','CONCILIADA'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLOFact_Ase    ON mySiss_GLOFactura(GLOFactAseId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLOFact_Fecha  ON mySiss_GLOFactura(GLOFactFechaRadicacion)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLOFact_Estado ON mySiss_GLOFactura(GLOFactEstado)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLOFact_PacDoc ON mySiss_GLOFactura(GLOFactPacienteDoc)")

    // GLO004 - Devolución de factura
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_GLODevolucion ("_
        " GLODevId           INTEGER NOT NULL,"_
        " GLODevFactId       INTEGER NOT NULL,"_
        " GLODevFecha        DATE NOT NULL,"_
        " GLODevMotivo       VARCHAR(500) NOT NULL,"_
        " GLODevDocumento    VARCHAR(200),"_     // Ruta del documento adjunto
        " GLODevEstado       VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',"_  // PENDIENTE, SUBSANADA, ANULADA
        " GLODevFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " GLODevCreadoPor    VARCHAR(50),"_
        " GLODevFechaSubsanacion DATE,"_
        " CONSTRAINT PK_GLODev PRIMARY KEY (GLODevId),"_
        " CONSTRAINT FK_GLODev_Fact FOREIGN KEY (GLODevFactId) REFERENCES mySiss_GLOFactura(GLOFactId),"_
        " CONSTRAINT CHK_GLODevEstado CHECK (GLODevEstado IN ('PENDIENTE','SUBSANADA','ANULADA'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLODev_Fact   ON mySiss_GLODevolucion(GLODevFactId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLODev_Fecha  ON mySiss_GLODevolucion(GLODevFecha)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLODev_Estado ON mySiss_GLODevolucion(GLODevEstado)")

    // GLO005 - Objeción / Glosa
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_GLOObjecion ("_
        " GLOObjId           INTEGER NOT NULL,"_
        " GLOObjFactId       INTEGER NOT NULL,"_
        " GLOObjNumero       VARCHAR(30) NOT NULL,"_
        " GLOObjFechaRecepcion DATE NOT NULL,"_
        " GLOObjTipo         VARCHAR(30),"_      // GLOSA, DEVOLUCION, OBJETADA
        " GLOObjCodigo       VARCHAR(20),"_      // Código RIPS/manual de la glosa
        " GLOObjDescripcion  VARCHAR(2000) NOT NULL,"_
        " GLOObjValor        DECIMAL(18,2) NOT NULL,"_
        " GLOObjResponsableId INTEGER,"_
        " GLOObjEstado       VARCHAR(30) NOT NULL DEFAULT 'RECIBIDA',"_  // RECIBIDA, ASIGNADA, EN_RESPUESTA, CONCILIADA, ACEPTADA, NO_ACEPTADA
        " GLOObjFechaLimiteRespuesta DATE,"_
        " GLOObjFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " GLOObjCreadoPor    VARCHAR(50),"_
        " CONSTRAINT PK_GLOObj PRIMARY KEY (GLOObjId),"_
        " CONSTRAINT FK_GLOObj_Fact FOREIGN KEY (GLOObjFactId) REFERENCES mySiss_GLOFactura(GLOFactId),"_
        " CONSTRAINT CHK_GLOObjEstado CHECK (GLOObjEstado IN ('RECIBIDA','ASIGNADA','EN_RESPUESTA','CONCILIADA','ACEPTADA','NO_ACEPTADA'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLOObj_Fact   ON mySiss_GLOObjecion(GLOObjFactId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLOObj_Estado ON mySiss_GLOObjecion(GLOObjEstado)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLOObj_Resp   ON mySiss_GLOObjecion(GLOObjResponsableId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLOObj_Fecha  ON mySiss_GLOObjecion(GLOObjFechaRecepcion)")

    // GLO006 - Respuesta a objeción
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_GLORespuesta ("_
        " GLORespId          INTEGER NOT NULL,"_
        " GLORespObjId       INTEGER NOT NULL,"_
        " GLORespFecha       DATE NOT NULL,"_
        " GLORespTipo        VARCHAR(20),"_      // IPS, ASEGURADORA
        " GLORespDescripcion VARCHAR(4000) NOT NULL,"_
        " GLORespValorAceptado DECIMAL(18,2) DEFAULT 0,"_
        " GLORespDocumento   VARCHAR(200),"_
        " GLORespEstado      VARCHAR(20) NOT NULL DEFAULT 'ENVIADA',"_
        " GLORespCreadoPor   VARCHAR(50),"_
        " GLORespFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " CONSTRAINT PK_GLOResp PRIMARY KEY (GLORespId),"_
        " CONSTRAINT FK_GLOResp_Obj FOREIGN KEY (GLORespObjId) REFERENCES mySiss_GLOObjecion(GLOObjId)"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLOResp_Obj   ON mySiss_GLORespuesta(GLORespObjId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLOResp_Fecha ON mySiss_GLORespuesta(GLORespFecha)")

    // GLO007 - Conciliación
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_GLOConciliacion ("_
        " GLOConcilId        INTEGER NOT NULL,"_
        " GLOConcilObjId     INTEGER NOT NULL,"_
        " GLOConcilFecha     DATE NOT NULL,"_
        " GLOConcilActa      VARCHAR(50),"_
        " GLOConcilValorConciliado DECIMAL(18,2) DEFAULT 0,"_
        " GLOConcilObservacion VARCHAR(2000),"_
        " GLOConcilResultado VARCHAR(30),"_  // ACEPTADA, PARCIALMENTE_ACEPTADA, RECHAZADA
        " GLOConcilCreadoPor VARCHAR(50),"_
        " GLOConcilFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " CONSTRAINT PK_GLOConcil PRIMARY KEY (GLOConcilId),"_
        " CONSTRAINT FK_GLOConcil_Obj FOREIGN KEY (GLOConcilObjId) REFERENCES mySiss_GLOObjecion(GLOObjId)"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLOConcil_Obj   ON mySiss_GLOConciliacion(GLOConcilObjId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_GLOConcil_Fecha ON mySiss_GLOConciliacion(GLOConcilFecha)")

    Write " Tablas GLO creadas OK",!
    Quit $$$OK
}

// ===========================================================

//  MÓDULO HONORARIOS (HON)

// ===========================================================

ClassMethod CreateHonTables() As %Status
{
    Write "--- Módulo Honorarios (HON) ---",!

    // HON001 - Especialidad médica
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_HONEspecialidad ("_
        " HONEspId           INTEGER NOT NULL,"_
        " HONEspCodigo       VARCHAR(20) NOT NULL,"_
        " HONEspNombre       VARCHAR(150) NOT NULL,"_
        " HONEspEstado       CHAR(1) NOT NULL DEFAULT 'A',"_
        " CONSTRAINT PK_HONEsp PRIMARY KEY (HONEspId),"_
        " CONSTRAINT UK_HONEsp_Codigo UNIQUE (HONEspCodigo),"_
        " CONSTRAINT CHK_HONEspEstado CHECK (HONEspEstado IN ('A','I'))"_
        ")")

    // HON002 - Médico / Profesional
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_HONMedico ("_
        " HONMedId           INTEGER NOT NULL,"_
        " HONMedDocTipo      VARCHAR(10) NOT NULL,"_
        " HONMedDocNumero    VARCHAR(20) NOT NULL,"_
        " HONMedNombre       VARCHAR(100) NOT NULL,"_
        " HONMedApellido     VARCHAR(100) NOT NULL,"_
        " HONMedRegistroMedico VARCHAR(30),"_
        " HONMedEspId        INTEGER,"_
        " HONMedEmail        VARCHAR(200),"_
        " HONMedTelefono     VARCHAR(30),"_
        " HONMedBanco        VARCHAR(100),"_
        " HONMedCuentaBanco  VARCHAR(30),"_
        " HONMedTipoCuenta   VARCHAR(20),"_   // AHORROS, CORRIENTE
        " HONMedEstado       CHAR(1) NOT NULL DEFAULT 'A',"_
        " HONMedFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " CONSTRAINT PK_HONMed PRIMARY KEY (HONMedId),"_
        " CONSTRAINT UK_HONMed_Doc UNIQUE (HONMedDocTipo, HONMedDocNumero),"_
        " CONSTRAINT FK_HONMed_Esp FOREIGN KEY (HONMedEspId) REFERENCES mySiss_HONEspecialidad(HONEspId),"_
        " CONSTRAINT CHK_HONMedEstado CHECK (HONMedEstado IN ('A','I'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_HONMed_Doc   ON mySiss_HONMedico(HONMedDocNumero)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_HONMed_Esp   ON mySiss_HONMedico(HONMedEspId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_HONMed_Estado ON mySiss_HONMedico(HONMedEstado)")

    // HON003 - Contrato de honorarios
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_HONContrato ("_
        " HONContrId         INTEGER NOT NULL,"_
        " HONContrMedId      INTEGER NOT NULL,"_
        " HONContrNumero     VARCHAR(50) NOT NULL,"_
        " HONContrFechaInicio DATE NOT NULL,"_
        " HONContrFechaFin   DATE,"_
        " HONContrTipo       VARCHAR(30),"_   // MENSUAL, POR_SERVICIO, HIS
        " HONContrValorBase  DECIMAL(18,2),"_
        " HONContrEstado     VARCHAR(20) NOT NULL DEFAULT 'ACTIVO',"_ // ACTIVO, SUSPENDIDO, TERMINADO
        " HONContrObservacion VARCHAR(500),"_
        " HONContrFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " HONContrCreadoPor  VARCHAR(50),"_
        " CONSTRAINT PK_HONContr PRIMARY KEY (HONContrId),"_
        " CONSTRAINT UK_HONContr_Numero UNIQUE (HONContrNumero),"_
        " CONSTRAINT FK_HONContr_Med FOREIGN KEY (HONContrMedId) REFERENCES mySiss_HONMedico(HONMedId),"_
        " CONSTRAINT CHK_HONContrEstado CHECK (HONContrEstado IN ('ACTIVO','SUSPENDIDO','TERMINADO'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_HONContr_Med    ON mySiss_HONContrato(HONContrMedId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_HONContr_Estado ON mySiss_HONContrato(HONContrEstado)")

    // HON004 - Servicio / Procedimiento valorado
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_HONServicio ("_
        " HONSvcId           INTEGER NOT NULL,"_
        " HONSvcCodigo       VARCHAR(30) NOT NULL,"_   // CUPS
        " HONSvcNombre       VARCHAR(300) NOT NULL,"_
        " HONSvcEspId        INTEGER,"_
        " HONSvcValorUnitario DECIMAL(18,2),"_
        " HONSvcTipo         VARCHAR(30),"_    // CONSULTA, PROCEDIMIENTO, CIRUGIA
        " HONSvcEstado       CHAR(1) NOT NULL DEFAULT 'A',"_
        " CONSTRAINT PK_HONSvc PRIMARY KEY (HONSvcId),"_
        " CONSTRAINT UK_HONSvc_Codigo UNIQUE (HONSvcCodigo),"_
        " CONSTRAINT CHK_HONSvcEstado CHECK (HONSvcEstado IN ('A','I'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_HONSvc_Codigo ON mySiss_HONServicio(HONSvcCodigo)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_HONSvc_Esp    ON mySiss_HONServicio(HONSvcEspId)")

    // HON005 - Cargue / Producción del médico (HIS o manual)
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_HONCargue ("_
        " HONCargId          INTEGER NOT NULL,"_
        " HONCargContrId     INTEGER NOT NULL,"_
        " HONCargPeriodoAno  INTEGER NOT NULL,"_
        " HONCargPeriodoMes  INTEGER NOT NULL,"_
        " HONCargFechaCargue TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " HONCargTipo        VARCHAR(20),"_    // MANUAL, HIS
        " HONCargArchivoNombre VARCHAR(200),"_
        " HONCargRegistros   INTEGER DEFAULT 0,"_
        " HONCargEstado      VARCHAR(20) NOT NULL DEFAULT 'CARGADO',"_ // CARGADO, VALIDADO, LIQUIDADO, ANULADO
        " HONCargCreadoPor   VARCHAR(50),"_
        " CONSTRAINT PK_HONCarg PRIMARY KEY (HONCargId),"_
        " CONSTRAINT FK_HONCarg_Contr FOREIGN KEY (HONCargContrId) REFERENCES mySiss_HONContrato(HONContrId),"_
        " CONSTRAINT CHK_HONCargEstado CHECK (HONCargEstado IN ('CARGADO','VALIDADO','LIQUIDADO','ANULADO'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_HONCarg_Contr  ON mySiss_HONCargue(HONCargContrId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_HONCarg_Estado ON mySiss_HONCargue(HONCargEstado)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_HONCarg_Periodo ON mySiss_HONCargue(HONCargPeriodoAno, HONCargPeriodoMes)")

    // HON006 - Detalle del cargue (línea por servicio prestado)
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_HONCargueDetalle ("_
        " HONCargDetId       INTEGER NOT NULL,"_
        " HONCargDetCargId   INTEGER NOT NULL,"_
        " HONCargDetFecha    DATE NOT NULL,"_
        " HONCargDetSvcId    INTEGER,"_
        " HONCargDetCodSvc   VARCHAR(30),"_
        " HONCargDetNomSvc   VARCHAR(300),"_
        " HONCargDetCantidad DECIMAL(10,2) NOT NULL DEFAULT 1,"_
        " HONCargDetValorUnitario DECIMAL(18,2),"_
        " HONCargDetValorTotal DECIMAL(18,2),"_
        " HONCargDetPacienteDoc VARCHAR(30),"_
        " HONCargDetObservacion VARCHAR(500),"_
        " CONSTRAINT PK_HONCargDet PRIMARY KEY (HONCargDetId),"_
        " CONSTRAINT FK_HONCargDet_Carg FOREIGN KEY (HONCargDetCargId) REFERENCES mySiss_HONCargue(HONCargId),"_
        " CONSTRAINT FK_HONCargDet_Svc  FOREIGN KEY (HONCargDetSvcId)  REFERENCES mySiss_HONServicio(HONSvcId)"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_HONCargDet_Carg ON mySiss_HONCargueDetalle(HONCargDetCargId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_HONCargDet_Fecha ON mySiss_HONCargueDetalle(HONCargDetFecha)")

    // HON007 - Liquidación de honorarios
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_HONLiquidacion ("_
        " HONLiqId           INTEGER NOT NULL,"_
        " HONLiqContrId      INTEGER NOT NULL,"_
        " HONLiqPeriodoAno   INTEGER NOT NULL,"_
        " HONLiqPeriodoMes   INTEGER NOT NULL,"_
        " HONLiqFechaLiquidacion DATE NOT NULL,"_
        " HONLiqValorBruto   DECIMAL(18,2) NOT NULL,"_
        " HONLiqDescuentos   DECIMAL(18,2) DEFAULT 0,"_
        " HONLiqRetencion    DECIMAL(18,2) DEFAULT 0,"_
        " HONLiqValorNeto    DECIMAL(18,2) NOT NULL,"_
        " HONLiqEstado       VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',"_ // PENDIENTE, APROBADA, PAGADA, ANULADA
        " HONLiqFechaPago    DATE,"_
        " HONLiqObservacion  VARCHAR(500),"_
        " HONLiqCreadoPor    VARCHAR(50),"_
        " HONLiqFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " CONSTRAINT PK_HONLiq PRIMARY KEY (HONLiqId),"_
        " CONSTRAINT FK_HONLiq_Contr FOREIGN KEY (HONLiqContrId) REFERENCES mySiss_HONContrato(HONContrId),"_
        " CONSTRAINT CHK_HONLiqEstado CHECK (HONLiqEstado IN ('PENDIENTE','APROBADA','PAGADA','ANULADA'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_HONLiq_Contr   ON mySiss_HONLiquidacion(HONLiqContrId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_HONLiq_Estado  ON mySiss_HONLiquidacion(HONLiqEstado)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_HONLiq_Periodo ON mySiss_HONLiquidacion(HONLiqPeriodoAno, HONLiqPeriodoMes)")

    Write " Tablas HON creadas OK",!
    Quit $$$OK
}

// ===========================================================

//  MÓDULO CUENTAS MÉDICAS (CUE)

// ===========================================================

ClassMethod CreateCueTables() As %Status
{
    Write "--- Módulo Cuentas Médicas (CUE) ---",!

    // CUE001 - Cuenta médica (cabecera)
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_CUECuenta ("_
        " CUECuentaId        INTEGER NOT NULL,"_
        " CUECuentaNumero    VARCHAR(50) NOT NULL,"_
        " CUECuentaFactId    INTEGER,"_         // FK a GLO factura
        " CUECuentaFechaIngreso DATE NOT NULL,"_
        " CUECuentaFechaEgreso  DATE,"_
        " CUECuentaPacienteDoc VARCHAR(30),"_
        " CUECuentaPacienteNombre VARCHAR(200),"_
        " CUECuentaEps       VARCHAR(100),"_
        " CUECuentaTipoRegimen VARCHAR(30),"_   // CONTRIBUTIVO, SUBSIDIADO, PARTICULAR
        " CUECuentaServicio  VARCHAR(100),"_
        " CUECuentaDiagnostico VARCHAR(20),"_   // CIE-10
        " CUECuentaValorTotal DECIMAL(18,2),"_
        " CUECuentaEstado    VARCHAR(30) NOT NULL DEFAULT 'EN_AUDITORIA',"_ // EN_AUDITORIA, AUDITADA, APROBADA, GLOSADA, PAGADA
        " CUECuentaAuditorId INTEGER,"_
        " CUECuentaFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " CUECuentaCreadoPor VARCHAR(50),"_
        " CONSTRAINT PK_CUECuenta PRIMARY KEY (CUECuentaId),"_
        " CONSTRAINT UK_CUECuenta_Numero UNIQUE (CUECuentaNumero),"_
        " CONSTRAINT FK_CUECuenta_Fact FOREIGN KEY (CUECuentaFactId) REFERENCES mySiss_GLOFactura(GLOFactId),"_
        " CONSTRAINT CHK_CUECuentaEstado CHECK (CUECuentaEstado IN ('EN_AUDITORIA','AUDITADA','APROBADA','GLOSADA','PAGADA'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_CUECuenta_Estado  ON mySiss_CUECuenta(CUECuentaEstado)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_CUECuenta_PacDoc  ON mySiss_CUECuenta(CUECuentaPacienteDoc)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_CUECuenta_Eps     ON mySiss_CUECuenta(CUECuentaEps)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_CUECuenta_Fecha   ON mySiss_CUECuenta(CUECuentaFechaIngreso)")

    // CUE002 - Convenio de auditoría de cuentas
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_CUEConvenioAuditoria ("_
        " CUEConvAudId       INTEGER NOT NULL,"_
        " CUEConvAudAseId    INTEGER NOT NULL,"_
        " CUEConvAudNombre   VARCHAR(200) NOT NULL,"_
        " CUEConvAudTipo     VARCHAR(50),"_    // PREPAGO, EPS, ARS
        " CUEConvAudDias     INTEGER,"_        // días hábiles para auditoría
        " CUEConvAudEstado   CHAR(1) NOT NULL DEFAULT 'A',"_
        " CONSTRAINT PK_CUEConvAud PRIMARY KEY (CUEConvAudId),"_
        " CONSTRAINT FK_CUEConvAud_Ase FOREIGN KEY (CUEConvAudAseId) REFERENCES mySiss_GLOAseguradora(GLOAseId),"_
        " CONSTRAINT CHK_CUEConvAudEstado CHECK (CUEConvAudEstado IN ('A','I'))"_
        ")")

    // CUE003 - Validaciones de cuenta (checklist de auditoría)
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_CUEValidacion ("_
        " CUEValId           INTEGER NOT NULL,"_
        " CUEValCuentaId     INTEGER NOT NULL,"_
        " CUEValTipo         VARCHAR(50),"_   // ADMINISTRATIVA, MEDICA, CLINICA
        " CUEValItem         VARCHAR(300) NOT NULL,"_
        " CUEValResultado    CHAR(1),"_       // S=Si/Cumple, N=No/No cumple, NA=No aplica
        " CUEValObservacion  VARCHAR(1000),"_
        " CUEValAuditorId    INTEGER,"_
        " CUEValFecha        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " CONSTRAINT PK_CUEVal PRIMARY KEY (CUEValId),"_
        " CONSTRAINT FK_CUEVal_Cuenta FOREIGN KEY (CUEValCuentaId) REFERENCES mySiss_CUECuenta(CUECuentaId)"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_CUEVal_Cuenta ON mySiss_CUEValidacion(CUEValCuentaId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_CUEVal_Tipo   ON mySiss_CUEValidacion(CUEValTipo)")

    // CUE004 - Estado detallado de la cuenta por proceso
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_CUEEstadoCuenta ("_
        " CUEEstId           INTEGER NOT NULL,"_
        " CUEEstCuentaId     INTEGER NOT NULL,"_
        " CUEEstFecha        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " CUEEstEstadoAnterior VARCHAR(30),"_
        " CUEEstEstadoNuevo  VARCHAR(30) NOT NULL,"_
        " CUEEstMotivo       VARCHAR(500),"_
        " CUEEstUsuario      VARCHAR(50),"_
        " CONSTRAINT PK_CUEEst PRIMARY KEY (CUEEstId),"_
        " CONSTRAINT FK_CUEEst_Cuenta FOREIGN KEY (CUEEstCuentaId) REFERENCES mySiss_CUECuenta(CUECuentaId)"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_CUEEst_Cuenta ON mySiss_CUEEstadoCuenta(CUEEstCuentaId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_CUEEst_Fecha  ON mySiss_CUEEstadoCuenta(CUEEstFecha)")

    Write " Tablas CUE creadas OK",!
    Quit $$$OK
}

// ===========================================================

//  CREACIÓN DEL SUPERUSUARIO

// ===========================================================

ClassMethod CreateSuperUser() As %Status
{
    Write "--- Creando superusuario ---",!

    // Verificar si ya existe
    Set rs = ##class(%SQL.Statement).%New()
    Set sc = rs.%Prepare("SELECT COUNT(*) AS cnt FROM mySiss_SEGUsuario WHERE SEGUsuTipoUsuario = 'SUPER'")
    If $$$ISOK(sc) {
        Set result = rs.%Execute()
        If result.%Next() {
            If result.%Get("cnt") > 0 {
                Write " Superusuario ya existe, omitiendo creación",!
                Quit $$$OK
            }
        }
    }

    // Salt único
    Set salt = $system.Encryption.GenCryptToken(32)
    // Hash SHA-256 con salt: password = "Admin2025*" (debe cambiarse en primer ingreso)
    Set rawPassword = "Admin2025*"
    Set passwordConSalt = rawPassword_salt
    Set passwordHash = $system.Encryption.SHA256Hash(passwordConSalt)

    Set sc = ##class(%SQL.Statement).%New()
    Set prepSC = sc.%Prepare(
        "INSERT INTO mySiss_SEGUsuario ("_
        " SEGUsuId, SEGUsuLogin, SEGUsuPasswordHash, SEGUsuSalt,"_
        " SEGUsuNombre, SEGUsuApellido, SEGUsuCorreo, SEGUsuCelular,"_
        " SEGUsuTipoUsuario, SEGUsuEstado, SEGUsuPrimerIngreso, SEGUsuCreadoPor"_
        ") VALUES (1, 'ABAP', ?, ?, 'Administrador', 'mySiss', 'admin@mysiss.com', '3000000000',"_
        " 'SUPER', 'A', 'N', 'SYSTEM')")
    If $$$ISOK(prepSC) {
        Set result = sc.%Execute(passwordHash, salt)
        If result.%SQLCODE = 0 {
            Write " Superusuario creado: Login=ABAP, Password=Admin2025*",!
            Write " IMPORTANTE: El superusuario fue marcado con SEGUsuPrimerIngreso=N para",!
            Write "             que pueda ingresar directamente. Cambie la clave después.",!
        } Else {
            Write " Error creando superusuario: "_result.%Message,!
        }
    } Else {
        Write " Error preparando INSERT superusuario",!
    }

    // Crear rol SUPER y asignarlo
    Set scRol = ##class(%SQL.Statement).%New()
    Set prepRol = scRol.%Prepare(
        "INSERT INTO mySiss_SEGRol (SEGRolId, SEGRolNombre, SEGRolDescripcion, SEGRolEstado, SEGRolCreadoPor)"_
        " VALUES (1, 'SUPERADMIN', 'Rol de superadministrador con acceso total', 'A', 'SYSTEM')")
    If $$$ISOK(prepRol) {
        Set resRol = scRol.%Execute()
        If resRol.%SQLCODE = 0 {
            Write " Rol SUPERADMIN creado",!
        }
    }

    // Asignar rol al superusuario
    Set scAsig = ##class(%SQL.Statement).%New()
    Set prepAsig = scAsig.%Prepare(
        "INSERT INTO mySiss_SEGUsuarioRol (SEGUsuRolUsuId, SEGUsuRolRolId, SEGUsuRolAsignadoPor)"_
        " VALUES (1, 1, 'SYSTEM')")
    If $$$ISOK(prepAsig) {
        Set resAsig = scAsig.%Execute()
        If resAsig.%SQLCODE = 0 {
            Write " Rol asignado al superusuario",!
        }
    }

    // Parámetros de seguridad iniciales
    Do ..InsertParam("PASSWORD_MIN_LENGTH",    "8",    "Longitud mínima de contraseña")
    Do ..InsertParam("PASSWORD_REQUIRE_UPPER", "1",    "Requiere mayúscula en contraseña")
    Do ..InsertParam("PASSWORD_REQUIRE_LOWER", "1",    "Requiere minúscula en contraseña")
    Do ..InsertParam("PASSWORD_REQUIRE_NUMBER","1",    "Requiere número en contraseña")
    Do ..InsertParam("PASSWORD_REQUIRE_SPECIAL","1",   "Requiere carácter especial en contraseña")
    Do ..InsertParam("TOKEN_EXPIRACION_MINUTOS","10",  "Minutos de vigencia del token de recuperación")
    Do ..InsertParam("MAX_INTENTOS_FALLIDOS",  "5",    "Intentos fallidos antes de bloquear usuario")
    Do ..InsertParam("EMAIL_SMTP_HOST",        "smtp.mysiss.com", "Servidor SMTP para envío de correos")
    Do ..InsertParam("EMAIL_SMTP_PORT",        "587",  "Puerto SMTP")
    Do ..InsertParam("EMAIL_FROM",             "noreply@mysiss.com", "Correo origen para notificaciones")
    Do ..InsertParam("SESSION_TIMEOUT_MIN",    "30",   "Minutos de inactividad antes de cerrar sesión")

    Write " Parámetros de seguridad creados",!
    Quit $$$OK
}

// ===========================================================

//  MÓDULO CLIENTES (MS) - Multi-tenant

// ===========================================================

ClassMethod CreateMSTables() As %Status
{
    Write "--- Módulo Clientes/Sedes (MS) ---",!

    // MS001 - Cliente (Prestador/IPS)
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_MSCliente ("_
        " MSClienteId           INTEGER NOT NULL,"_
        " MSClienteNit          VARCHAR(20) NOT NULL,"_
        " MSClienteNombre       VARCHAR(200) NOT NULL,"_
        " MSClienteRazonSocial  VARCHAR(200),"_
        " MSClienteEmail        VARCHAR(150),"_
        " MSClienteTelefono     VARCHAR(30),"_
        " MSClienteDireccion    VARCHAR(300),"_
        " MSClienteCiudad       VARCHAR(100),"_
        " MSClienteDepartamento VARCHAR(100),"_
        " MSClienteContacto     VARCHAR(150),"_
        " MSClienteEstado       CHAR(1) NOT NULL DEFAULT 'A',"_
        " MSClienteFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " MSClienteCreadoPor    VARCHAR(50),"_
        " CONSTRAINT PK_MSCliente PRIMARY KEY (MSClienteId),"_
        " CONSTRAINT UK_MSCliente_Nit UNIQUE (MSClienteNit),"_
        " CONSTRAINT CHK_MSClienteEstado CHECK (MSClienteEstado IN ('A','I'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_MSCliente_Nombre ON mySiss_MSCliente(MSClienteNombre)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_MSCliente_Estado ON mySiss_MSCliente(MSClienteEstado)")

    // MS002 - Sede del cliente
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_MSClienteSede ("_
        " MSSedeId              INTEGER NOT NULL,"_
        " MSSedeClienteId       INTEGER NOT NULL,"_
        " MSSedeNombre          VARCHAR(200) NOT NULL,"_
        " MSSedeCodigoHabilitacion VARCHAR(30),"_
        " MSSedeDireccion       VARCHAR(300),"_
        " MSSedeCiudad          VARCHAR(100),"_
        " MSSedeDepartamento    VARCHAR(100),"_
        " MSSedeEmail           VARCHAR(150),"_
        " MSSedeTelefono        VARCHAR(30),"_
        " MSSedeResponsable     VARCHAR(150),"_
        " MSSedeEstado          CHAR(1) NOT NULL DEFAULT 'A',"_
        " MSSedeFechaCreacion   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " MSSedeObservacion     VARCHAR(500),"_
        " CONSTRAINT PK_MSClienteSede PRIMARY KEY (MSSedeId),"_
        " CONSTRAINT FK_MSClienteSede_Cliente FOREIGN KEY (MSSedeClienteId) REFERENCES mySiss_MSCliente(MSClienteId),"_
        " CONSTRAINT CHK_MSSedeEstado CHECK (MSSedeEstado IN ('A','I'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_MSClienteSede_ClienteId ON mySiss_MSClienteSede(MSSedeClienteId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_MSClienteSede_Estado ON mySiss_MSClienteSede(MSSedeEstado)")

    // MS003 - Módulos disponibles del sistema
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_MSModulo ("_
        " MSModuloId          INTEGER NOT NULL,"_
        " MSModuloNombre      VARCHAR(100) NOT NULL,"_
        " MSModuloCodigo      VARCHAR(20) NOT NULL,"_
        " MSModuloDescripcion VARCHAR(300),"_
        " MSModuloIcono       VARCHAR(50),"_
        " MSModuloOrden       INTEGER DEFAULT 1,"_
        " MSModuloEstado      CHAR(1) NOT NULL DEFAULT 'A',"_
        " CONSTRAINT PK_MSModulo PRIMARY KEY (MSModuloId),"_
        " CONSTRAINT UK_MSModulo_Codigo UNIQUE (MSModuloCodigo),"_
        " CONSTRAINT CHK_MSModuloEstado CHECK (MSModuloEstado IN ('A','I'))"_
        ")")

    // MS004 - Módulos contratados por cliente
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_MSClienteModulo ("_
        " MSClienteModuloId        INTEGER NOT NULL,"_
        " MSClienteModuloClienteId INTEGER NOT NULL,"_
        " MSClienteModuloModuloId  INTEGER NOT NULL,"_
        " MSClienteModuloFechaInicio DATE NOT NULL,"_
        " MSClienteModuloFechaFin    DATE,"_
        " MSClienteModuloEstado     CHAR(1) NOT NULL DEFAULT 'A',"_
        " MSClienteModuloCreadoPor  VARCHAR(50),"_
        " MSClienteModuloFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " CONSTRAINT PK_MSClienteModulo PRIMARY KEY (MSClienteModuloId),"_
        " CONSTRAINT FK_MSClienteModulo_Cliente FOREIGN KEY (MSClienteModuloClienteId) REFERENCES mySiss_MSCliente(MSClienteId),"_
        " CONSTRAINT FK_MSClienteModulo_Modulo  FOREIGN KEY (MSClienteModuloModuloId)  REFERENCES mySiss_MSModulo(MSModuloId),"_
        " CONSTRAINT UK_MSClienteModulo UNIQUE (MSClienteModuloClienteId, MSClienteModuloModuloId),"_
        " CONSTRAINT CHK_MSClienteModuloEstado CHECK (MSClienteModuloEstado IN ('A','I'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_MSClienteModulo_ClienteId ON mySiss_MSClienteModulo(MSClienteModuloClienteId)")

    // MS005 - Configuración especial de módulo por sede
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_MSSedeModulo ("_
        " MSSedeModuloId       INTEGER NOT NULL,"_
        " MSSedeModuloSedeId   INTEGER NOT NULL,"_
        " MSSedeModuloModuloId INTEGER NOT NULL,"_
        " MSSedeModuloEstado   CHAR(1) NOT NULL DEFAULT 'A',"_
        " MSSedeModuloConfig   VARCHAR(2000),"_
        " MSSedeModuloFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " MSSedeModuloCreadoPor VARCHAR(50),"_
        " CONSTRAINT PK_MSSedeModulo PRIMARY KEY (MSSedeModuloId),"_
        " CONSTRAINT FK_MSSedeModulo_Sede   FOREIGN KEY (MSSedeModuloSedeId)   REFERENCES mySiss_MSClienteSede(MSSedeId),"_
        " CONSTRAINT FK_MSSedeModulo_Modulo FOREIGN KEY (MSSedeModuloModuloId) REFERENCES mySiss_MSModulo(MSModuloId),"_
        " CONSTRAINT UK_MSSedeModulo UNIQUE (MSSedeModuloSedeId, MSSedeModuloModuloId),"_
        " CONSTRAINT CHK_MSSedeModuloEstado CHECK (MSSedeModuloEstado IN ('A','I'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_MSSedeModulo_SedeId ON mySiss_MSSedeModulo(MSSedeModuloSedeId)")

    // MS006 - Asociación usuario ↔ sede
    Do ..ExecSQL("CREATE TABLE IF NOT EXISTS mySiss_MSUsuarioSede ("_
        " MSUsuSedeId           INTEGER NOT NULL,"_
        " MSUsuSedeUsuId        INTEGER NOT NULL,"_
        " MSUsuSedeSedeId       INTEGER NOT NULL,"_
        " MSUsuSedeEsPrincipal  CHAR(1) NOT NULL DEFAULT 'S',"_
        " MSUsuSedeEstado       CHAR(1) NOT NULL DEFAULT 'A',"_
        " MSUsuSedeFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"_
        " MSUsuSedeCreadoPor    VARCHAR(50),"_
        " CONSTRAINT PK_MSUsuarioSede PRIMARY KEY (MSUsuSedeId),"_
        " CONSTRAINT FK_MSUsuarioSede_Usuario FOREIGN KEY (MSUsuSedeUsuId)  REFERENCES mySiss_SEGUsuario(SEGUsuId),"_
        " CONSTRAINT FK_MSUsuarioSede_Sede    FOREIGN KEY (MSUsuSedeSedeId) REFERENCES mySiss_MSClienteSede(MSSedeId),"_
        " CONSTRAINT UK_MSUsuarioSede UNIQUE (MSUsuSedeUsuId, MSUsuSedeSedeId),"_
        " CONSTRAINT CHK_MSUsuSedeEsPrincipal CHECK (MSUsuSedeEsPrincipal IN ('S','N')),"_
        " CONSTRAINT CHK_MSUsuSedeEstado CHECK (MSUsuSedeEstado IN ('A','I'))"_
        ")")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_MSUsuarioSede_UsuId  ON mySiss_MSUsuarioSede(MSUsuSedeUsuId)")
    Do ..ExecSQL("CREATE INDEX IF NOT EXISTS IDX_MSUsuarioSede_SedeId ON mySiss_MSUsuarioSede(MSUsuSedeSedeId)")

    Write " Tablas MS (Clientes/Sedes/Modulos) creadas OK",!

    // Insertar módulos base del sistema
    Do ..InsertModulo(1,"SEGURIDAD",  "SEG","Seguridad y control de accesos",     "fa-lock",1)
    Do ..InsertModulo(2,"AUDITORIA",  "AUD","Auditoría concurrente y de calidad", "fa-clipboard-check",2)
    Do ..InsertModulo(3,"GLOSAS",     "GLO","Gestión de glosas y objeciones",      "fa-file-invoice",3)
    Do ..InsertModulo(4,"HONORARIOS", "HON","Liquidación de honorarios médicos",   "fa-stethoscope",4)
    Do ..InsertModulo(5,"CUENTAS",    "CUE","Auditoría de cuentas médicas",        "fa-folder-open",5)
    Write " Módulos base insertados",!

    Quit $$$OK
}

ClassMethod InsertModulo(id As %Integer, nombre As %String, codigo As %String, desc As %String, icono As %String, orden As %Integer) As %Status
{
    Set sc = ##class(%SQL.Statement).%New()
    Set prepSC = sc.%Prepare(
        "INSERT OR IGNORE INTO mySiss_MSModulo "_
        "(MSModuloId,MSModuloNombre,MSModuloCodigo,MSModuloDescripcion,MSModuloIcono,MSModuloOrden,MSModuloEstado)"_
        " VALUES (?,?,?,?,?,?,'A')")
    If $$$ISOK(prepSC) {
        Do sc.%Execute(id, nombre, codigo, desc, icono, orden)
    }
    Quit $$$OK
}

// ===========================================================

//  HELPERS

// ===========================================================

/// Ejecuta un SQL ignorando errores de "ya existe"
ClassMethod ExecSQL(sql As %String) As %Status
{
    Set sc = ##class(%SQL.Statement).%New()
    Set prepSC = sc.%Prepare(sql)
    If $$$ISERR(prepSC) {
        Write " [WARN] Prepare: ",$system.Status.GetErrorText(prepSC),!
        Quit $$$OK
    }
    Set result = sc.%Execute()
    If (result.%SQLCODE '= 0) && (result.%SQLCODE '= 100) {
        // SQLCODE -201 = tabla ya existe (en algunos dialectos SQL)
        If (result.%SQLCODE '= -201) {
            Write " [WARN] Execute SQLCODE="_result.%SQLCODE_": "_result.%Message,!
        }
    }
    Quit $$$OK
}

/// Inserta un parámetro de seguridad
ClassMethod InsertParam(clave As %String, valor As %String, desc As %String) As %Status
{
    Set sc = ##class(%SQL.Statement).%New()
    Set prepSC = sc.%Prepare(
        "INSERT OR IGNORE INTO mySiss_SEGParametro (SEGParamClave, SEGParamValor, SEGParamDescripcion)"_
        " VALUES (?, ?, ?)")
    If $$$ISOK(prepSC) {
        Do sc.%Execute(clave, valor, desc)
    }
    Quit $$$OK
}

}
