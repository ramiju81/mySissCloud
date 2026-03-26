Class mySiss.Config.HO.Valida Extends %Persistent [ SqlTableName = Valida ]
{

Property IDValida As %Integer [ Required, SqlFieldName = ID_Valida ];

Property OrdenPreliquida As mySiss.Config.HO.Preliquida [ SqlFieldName = ID_OrdenPreliq ];

Property IDCausaRechazo As %Integer [ SqlFieldName = ID_CausaRechazo ];

Property IDDescripcion As %Integer [ SqlFieldName = ID_descripcion ];

Property IDDatoValida As %Integer [ SqlFieldName = ID_DatoValida ];

Property DatoRpta As mySiss.Config.HO.DatosResp [ SqlFieldName = ID_DatoRpta ];

Property IDEstadoValid As %Integer [ SqlFieldName = ID_estado_valid ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDValida [ PrimaryKey, Unique ];

Index IDXOrdenPreliquida On OrdenPreliquida;

Index IDXDatoRpta On DatoRpta;

Storage Default
{
<Data name="ValidaDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDValida</Value>
</Value>
<Value name="3">
<Value>OrdenPreliquida</Value>
</Value>
<Value name="4">
<Value>IDCausaRechazo</Value>
</Value>
<Value name="5">
<Value>IDDescripcion</Value>
</Value>
<Value name="6">
<Value>IDDatoValida</Value>
</Value>
<Value name="7">
<Value>DatoRpta</Value>
</Value>
<Value name="8">
<Value>IDEstadoValid</Value>
</Value>
<Value name="9">
<Value>FechaCrea</Value>
</Value>
<Value name="10">
<Value>FechaModif</Value>
</Value>
<Value name="11">
<Value>UserCreado</Value>
</Value>
<Value name="12">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.HO.ValidaD</DataLocation>
<DefaultData>ValidaDefaultData</DefaultData>
<IdLocation>^mySiss.Config.HO.ValidaD</IdLocation>
<IndexLocation>^mySiss.Config.HO.ValidaI</IndexLocation>
<StreamLocation>^mySiss.Config.HO.ValidaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
