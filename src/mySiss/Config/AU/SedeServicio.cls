Class mySiss.Config.AU.SedeServicio Extends %Persistent [ SqlTableName = SedeServicio ]
{

Property IDSedeServ As %Integer [ Required, SqlFieldName = ID_SedeServ ];

Property IDSede As %Integer [ SqlFieldName = ID_Sede ];

Property IDServ As %Integer [ SqlFieldName = ID_Serv ];

Property IDAreaf As %Integer [ SqlFieldName = ID_Areaf ];

Property IDUser As %Integer [ SqlFieldName = ID_user ];

Property Activo As %String(MAXLEN = 1) [ SqlFieldName = Activo ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDSedeServ [ PrimaryKey, Unique ];

Storage Default
{
<Data name="SedeServicioDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDSedeServ</Value>
</Value>
<Value name="3">
<Value>IDSede</Value>
</Value>
<Value name="4">
<Value>IDServ</Value>
</Value>
<Value name="5">
<Value>IDAreaf</Value>
</Value>
<Value name="6">
<Value>IDUser</Value>
</Value>
<Value name="7">
<Value>Activo</Value>
</Value>
<Value name="8">
<Value>FechaCrea</Value>
</Value>
<Value name="9">
<Value>FechaModif</Value>
</Value>
<Value name="10">
<Value>UserCreado</Value>
</Value>
<Value name="11">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.AU.SedeServicioD</DataLocation>
<DefaultData>SedeServicioDefaultData</DefaultData>
<IdLocation>^mySiss.Config.AU.SedeServicioD</IdLocation>
<IndexLocation>^mySiss.Config.AU.SedeServicioI</IndexLocation>
<StreamLocation>^mySiss.Config.AU.SedeServicioS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
