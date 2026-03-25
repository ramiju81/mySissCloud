Class mySiss.Config.WS.Servicios Extends %Persistent [ SqlTableName = Servicios ]
{

Property IDServicio As %Integer [ Required, SqlFieldName = ID_Servicio ];

Property IDCaso As %Integer [ SqlFieldName = ID_Caso ];

Property TipoDePrest As %String(MAXLEN = 80) [ SqlFieldName = tipo_de_prest ];

Property OrdenClinica As %String(MAXLEN = 250) [ SqlFieldName = orden_clinica ];

Property NombrePrest As %String(MAXLEN = 250) [ SqlFieldName = nombre_prest ];

Property Cant As %Integer [ SqlFieldName = cant ];

Property VrPrest As %Numeric [ SqlFieldName = vr_prest ];

Property FechaSolicitud As %TimeStamp [ SqlFieldName = Fecha_solicitud ];

Property EmpleadoSolicitante As %String(MAXLEN = 250) [ SqlFieldName = empleado_solicitante ];

Property ServSolicitante As %String(MAXLEN = 250) [ SqlFieldName = serv_solicitante ];

Property FechaActual As %TimeStamp [ SqlFieldName = Fecha_actual ];

Property ServQueEjecuta As %String(MAXLEN = 250) [ SqlFieldName = serv_que_ejecuta ];

Property EmpleadoEjecor As %String(MAXLEN = 250) [ SqlFieldName = empleado_ejecor ];

Property EstadoPrest As %String(MAXLEN = 80) [ SqlFieldName = estado_prest ];

Property FechaSinc As %TimeStamp [ SqlFieldName = Fecha_Sinc ];

Index PK On IDServicio [ PrimaryKey, Unique ];

Storage Default
{
<Data name="ServiciosDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDServicio</Value>
</Value>
<Value name="3">
<Value>IDCaso</Value>
</Value>
<Value name="4">
<Value>TipoDePrest</Value>
</Value>
<Value name="5">
<Value>OrdenClinica</Value>
</Value>
<Value name="6">
<Value>NombrePrest</Value>
</Value>
<Value name="7">
<Value>Cant</Value>
</Value>
<Value name="8">
<Value>VrPrest</Value>
</Value>
<Value name="9">
<Value>FechaSolicitud</Value>
</Value>
<Value name="10">
<Value>EmpleadoSolicitante</Value>
</Value>
<Value name="11">
<Value>ServSolicitante</Value>
</Value>
<Value name="12">
<Value>FechaActual</Value>
</Value>
<Value name="13">
<Value>ServQueEjecuta</Value>
</Value>
<Value name="14">
<Value>EmpleadoEjecor</Value>
</Value>
<Value name="15">
<Value>EstadoPrest</Value>
</Value>
<Value name="16">
<Value>FechaSinc</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.WS.ServiciosD</DataLocation>
<DefaultData>ServiciosDefaultData</DefaultData>
<IdLocation>^mySiss.Config.WS.ServiciosD</IdLocation>
<IndexLocation>^mySiss.Config.WS.ServiciosI</IndexLocation>
<StreamLocation>^mySiss.Config.WS.ServiciosS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
