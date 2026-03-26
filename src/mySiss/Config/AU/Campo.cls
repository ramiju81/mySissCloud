Class mySiss.Config.AU.Campo Extends %Persistent [ SqlTableName = Campo ]
{

Property IDCamp As %Integer [ Required, SqlFieldName = ID_Camp ];

Property IDOpcion As %Integer [ SqlFieldName = ID_Opcion ];

Property Campo As %String(MAXLEN = 250) [ SqlFieldName = Campo ];

Property Activo As %String(MAXLEN = 1) [ SqlFieldName = Activo ];

Property Obligatoriedad As %String(MAXLEN = 1) [ SqlFieldName = Obligatoriedad ];

Property IDModulo As %Integer [ SqlFieldName = ID_Modulo ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDCamp [ PrimaryKey, Unique ];

Index IDXCampo On Campo [ Unique ];

Storage Default
{
<Data name="CampoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDCamp</Value>
</Value>
<Value name="3">
<Value>IDOpcion</Value>
</Value>
<Value name="4">
<Value>Campo</Value>
</Value>
<Value name="5">
<Value>Activo</Value>
</Value>
<Value name="6">
<Value>Obligatoriedad</Value>
</Value>
<Value name="7">
<Value>IDModulo</Value>
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
<DataLocation>^mySiss.Config.AU.CampoD</DataLocation>
<DefaultData>CampoDefaultData</DefaultData>
<IdLocation>^mySiss.Config.AU.CampoD</IdLocation>
<IndexLocation>^mySiss.Config.AU.CampoI</IndexLocation>
<StreamLocation>^mySiss.Config.AU.CampoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
