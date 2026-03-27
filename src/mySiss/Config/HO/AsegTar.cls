Class mySiss.Config.HO.AsegTar Extends %Persistent [ SqlTableName = AsegTar ]
{

Property IDAsegTar As %Integer [ Required, SqlFieldName = ID_AsegTar ];

Property Tarifa As mySiss.Config.HO.Tarifa [ SqlFieldName = ID_Tarifa ];

Property IDAsegur As %Integer [ SqlFieldName = ID_Asegur ];

Property VrTarifa As %Numeric(MAXVAL = 9999999999999999.99, MINVAL = -9999999999999999.99, SCALE = 2) [ SqlFieldName = VrTarifa ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDAsegTar [ PrimaryKey, Unique ];

Index IDXTarifa On Tarifa;

Index IDXAsegur On IDAsegur;

Storage Default
{
<Data name="AsegTarDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDAsegTar</Value>
</Value>
<Value name="3">
<Value>Tarifa</Value>
</Value>
<Value name="4">
<Value>IDAsegur</Value>
</Value>
<Value name="5">
<Value>VrTarifa</Value>
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
<DataLocation>^mySiss.Config.HO.AsegTarD</DataLocation>
<DefaultData>AsegTarDefaultData</DefaultData>
<IdLocation>^mySiss.Config.HO.AsegTarD</IdLocation>
<IndexLocation>^mySiss.Config.HO.AsegTarI</IndexLocation>
<StreamLocation>^mySiss.Config.HO.AsegTarS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
