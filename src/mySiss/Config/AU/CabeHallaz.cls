Class mySiss.Config.AU.CabeHallaz Extends %Persistent [ SqlTableName = CabeHallaz ]
{

Property CodigAudit As %Integer [ Required, SqlFieldName = CodigAudit ];

Property CodigLista As %Integer [ SqlFieldName = CodigLista ];

Property NumeroCaso As %String(MAXLEN = 80) [ SqlFieldName = NumeroCaso ];

Property SedesAudit As %Integer [ SqlFieldName = SedesAudit ];

Property EstadoGral As %Integer [ SqlFieldName = EstadoGral ];

Property FechaIProg As %TimeStamp [ SqlFieldName = FechaIProg ];

Property FechaFProg As %TimeStamp [ SqlFieldName = FechaFProg ];

Property MotivCance As %Integer [ SqlFieldName = MotivCance ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On CodigAudit [ PrimaryKey, Unique ];

Storage Default
{
<Data name="CabeHallazDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CodigAudit</Value>
</Value>
<Value name="3">
<Value>CodigLista</Value>
</Value>
<Value name="4">
<Value>NumeroCaso</Value>
</Value>
<Value name="5">
<Value>SedesAudit</Value>
</Value>
<Value name="6">
<Value>EstadoGral</Value>
</Value>
<Value name="7">
<Value>FechaIProg</Value>
</Value>
<Value name="8">
<Value>FechaFProg</Value>
</Value>
<Value name="9">
<Value>MotivCance</Value>
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
<DataLocation>^mySiss.Config.AU.CabeHallazD</DataLocation>
<DefaultData>CabeHallazDefaultData</DefaultData>
<IdLocation>^mySiss.Config.AU.CabeHallazD</IdLocation>
<IndexLocation>^mySiss.Config.AU.CabeHallazI</IndexLocation>
<StreamLocation>^mySiss.Config.AU.CabeHallazS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
