Class mySiss.Config.AU.CCCabeHalla Extends %Persistent [ SqlTableName = CCCabeHalla ]
{

Property CodigAudit As %Integer [ Required, SqlFieldName = CodigAudit ];

Property NumeroCaso As %Integer [ SqlFieldName = NumeroCaso ];

Property EstadoGral As %Integer [ SqlFieldName = EstadoGral ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On CodigAudit [ PrimaryKey, Unique ];

Storage Default
{
<Data name="CCCabeHallaDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CodigAudit</Value>
</Value>
<Value name="3">
<Value>NumeroCaso</Value>
</Value>
<Value name="4">
<Value>EstadoGral</Value>
</Value>
<Value name="5">
<Value>FechaCrea</Value>
</Value>
<Value name="6">
<Value>FechaModif</Value>
</Value>
<Value name="7">
<Value>UserCreado</Value>
</Value>
<Value name="8">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.AU.CCCabeHallaD</DataLocation>
<DefaultData>CCCabeHallaDefaultData</DefaultData>
<IdLocation>^mySiss.Config.AU.CCCabeHallaD</IdLocation>
<IndexLocation>^mySiss.Config.AU.CCCabeHallaI</IndexLocation>
<StreamLocation>^mySiss.Config.AU.CCCabeHallaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
