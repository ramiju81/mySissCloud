Class mySiss.Config.HO.Liquida Extends %Persistent [ SqlTableName = Liquida ]
{

Property IDLiquida As %Integer [ Required, SqlFieldName = ID_Liquida ];

Property Medico As mySiss.Config.HO.Medico [ SqlFieldName = ID_Medico ];

Property IDOrden As %Integer [ SqlFieldName = ID_orden ];

Property FechaLiquida As %Date [ SqlFieldName = fecha_liquida ];

Property Cantidad As %Integer [ SqlFieldName = cantidad ];

Property VrUnitario As %Numeric(MAXVAL = 9999999999999999.99, MINVAL = -9999999999999999.99, SCALE = 2) [ SqlFieldName = vr_Unitario ];

Property VrTotal As %Numeric(MAXVAL = 9999999999999999.99, MINVAL = -9999999999999999.99, SCALE = 2) [ SqlFieldName = vr_Total ];

Property IDEstado As %Integer [ SqlFieldName = ID_Estado ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDLiquida [ PrimaryKey, Unique ];

Index IDXMedico On Medico;

Storage Default
{
<Data name="LiquidaDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDLiquida</Value>
</Value>
<Value name="3">
<Value>Medico</Value>
</Value>
<Value name="4">
<Value>IDOrden</Value>
</Value>
<Value name="5">
<Value>FechaLiquida</Value>
</Value>
<Value name="6">
<Value>Cantidad</Value>
</Value>
<Value name="7">
<Value>VrUnitario</Value>
</Value>
<Value name="8">
<Value>VrTotal</Value>
</Value>
<Value name="9">
<Value>IDEstado</Value>
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
<DataLocation>^mySiss.Config.HO.LiquidaD</DataLocation>
<DefaultData>LiquidaDefaultData</DefaultData>
<IdLocation>^mySiss.Config.HO.LiquidaD</IdLocation>
<IndexLocation>^mySiss.Config.HO.LiquidaI</IndexLocation>
<StreamLocation>^mySiss.Config.HO.LiquidaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
