Class mySiss.Config.SG.Modulo Extends %Persistent [ SqlTableName = Modulo ]
{

Property IDModulo As %Integer [ Required, SqlFieldName = ID_Modulo ];

Property CodModulo As %String(MAXLEN = 50) [ Required, SqlFieldName = Cod_Modulo ];

Property Modulo As %String(MAXLEN = 150) [ Required, SqlFieldName = Modulo ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDModulo [ PrimaryKey, Unique ];

Index IDXCodModulo On CodModulo [ Unique ];

Index IDXModulo On Modulo;

Storage Default
{
<Data name="ModuloDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDModulo</Value>
</Value>
<Value name="3">
<Value>CodModulo</Value>
</Value>
<Value name="4">
<Value>Modulo</Value>
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
<DataLocation>^mySiss.Config.SG.ModuloD</DataLocation>
<DefaultData>ModuloDefaultData</DefaultData>
<IdLocation>^mySiss.Config.SG.ModuloD</IdLocation>
<IndexLocation>^mySiss.Config.SG.ModuloI</IndexLocation>
<StreamLocation>^mySiss.Config.SG.ModuloS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
