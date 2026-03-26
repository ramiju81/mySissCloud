Class mySiss.Config.HO.Tarifa Extends %Persistent [ SqlTableName = Tarifa ]
{

Property IDTarifa As %Integer [ Required, SqlFieldName = ID_Tarifa ];

Property IDServ As %Integer [ SqlFieldName = ID_Serv ];

Property FechaVigI As %Date [ SqlFieldName = FechaVig_I ];

Property FechaVigF As %Date [ SqlFieldName = FechaVig_F ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDTarifa [ PrimaryKey, Unique ];

Storage Default
{
<Data name="TarifaDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDTarifa</Value>
</Value>
<Value name="3">
<Value>IDServ</Value>
</Value>
<Value name="4">
<Value>FechaVigI</Value>
</Value>
<Value name="5">
<Value>FechaVigF</Value>
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
<DataLocation>^mySiss.Config.HO.TarifaD</DataLocation>
<DefaultData>TarifaDefaultData</DefaultData>
<IdLocation>^mySiss.Config.HO.TarifaD</IdLocation>
<IndexLocation>^mySiss.Config.HO.TarifaI</IndexLocation>
<StreamLocation>^mySiss.Config.HO.TarifaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
