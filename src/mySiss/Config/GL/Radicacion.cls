Class mySiss.Config.GL.Radicacion Extends %Persistent [ SqlTableName = Radicacion ]
{

Property IDRadicacion As %Integer [ Required, SqlFieldName = ID_Radicacion ];

Property NumFactura As %Integer [ SqlFieldName = Num_factura ];

Property IDRad As %Integer [ SqlFieldName = ID_Rad ];

Index PK On IDRadicacion [ PrimaryKey, Unique ];

Storage Default
{
<Data name="RadicacionDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDRadicacion</Value>
</Value>
<Value name="3">
<Value>NumFactura</Value>
</Value>
<Value name="4">
<Value>IDRad</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.GL.RadicacionD</DataLocation>
<DefaultData>RadicacionDefaultData</DefaultData>
<IdLocation>^mySiss.Config.GL.RadicacionD</IdLocation>
<IndexLocation>^mySiss.Config.GL.RadicacionI</IndexLocation>
<StreamLocation>^mySiss.Config.GL.RadicacionS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
