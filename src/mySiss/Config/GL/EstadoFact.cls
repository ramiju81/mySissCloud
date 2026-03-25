Class mySiss.Config.GL.EstadoFact Extends %Persistent [ SqlTableName = Estado_fact ]
{

Property IDEstadoFact As %Integer [ Required, SqlFieldName = ID_Estado_fact ];

Property IDProceso As %Integer [ Required, SqlFieldName = ID_Proceso ];

Property IDEstado As %Integer [ Required, SqlFieldName = ID_Estado ];

Property IDFactura As %Integer [ Required, SqlFieldName = ID_Factura ];

Property Fecha As %TimeStamp [ SqlFieldName = Fecha ];

Property IDUsuario As %Integer [ SqlFieldName = ID_Usuario ];

Index PK On IDEstadoFact [ PrimaryKey, Unique ];

Index IDXIDProceso On IDProceso [ Unique ];

Storage Default
{
<Data name="EstadoFactDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDEstadoFact</Value>
</Value>
<Value name="3">
<Value>IDProceso</Value>
</Value>
<Value name="4">
<Value>IDEstado</Value>
</Value>
<Value name="5">
<Value>IDFactura</Value>
</Value>
<Value name="6">
<Value>Fecha</Value>
</Value>
<Value name="7">
<Value>IDUsuario</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.GL.EstadoFactD</DataLocation>
<DefaultData>EstadoFactDefaultData</DefaultData>
<IdLocation>^mySiss.Config.GL.EstadoFactD</IdLocation>
<IndexLocation>^mySiss.Config.GL.EstadoFactI</IndexLocation>
<StreamLocation>^mySiss.Config.GL.EstadoFactS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
