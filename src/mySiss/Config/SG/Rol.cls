Class mySiss.Config.SG.Rol Extends %Persistent [ SqlTableName = Rol ]
{

Property IDRol As %Integer [ Required, SqlFieldName = ID_rol ];

Property Rol As %String(MAXLEN = 100) [ Required, SqlFieldName = Rol ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDRol [ PrimaryKey, Unique ];

Index IDXRol On Rol [ Unique ];

Storage Default
{
<Data name="RolDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDRol</Value>
</Value>
<Value name="3">
<Value>Rol</Value>
</Value>
<Value name="4">
<Value>FechaCrea</Value>
</Value>
<Value name="5">
<Value>FechaModif</Value>
</Value>
<Value name="6">
<Value>UserCreado</Value>
</Value>
<Value name="7">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.SG.RolD</DataLocation>
<DefaultData>RolDefaultData</DefaultData>
<IdLocation>^mySiss.Config.SG.RolD</IdLocation>
<IndexLocation>^mySiss.Config.SG.RolI</IndexLocation>
<StreamLocation>^mySiss.Config.SG.RolS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
