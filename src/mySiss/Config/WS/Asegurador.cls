Class mySiss.Config.WS.Asegurador Extends %Persistent [ SqlTableName = Asegurador ]
{

Property IDAsegur As %Integer [ Required, SqlFieldName = ID_Asegur ];

Property NIT As %String(MAXLEN = 80) [ SqlFieldName = NIT ];

Property Cobertura As %String(MAXLEN = 250) [ SqlFieldName = cobertura ];

Property FechaSinc As %TimeStamp [ SqlFieldName = Fecha_Sinc ];

Index PK On IDAsegur [ PrimaryKey, Unique ];

Storage Default
{
<Data name="AseguradorDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDAsegur</Value>
</Value>
<Value name="3">
<Value>NIT</Value>
</Value>
<Value name="4">
<Value>Cobertura</Value>
</Value>
<Value name="5">
<Value>FechaSinc</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.WS.AseguradorD</DataLocation>
<DefaultData>AseguradorDefaultData</DefaultData>
<IdLocation>^mySiss.Config.WS.AseguradorD</IdLocation>
<IndexLocation>^mySiss.Config.WS.AseguradorI</IndexLocation>
<StreamLocation>^mySiss.Config.WS.AseguradorS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
