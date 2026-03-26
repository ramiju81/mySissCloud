Class mySiss.Config.MS.ClienteModEstado Extends %Persistent [ SqlTableName = ClienteModEstado ]
{

Property IDEstado As %Integer [ Required, SqlFieldName = ID_Estado ];

Property IDClienteMod As %Integer [ SqlFieldName = ID_ClienteMod ];

Property Estado As %String(MAXLEN = 80) [ SqlFieldName = Estado ];

Property FechaInicio As %TimeStamp [ SqlFieldName = Fecha_inicio ];

Property FechaFin As %TimeStamp [ SqlFieldName = Fecha_fin ];

Property Motivo As %String(MAXLEN = 250) [ SqlFieldName = Motivo ];

Property Observacion As %String(MAXLEN = 500) [ SqlFieldName = Observacion ];

Property UserEvento As %Integer [ SqlFieldName = UserEvento ];

Property FechaEvento As %TimeStamp [ SqlFieldName = Fecha_evento ];

Index PK On IDEstado [ PrimaryKey, Unique ];

Storage Default
{
<Data name="ClienteModEstadoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDEstado</Value>
</Value>
<Value name="3">
<Value>IDClienteMod</Value>
</Value>
<Value name="4">
<Value>Estado</Value>
</Value>
<Value name="5">
<Value>FechaInicio</Value>
</Value>
<Value name="6">
<Value>FechaFin</Value>
</Value>
<Value name="7">
<Value>Motivo</Value>
</Value>
<Value name="8">
<Value>Observacion</Value>
</Value>
<Value name="9">
<Value>UserEvento</Value>
</Value>
<Value name="10">
<Value>FechaEvento</Value>
</Value>
</Data>
<DataLocation>^mySiss.Con86A9.ClienteModE891DD</DataLocation>
<DefaultData>ClienteModEstadoDefaultData</DefaultData>
<IdLocation>^mySiss.Con86A9.ClienteModE891DD</IdLocation>
<IndexLocation>^mySiss.Con86A9.ClienteModE891DI</IndexLocation>
<StreamLocation>^mySiss.Con86A9.ClienteModE891DS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
