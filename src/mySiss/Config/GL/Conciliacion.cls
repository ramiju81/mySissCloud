Class mySiss.Config.GL.Conciliacion Extends %Persistent [ SqlTableName = Conciliacion ]
{

Property IDConciliacion As %Integer [ Required, SqlFieldName = ID_Conciliacion ];

Property NumFactura As %Integer [ SqlFieldName = Num_factura ];

Property NoPosicion As %Numeric [ SqlFieldName = No_Posicion ];

Property IDRad As %Integer [ SqlFieldName = ID_Rad ];

Property FechaConcil As %TimeStamp [ SqlFieldName = Fecha_concil ];

Property PorcentajeConcil As %String(MAXLEN = 250) [ SqlFieldName = Porcentaje_Concil ];

Property VrConciliado As %Numeric [ SqlFieldName = Vr_Conciliado ];

Property VrPorcConcil As %String(MAXLEN = 250) [ SqlFieldName = Vr_Porc_Concil ];

Property UsrResponConcil As %String(MAXLEN = 250) [ SqlFieldName = Usr_Respon_Concil ];

Property Nota As %String(MAXLEN = 500) [ SqlFieldName = Nota ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDConciliacion [ PrimaryKey, Unique ];

Storage Default
{
<Data name="ConciliacionDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDConciliacion</Value>
</Value>
<Value name="3">
<Value>NumFactura</Value>
</Value>
<Value name="4">
<Value>NoPosicion</Value>
</Value>
<Value name="5">
<Value>IDRad</Value>
</Value>
<Value name="6">
<Value>FechaConcil</Value>
</Value>
<Value name="7">
<Value>PorcentajeConcil</Value>
</Value>
<Value name="8">
<Value>VrConciliado</Value>
</Value>
<Value name="9">
<Value>VrPorcConcil</Value>
</Value>
<Value name="10">
<Value>UsrResponConcil</Value>
</Value>
<Value name="11">
<Value>Nota</Value>
</Value>
<Value name="12">
<Value>FechaCrea</Value>
</Value>
<Value name="13">
<Value>FechaModif</Value>
</Value>
<Value name="14">
<Value>UserCreado</Value>
</Value>
<Value name="15">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.GL.ConciliacionD</DataLocation>
<DefaultData>ConciliacionDefaultData</DefaultData>
<IdLocation>^mySiss.Config.GL.ConciliacionD</IdLocation>
<IndexLocation>^mySiss.Config.GL.ConciliacionI</IndexLocation>
<StreamLocation>^mySiss.Config.GL.ConciliacionS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
