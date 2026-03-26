Class mySiss.Config.WS.Medto Extends %Persistent [ SqlTableName = Medto ]
{

Property IDMedto As %Integer [ Required, SqlFieldName = ID_Medto ];

Property NumPresc As %Integer [ SqlFieldName = num_presc ];

Property IDCaso As %Integer [ SqlFieldName = ID_Caso ];

Property TipoPresc As %String(MAXLEN = 80) [ SqlFieldName = tipo_presc ];

Property Medto As %String(MAXLEN = 250) [ SqlFieldName = medto ];

Property Dosis As %String(MAXLEN = 250) [ SqlFieldName = dosis ];

Property Unidad As %String(MAXLEN = 250) [ SqlFieldName = unidad ];

Property Ciclo As %String(MAXLEN = 250) [ SqlFieldName = ciclo ];

Property DosisTotal As %String(MAXLEN = 250) [ SqlFieldName = dosis_total ];

Property UndDosisTotal As %String(MAXLEN = 250) [ SqlFieldName = und_dosis_total ];

Property ViaDeAdmin As %String(MAXLEN = 250) [ SqlFieldName = via_de_admin ];

Property FechaPresc As %Date [ SqlFieldName = fecha_presc ];

Property Servicio As %String(MAXLEN = 250) [ SqlFieldName = servicio ];

Property NumDeAut As %String(MAXLEN = 80) [ SqlFieldName = num_de_aut ];

Property Empleado As %String(MAXLEN = 250) [ SqlFieldName = empleado ];

Property EstadoPresc As %String(MAXLEN = 80) [ SqlFieldName = estado_presc ];

Property FechaSinc As %TimeStamp [ SqlFieldName = Fecha_Sinc ];

Index PK On IDMedto [ PrimaryKey, Unique ];

Storage Default
{
<Data name="MedtoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDMedto</Value>
</Value>
<Value name="3">
<Value>NumPresc</Value>
</Value>
<Value name="4">
<Value>IDCaso</Value>
</Value>
<Value name="5">
<Value>TipoPresc</Value>
</Value>
<Value name="6">
<Value>Medto</Value>
</Value>
<Value name="7">
<Value>Dosis</Value>
</Value>
<Value name="8">
<Value>Unidad</Value>
</Value>
<Value name="9">
<Value>Ciclo</Value>
</Value>
<Value name="10">
<Value>DosisTotal</Value>
</Value>
<Value name="11">
<Value>UndDosisTotal</Value>
</Value>
<Value name="12">
<Value>ViaDeAdmin</Value>
</Value>
<Value name="13">
<Value>FechaPresc</Value>
</Value>
<Value name="14">
<Value>Servicio</Value>
</Value>
<Value name="15">
<Value>NumDeAut</Value>
</Value>
<Value name="16">
<Value>Empleado</Value>
</Value>
<Value name="17">
<Value>EstadoPresc</Value>
</Value>
<Value name="18">
<Value>FechaSinc</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.WS.MedtoD</DataLocation>
<DefaultData>MedtoDefaultData</DefaultData>
<IdLocation>^mySiss.Config.WS.MedtoD</IdLocation>
<IndexLocation>^mySiss.Config.WS.MedtoI</IndexLocation>
<StreamLocation>^mySiss.Config.WS.MedtoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
