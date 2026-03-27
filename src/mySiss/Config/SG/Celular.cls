Class mySiss.Config.SG.Celular Extends %Persistent [ SqlTableName = Celular ]
{

Property IDCelular As %Integer [ Required, SqlFieldName = ID_Celular ];

Property Celular As %String(MAXLEN = 20) [ Required, SqlFieldName = Celular ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDCelular [ PrimaryKey, Unique ];

Index IDXCelular On Celular [ Unique ];

Storage Default
{
<Data name="CelularDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDCelular</Value>
</Value>
<Value name="3">
<Value>Celular</Value>
</Value>
<Value name="4">
<Value>FechaCrea</Value>
</Value>
<Value name="5">
<Value>FechaModif</Value>
</Value>
<Value name="6">
<Value>UserCreado</Value>
</Value>
<Value name="7">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.SG.CelularD</DataLocation>
<DefaultData>CelularDefaultData</DefaultData>
<IdLocation>^mySiss.Config.SG.CelularD</IdLocation>
<IndexLocation>^mySiss.Config.SG.CelularI</IndexLocation>
<StreamLocation>^mySiss.Config.SG.CelularS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
