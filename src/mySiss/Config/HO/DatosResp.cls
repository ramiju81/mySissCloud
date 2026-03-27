Class mySiss.Config.HO.DatosResp Extends %Persistent [ SqlTableName = DatosResp ]
{

Property IDDatoRpta As %Integer [ Required, SqlFieldName = ID_DatoRpta ];

Property FechaRpta As %Date [ SqlFieldName = Fecha_rpta ];

Property DetalleRpta As %String(MAXLEN = 500) [ SqlFieldName = Detalle_rpta ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDDatoRpta [ PrimaryKey, Unique ];

Storage Default
{
<Data name="DatosRespDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDDatoRpta</Value>
</Value>
<Value name="3">
<Value>FechaRpta</Value>
</Value>
<Value name="4">
<Value>DetalleRpta</Value>
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
<DataLocation>^mySiss.Config.HO.DatosRespD</DataLocation>
<DefaultData>DatosRespDefaultData</DefaultData>
<IdLocation>^mySiss.Config.HO.DatosRespD</IdLocation>
<IndexLocation>^mySiss.Config.HO.DatosRespI</IndexLocation>
<StreamLocation>^mySiss.Config.HO.DatosRespS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
