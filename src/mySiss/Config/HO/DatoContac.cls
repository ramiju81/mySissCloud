Class mySiss.Config.HO.DatoContac Extends %Persistent [ SqlTableName = DatoContac ]
{

Property IDContacto As %Integer [ Required, SqlFieldName = ID_Contacto ];

Property Medico As mySiss.Config.HO.Medico [ SqlFieldName = ID_medico ];

Property IDUsCel As %Integer [ SqlFieldName = ID_UsCel ];

Property IDEmail As %Integer [ SqlFieldName = ID_Email ];

Property Direccion As %String(MAXLEN = 250) [ SqlFieldName = Direccion ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDContacto [ PrimaryKey, Unique ];

Index IDXMedico On Medico;

Storage Default
{
<Data name="DatoContacDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDContacto</Value>
</Value>
<Value name="3">
<Value>Medico</Value>
</Value>
<Value name="4">
<Value>IDUsCel</Value>
</Value>
<Value name="5">
<Value>IDEmail</Value>
</Value>
<Value name="6">
<Value>Direccion</Value>
</Value>
<Value name="7">
<Value>FechaCrea</Value>
</Value>
<Value name="8">
<Value>FechaModif</Value>
</Value>
<Value name="9">
<Value>UserCreado</Value>
</Value>
<Value name="10">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.HO.DatoContacD</DataLocation>
<DefaultData>DatoContacDefaultData</DefaultData>
<IdLocation>^mySiss.Config.HO.DatoContacD</IdLocation>
<IndexLocation>^mySiss.Config.HO.DatoContacI</IndexLocation>
<StreamLocation>^mySiss.Config.HO.DatoContacS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
