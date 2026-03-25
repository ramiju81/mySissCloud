Class mySiss.Config.MS.ClienteMod Extends %Persistent [ SqlTableName = ClienteMod ]
{

Property IDClienteMod As %Integer [ Required, SqlFieldName = ID_ClienteMod ];

Property IdPrest As %Integer [ SqlFieldName = id_Prest ];

Property IdMod As %Integer [ SqlFieldName = id_Mod ];

Property IdEstadoActual As %Integer [ SqlFieldName = id_EstadoActual ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Index PK On IDClienteMod [ PrimaryKey, Unique ];

Storage Default
{
<Data name="ClienteModDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDClienteMod</Value>
</Value>
<Value name="3">
<Value>IdPrest</Value>
</Value>
<Value name="4">
<Value>IdMod</Value>
</Value>
<Value name="5">
<Value>IdEstadoActual</Value>
</Value>
<Value name="6">
<Value>FechaCrea</Value>
</Value>
<Value name="7">
<Value>UserCreado</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.MS.ClienteModD</DataLocation>
<DefaultData>ClienteModDefaultData</DefaultData>
<IdLocation>^mySiss.Config.MS.ClienteModD</IdLocation>
<IndexLocation>^mySiss.Config.MS.ClienteModI</IndexLocation>
<StreamLocation>^mySiss.Config.MS.ClienteModS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
