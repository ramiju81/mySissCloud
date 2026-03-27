Class mySiss.Config.WS.Casos Extends %Persistent [ SqlTableName = Casos ]
{

Property IDCaso As %Integer [ Required, SqlFieldName = ID_Caso ];

Property IDPaciente As %Integer [ SqlFieldName = ID_Paciente ];

Property NumCaso As %String(MAXLEN = 80) [ SqlFieldName = num_caso ];

Property FechaInicio As %Date [ SqlFieldName = fecha_inicio ];

Property HoraInicio As %Time [ SqlFieldName = hora_inicio ];

Property FechaFin As %Date [ SqlFieldName = fecha_fin ];

Property HoraFin As %Time [ SqlFieldName = hora_fin ];

Property Estado As %String(MAXLEN = 80) [ SqlFieldName = estado ];

Property Sede As %String(MAXLEN = 250) [ SqlFieldName = sede ];

Property ServActual As %String(MAXLEN = 250) [ SqlFieldName = serv_actual ];

Property Area As %String(MAXLEN = 250) [ SqlFieldName = area ];

Property Cobertura As %String(MAXLEN = 250) [ SqlFieldName = cobertura ];

Property Jerarquia As %String(MAXLEN = 250) [ SqlFieldName = jerarquia ];

Property Particular As %String(MAXLEN = 250) [ SqlFieldName = particular ];

Property Inactivar As %String(MAXLEN = 250) [ SqlFieldName = inactivar ];

Property FechaSinc As %TimeStamp [ SqlFieldName = Fecha_Sinc ];

Index PK On IDCaso [ PrimaryKey, Unique ];

Index IDXNumCaso On NumCaso [ Unique ];

Storage Default
{
<Data name="CasosDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDCaso</Value>
</Value>
<Value name="3">
<Value>IDPaciente</Value>
</Value>
<Value name="4">
<Value>NumCaso</Value>
</Value>
<Value name="5">
<Value>FechaInicio</Value>
</Value>
<Value name="6">
<Value>HoraInicio</Value>
</Value>
<Value name="7">
<Value>FechaFin</Value>
</Value>
<Value name="8">
<Value>HoraFin</Value>
</Value>
<Value name="9">
<Value>Estado</Value>
</Value>
<Value name="10">
<Value>Sede</Value>
</Value>
<Value name="11">
<Value>ServActual</Value>
</Value>
<Value name="12">
<Value>Area</Value>
</Value>
<Value name="13">
<Value>Cobertura</Value>
</Value>
<Value name="14">
<Value>Jerarquia</Value>
</Value>
<Value name="15">
<Value>Particular</Value>
</Value>
<Value name="16">
<Value>Inactivar</Value>
</Value>
<Value name="17">
<Value>FechaSinc</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.WS.CasosD</DataLocation>
<DefaultData>CasosDefaultData</DefaultData>
<IdLocation>^mySiss.Config.WS.CasosD</IdLocation>
<IndexLocation>^mySiss.Config.WS.CasosI</IndexLocation>
<StreamLocation>^mySiss.Config.WS.CasosS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
