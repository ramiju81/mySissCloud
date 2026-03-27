Class mySiss.Config.GL.Devolucion Extends %Persistent [ SqlTableName = Devolucion ]
{

Property IDDevolucion As %Integer [ Required, SqlFieldName = ID_Devolucion ];

Property NumFactura As %Integer [ SqlFieldName = Num_Factura ];

Property IDRad As %Integer [ SqlFieldName = ID_Rad ];

Property IDMotDevol As %Integer [ SqlFieldName = ID_Mot_Devol ];

Property IDSubMotDevol As %Integer [ SqlFieldName = ID_SubMot_Devol ];

Property FechaDevol As %TimeStamp [ SqlFieldName = Fecha_Devol ];

Property IDUserDevol As %Integer [ SqlFieldName = ID_User_Devol ];

Property NotaDevolucion As %String(MAXLEN = 500) [ SqlFieldName = Nota_Devolucion ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDDevolucion [ PrimaryKey, Unique ];

Storage Default
{
<Data name="DevolucionDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDDevolucion</Value>
</Value>
<Value name="3">
<Value>NumFactura</Value>
</Value>
<Value name="4">
<Value>IDRad</Value>
</Value>
<Value name="5">
<Value>IDMotDevol</Value>
</Value>
<Value name="6">
<Value>IDSubMotDevol</Value>
</Value>
<Value name="7">
<Value>FechaDevol</Value>
</Value>
<Value name="8">
<Value>IDUserDevol</Value>
</Value>
<Value name="9">
<Value>NotaDevolucion</Value>
</Value>
<Value name="10">
<Value>FechaCrea</Value>
</Value>
<Value name="11">
<Value>FechaModif</Value>
</Value>
<Value name="12">
<Value>UserCreado</Value>
</Value>
<Value name="13">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.GL.DevolucionD</DataLocation>
<DefaultData>DevolucionDefaultData</DefaultData>
<IdLocation>^mySiss.Config.GL.DevolucionD</IdLocation>
<IndexLocation>^mySiss.Config.GL.DevolucionI</IndexLocation>
<StreamLocation>^mySiss.Config.GL.DevolucionS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
