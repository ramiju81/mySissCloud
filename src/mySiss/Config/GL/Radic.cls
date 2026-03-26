Class mySiss.Config.GL.Radic Extends %Persistent [ SqlTableName = Radic ]
{

Property IDRadic As %Integer [ Required, SqlFieldName = ID_Radic ];

Property IDTipoRad As %Integer [ Required, SqlFieldName = ID_Tipo_Rad ];

Property FechaRad As %TimeStamp [ SqlFieldName = Fecha_Rad ];

Property UsuarioRad As %Integer [ SqlFieldName = Usuario_Rad ];

Property EstadoFact As %Integer [ SqlFieldName = Estado_Fact ];

Index PK On IDRadic [ PrimaryKey, Unique ];

Storage Default
{
<Data name="RadicDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDRadic</Value>
</Value>
<Value name="3">
<Value>IDTipoRad</Value>
</Value>
<Value name="4">
<Value>FechaRad</Value>
</Value>
<Value name="5">
<Value>UsuarioRad</Value>
</Value>
<Value name="6">
<Value>EstadoFact</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.GL.RadicD</DataLocation>
<DefaultData>RadicDefaultData</DefaultData>
<IdLocation>^mySiss.Config.GL.RadicD</IdLocation>
<IndexLocation>^mySiss.Config.GL.RadicI</IndexLocation>
<StreamLocation>^mySiss.Config.GL.RadicS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
