Class mySiss.Config.GL.RelMotD Extends %Persistent [ SqlTableName = RelMotD ]
{

Property IDRelMotD As %Integer [ Required, SqlFieldName = ID_RelMotD ];

Property IDMotDev As %Integer [ SqlFieldName = ID_MotDev ];

Property IDSubMotDev As %Integer [ SqlFieldName = ID_SubMotDev ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDRelMotD [ PrimaryKey, Unique ];

Storage Default
{
<Data name="RelMotDDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDRelMotD</Value>
</Value>
<Value name="3">
<Value>IDMotDev</Value>
</Value>
<Value name="4">
<Value>IDSubMotDev</Value>
</Value>
<Value name="5">
<Value>FechaCrea</Value>
</Value>
<Value name="6">
<Value>FechaModif</Value>
</Value>
<Value name="7">
<Value>UserCreado</Value>
</Value>
<Value name="8">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.GL.RelMotDD</DataLocation>
<DefaultData>RelMotDDefaultData</DefaultData>
<IdLocation>^mySiss.Config.GL.RelMotDD</IdLocation>
<IndexLocation>^mySiss.Config.GL.RelMotDI</IndexLocation>
<StreamLocation>^mySiss.Config.GL.RelMotDS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
