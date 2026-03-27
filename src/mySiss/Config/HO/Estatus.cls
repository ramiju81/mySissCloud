Class mySiss.Config.HO.Estatus Extends %Persistent [ SqlTableName = estatus ]
{

Property IDEstatus As %Integer [ Required, SqlFieldName = ID_estatus ];

Property NombreEstatus As %String(MAXLEN = 120) [ SqlFieldName = nombre_estatus ];

Index PK On IDEstatus [ PrimaryKey, Unique ];

Storage Default
{
<Data name="EstatusDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDEstatus</Value>
</Value>
<Value name="3">
<Value>NombreEstatus</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.HO.EstatusD</DataLocation>
<DefaultData>EstatusDefaultData</DefaultData>
<IdLocation>^mySiss.Config.HO.EstatusD</IdLocation>
<IndexLocation>^mySiss.Config.HO.EstatusI</IndexLocation>
<StreamLocation>^mySiss.Config.HO.EstatusS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
