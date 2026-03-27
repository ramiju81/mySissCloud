Class mySiss.Config.HO.Descuento Extends %Persistent [ SqlTableName = Descuento ]
{

Property IDDscto As %Integer [ Required, SqlFieldName = ID_Dscto ];

Property Descripcion As %String(MAXLEN = 180) [ SqlFieldName = descripcion ];

Property Activo As %String(MAXLEN = 1) [ SqlFieldName = activo ];

Property Valor As %Numeric(MAXVAL = 9999999999999999.99, MINVAL = -9999999999999999.99, SCALE = 2) [ SqlFieldName = valor ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDDscto [ PrimaryKey, Unique ];

Storage Default
{
<Data name="DescuentoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDDscto</Value>
</Value>
<Value name="3">
<Value>Descripcion</Value>
</Value>
<Value name="4">
<Value>Activo</Value>
</Value>
<Value name="5">
<Value>Valor</Value>
</Value>
<Value name="6">
<Value>FechaCrea</Value>
</Value>
<Value name="7">
<Value>FechaModif</Value>
</Value>
<Value name="8">
<Value>UserCreado</Value>
</Value>
<Value name="9">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.HO.DescuentoD</DataLocation>
<DefaultData>DescuentoDefaultData</DefaultData>
<IdLocation>^mySiss.Config.HO.DescuentoD</IdLocation>
<IndexLocation>^mySiss.Config.HO.DescuentoI</IndexLocation>
<StreamLocation>^mySiss.Config.HO.DescuentoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
