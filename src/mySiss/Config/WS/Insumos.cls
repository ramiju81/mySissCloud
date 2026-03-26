Class mySiss.Config.WS.Insumos Extends %Persistent [ SqlTableName = Insumos ]
{

Property IDInsumos As %Integer [ Required, SqlFieldName = ID_Insumos ];

Property IDCaso As %Integer [ SqlFieldName = ID_Caso ];

Property Solicitud As %String(MAXLEN = 250) [ SqlFieldName = solicitud ];

Property CodMat As %String(MAXLEN = 80) [ SqlFieldName = cod_mat ];

Property Mat As %String(MAXLEN = 250) [ SqlFieldName = mat ];

Property Cant As %Integer [ SqlFieldName = cant ];

Property UndMedida As %String(MAXLEN = 250) [ SqlFieldName = Und_medida ];

Property Lote As %String(MAXLEN = 250) [ SqlFieldName = lote ];

Property Fecha As %TimeStamp [ SqlFieldName = Fecha ];

Property Serv As %String(MAXLEN = 250) [ SqlFieldName = serv ];

Property NumAut As %String(MAXLEN = 80) [ SqlFieldName = num_aut ];

Property Empleado As %String(MAXLEN = 250) [ SqlFieldName = empleado ];

Property Estado As %String(MAXLEN = 80) [ SqlFieldName = estado ];

Property FechaSinc As %TimeStamp [ SqlFieldName = Fecha_Sinc ];

Index PK On IDInsumos [ PrimaryKey, Unique ];

Storage Default
{
<Data name="InsumosDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDInsumos</Value>
</Value>
<Value name="3">
<Value>IDCaso</Value>
</Value>
<Value name="4">
<Value>Solicitud</Value>
</Value>
<Value name="5">
<Value>CodMat</Value>
</Value>
<Value name="6">
<Value>Mat</Value>
</Value>
<Value name="7">
<Value>Cant</Value>
</Value>
<Value name="8">
<Value>UndMedida</Value>
</Value>
<Value name="9">
<Value>Lote</Value>
</Value>
<Value name="10">
<Value>Fecha</Value>
</Value>
<Value name="11">
<Value>Serv</Value>
</Value>
<Value name="12">
<Value>NumAut</Value>
</Value>
<Value name="13">
<Value>Empleado</Value>
</Value>
<Value name="14">
<Value>Estado</Value>
</Value>
<Value name="15">
<Value>FechaSinc</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.WS.InsumosD</DataLocation>
<DefaultData>InsumosDefaultData</DefaultData>
<IdLocation>^mySiss.Config.WS.InsumosD</IdLocation>
<IndexLocation>^mySiss.Config.WS.InsumosI</IndexLocation>
<StreamLocation>^mySiss.Config.WS.InsumosS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
