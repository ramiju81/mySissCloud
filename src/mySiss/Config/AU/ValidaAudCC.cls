Class mySiss.Config.AU.ValidaAudCC Extends %Persistent [ SqlTableName = ValidaAudCC ]
{

Property IDValidaAudCC As %Integer [ Required, SqlFieldName = ID_ValidaAudCC ];

Property Componente As %Integer [ SqlFieldName = Componente ];

Property EstatusVal As %Integer [ SqlFieldName = EstatusVal ];

Property CondicionV As %Integer [ SqlFieldName = CondicionV ];

Property ValorCondi As %Integer [ SqlFieldName = ValorCondi ];

Property UnidTiempo As %Integer [ SqlFieldName = UnidTiempo ];

Property MsgeValida As %String(MAXLEN = 500) [ SqlFieldName = MsgeValida ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDValidaAudCC [ PrimaryKey, Unique ];

Storage Default
{
<Data name="ValidaAudCCDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDValidaAudCC</Value>
</Value>
<Value name="3">
<Value>Componente</Value>
</Value>
<Value name="4">
<Value>EstatusVal</Value>
</Value>
<Value name="5">
<Value>CondicionV</Value>
</Value>
<Value name="6">
<Value>ValorCondi</Value>
</Value>
<Value name="7">
<Value>UnidTiempo</Value>
</Value>
<Value name="8">
<Value>MsgeValida</Value>
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
<DataLocation>^mySiss.Config.AU.ValidaAudCCD</DataLocation>
<DefaultData>ValidaAudCCDefaultData</DefaultData>
<IdLocation>^mySiss.Config.AU.ValidaAudCCD</IdLocation>
<IndexLocation>^mySiss.Config.AU.ValidaAudCCI</IndexLocation>
<StreamLocation>^mySiss.Config.AU.ValidaAudCCS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
