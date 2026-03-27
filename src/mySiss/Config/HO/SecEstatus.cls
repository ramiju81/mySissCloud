Class mySiss.Config.HO.SecEstatus Extends %Persistent [ SqlTableName = Sec_estatus ]
{

Property IDSecEstatus As %Integer [ Required, SqlFieldName = ID_Sec_estatus ];

Property EstatusActual As mySiss.Config.HO.Estatus [ SqlFieldName = ID_Estatus ];

Property EstatusSiguiente As mySiss.Config.HO.Estatus [ SqlFieldName = ID_Sig_Estatus ];

Index PK On IDSecEstatus [ PrimaryKey, Unique ];

Index IDXEstatusActual On EstatusActual;

Index IDXEstatusSiguiente On EstatusSiguiente;

Storage Default
{
<Data name="SecEstatusDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDSecEstatus</Value>
</Value>
<Value name="3">
<Value>EstatusActual</Value>
</Value>
<Value name="4">
<Value>EstatusSiguiente</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.HO.SecEstatusD</DataLocation>
<DefaultData>SecEstatusDefaultData</DefaultData>
<IdLocation>^mySiss.Config.HO.SecEstatusD</IdLocation>
<IndexLocation>^mySiss.Config.HO.SecEstatusI</IndexLocation>
<StreamLocation>^mySiss.Config.HO.SecEstatusS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
