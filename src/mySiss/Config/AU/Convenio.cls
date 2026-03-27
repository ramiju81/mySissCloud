Class mySiss.Config.AU.Convenio Extends %Persistent [ SqlTableName = Convenio ]
{

Property IDConvenio As %Integer [ Required, SqlFieldName = ID_Convenio ];

Property Convenio As %String(MAXLEN = 250) [ SqlFieldName = Convenio ];

Property Fecha As %Date [ SqlFieldName = Fecha ];

Property FechaFin As %Date [ SqlFieldName = Fecha_Fin ];

Property IDCampo As %Integer [ SqlFieldName = ID_Campo ];

Property ResponsConv As %Integer [ SqlFieldName = ResponsConv ];

Property Contacto As %String(MAXLEN = 250) [ SqlFieldName = Contacto ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDConvenio [ PrimaryKey, Unique ];

Index IDXConvenio On Convenio [ Unique ];

Storage Default
{
<Data name="ConvenioDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDConvenio</Value>
</Value>
<Value name="3">
<Value>Convenio</Value>
</Value>
<Value name="4">
<Value>Fecha</Value>
</Value>
<Value name="5">
<Value>FechaFin</Value>
</Value>
<Value name="6">
<Value>IDCampo</Value>
</Value>
<Value name="7">
<Value>ResponsConv</Value>
</Value>
<Value name="8">
<Value>Contacto</Value>
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
<DataLocation>^mySiss.Config.AU.ConvenioD</DataLocation>
<DefaultData>ConvenioDefaultData</DefaultData>
<IdLocation>^mySiss.Config.AU.ConvenioD</IdLocation>
<IndexLocation>^mySiss.Config.AU.ConvenioI</IndexLocation>
<StreamLocation>^mySiss.Config.AU.ConvenioS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
