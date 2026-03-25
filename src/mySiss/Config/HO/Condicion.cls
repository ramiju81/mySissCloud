Class mySiss.Config.HO.Condicion Extends %Persistent [ SqlTableName = Condicion ]
{

Property IDCondicion As %Integer [ Required, SqlFieldName = ID_Condicion ];

Property NombreCondicion As %String(MAXLEN = 150) [ SqlFieldName = Condicion ];

Property VrCondic As %Numeric(MAXVAL = 9999999999999999.99, MINVAL = -9999999999999999.99, SCALE = 2) [ SqlFieldName = Vr_Condic ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDCondicion [ PrimaryKey, Unique ];

Storage Default
{
<Data name="CondicionDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDCondicion</Value>
</Value>
<Value name="3">
<Value>NombreCondicion</Value>
</Value>
<Value name="4">
<Value>VrCondic</Value>
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
<DataLocation>^mySiss.Config.HO.CondicionD</DataLocation>
<DefaultData>CondicionDefaultData</DefaultData>
<IdLocation>^mySiss.Config.HO.CondicionD</IdLocation>
<IndexLocation>^mySiss.Config.HO.CondicionI</IndexLocation>
<StreamLocation>^mySiss.Config.HO.CondicionS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
