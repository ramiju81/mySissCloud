Class mySiss.Config.AU.ConvServ Extends %Persistent [ SqlTableName = ConvServ ]
{

Property IDConvServ As %Integer [ Required, SqlFieldName = ID_ConvServ ];

Property IDServicio As %Integer [ SqlFieldName = ID_Servicio ];

Property IDConvenio As %Integer [ SqlFieldName = ID_Convenio ];

Property Tarifa As %String(MAXLEN = 250) [ SqlFieldName = Tarifa ];

Property Observacion As %String(MAXLEN = 500) [ SqlFieldName = Observacion ];

Property Autorizacion As %String(MAXLEN = 1) [ SqlFieldName = Autorizacion ];

Property CodCatalogo As %Integer [ SqlFieldName = Cod_Catalogo ];

Property CodDx As %Integer [ SqlFieldName = Cod_Dx ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDConvServ [ PrimaryKey, Unique ];

Storage Default
{
<Data name="ConvServDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDConvServ</Value>
</Value>
<Value name="3">
<Value>IDServicio</Value>
</Value>
<Value name="4">
<Value>IDConvenio</Value>
</Value>
<Value name="5">
<Value>Tarifa</Value>
</Value>
<Value name="6">
<Value>Observacion</Value>
</Value>
<Value name="7">
<Value>Autorizacion</Value>
</Value>
<Value name="8">
<Value>CodCatalogo</Value>
</Value>
<Value name="9">
<Value>CodDx</Value>
</Value>
<Value name="10">
<Value>FechaCrea</Value>
</Value>
<Value name="11">
<Value>FechaModif</Value>
</Value>
<Value name="12">
<Value>UserCreado</Value>
</Value>
<Value name="13">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.AU.ConvServD</DataLocation>
<DefaultData>ConvServDefaultData</DefaultData>
<IdLocation>^mySiss.Config.AU.ConvServD</IdLocation>
<IndexLocation>^mySiss.Config.AU.ConvServI</IndexLocation>
<StreamLocation>^mySiss.Config.AU.ConvServS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
