Class mySiss.Config.WS.Factura Extends %Persistent [ SqlTableName = Factura ]
{

Property IDFactura As %Integer [ Required, SqlFieldName = ID_Factura ];

Property NumFact As %String(MAXLEN = 80) [ SqlFieldName = num_fact ];

Property FechaFact As %Date [ SqlFieldName = fecha_fact ];

Property VrFact As %Numeric [ SqlFieldName = vr_fact ];

Property ModalidadPago As %String(MAXLEN = 250) [ SqlFieldName = modalidad_pago ];

Property CodServFact As %String(MAXLEN = 80) [ SqlFieldName = Cod_serv_fact ];

Property DescripServ As %String(MAXLEN = 500) [ SqlFieldName = Descrip_serv ];

Property CantServ As %Integer [ SqlFieldName = cant_serv ];

Property FechaServ As %Date [ SqlFieldName = fecha_serv ];

Property HoraPrestServ As %Time [ SqlFieldName = hora_prest_serv ];

Property VrServ As %Numeric [ SqlFieldName = vr_serv ];

Property IDCaso As %Integer [ SqlFieldName = ID_Caso ];

Property TipoCaso As %String(MAXLEN = 80) [ SqlFieldName = tipo_caso ];

Property Cobertura As %String(MAXLEN = 250) [ SqlFieldName = cobertura ];

Property IDAsegur As %Integer [ SqlFieldName = ID_asegur ];

Property IDPagador As %String(MAXLEN = 80) [ SqlFieldName = ID_pagador ];

Property NombreSede As %String(MAXLEN = 250) [ SqlFieldName = nombre_sede ];

Property AreaEjecutora As %String(MAXLEN = 250) [ SqlFieldName = area_ejecutora ];

Property EmpleadoRespons As %String(MAXLEN = 250) [ SqlFieldName = empleado_respons ];

Property FechaSinc As %TimeStamp [ SqlFieldName = Fecha_Sinc ];

Index PK On IDFactura [ PrimaryKey, Unique ];

Storage Default
{
<Data name="FacturaDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDFactura</Value>
</Value>
<Value name="3">
<Value>NumFact</Value>
</Value>
<Value name="4">
<Value>FechaFact</Value>
</Value>
<Value name="5">
<Value>VrFact</Value>
</Value>
<Value name="6">
<Value>ModalidadPago</Value>
</Value>
<Value name="7">
<Value>CodServFact</Value>
</Value>
<Value name="8">
<Value>DescripServ</Value>
</Value>
<Value name="9">
<Value>CantServ</Value>
</Value>
<Value name="10">
<Value>FechaServ</Value>
</Value>
<Value name="11">
<Value>HoraPrestServ</Value>
</Value>
<Value name="12">
<Value>VrServ</Value>
</Value>
<Value name="13">
<Value>IDCaso</Value>
</Value>
<Value name="14">
<Value>TipoCaso</Value>
</Value>
<Value name="15">
<Value>Cobertura</Value>
</Value>
<Value name="16">
<Value>IDAsegur</Value>
</Value>
<Value name="17">
<Value>IDPagador</Value>
</Value>
<Value name="18">
<Value>NombreSede</Value>
</Value>
<Value name="19">
<Value>AreaEjecutora</Value>
</Value>
<Value name="20">
<Value>EmpleadoRespons</Value>
</Value>
<Value name="21">
<Value>FechaSinc</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.WS.FacturaD</DataLocation>
<DefaultData>FacturaDefaultData</DefaultData>
<IdLocation>^mySiss.Config.WS.FacturaD</IdLocation>
<IndexLocation>^mySiss.Config.WS.FacturaI</IndexLocation>
<StreamLocation>^mySiss.Config.WS.FacturaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
