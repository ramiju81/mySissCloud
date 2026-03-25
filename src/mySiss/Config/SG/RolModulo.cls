Class mySiss.Config.SG.RolModulo Extends %Persistent [ SqlTableName = RolModulo ]
{

Property IDRolModulo As %Integer [ Required, SqlFieldName = ID_rolmodulo ];

Property Rol As mySiss.Config.SG.Rol [ Required, SqlFieldName = ID_rol ];

Property Actividad As mySiss.Config.SG.Actividad [ Required, SqlFieldName = ID_actividad ];

Property Crear As %String(MAXLEN = 1) [ SqlFieldName = Crear ];

Property Modificar As %String(MAXLEN = 1) [ SqlFieldName = Modificar ];

Property Visualizar As %String(MAXLEN = 1) [ SqlFieldName = Visualizar ];

Property Eliminar As %String(MAXLEN = 1) [ SqlFieldName = Eliminar ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDRolModulo [ PrimaryKey, Unique ];

Index IDXRolActividad On (Rol, Actividad) [ Unique ];

Index IDXRol On Rol;

Index IDXActividad On Actividad;

ForeignKey FKRolModuloRol(Rol) References mySiss.Config.SG.Rol();

ForeignKey FKRolModuloActividad(Actividad) References mySiss.Config.SG.Actividad();

Storage Default
{
<Data name="RolModuloDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDRolModulo</Value>
</Value>
<Value name="3">
<Value>Rol</Value>
</Value>
<Value name="4">
<Value>Actividad</Value>
</Value>
<Value name="5">
<Value>Crear</Value>
</Value>
<Value name="6">
<Value>Modificar</Value>
</Value>
<Value name="7">
<Value>Visualizar</Value>
</Value>
<Value name="8">
<Value>Eliminar</Value>
</Value>
<Value name="9">
<Value>FechaCrea</Value>
</Value>
<Value name="10">
<Value>FechaModif</Value>
</Value>
<Value name="11">
<Value>UserCreado</Value>
</Value>
<Value name="12">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.SG.RolModuloD</DataLocation>
<DefaultData>RolModuloDefaultData</DefaultData>
<IdLocation>^mySiss.Config.SG.RolModuloD</IdLocation>
<IndexLocation>^mySiss.Config.SG.RolModuloI</IndexLocation>
<StreamLocation>^mySiss.Config.SG.RolModuloS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
