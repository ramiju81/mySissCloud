Class mySiss.Config.AU.Validacion Extends %Persistent [ SqlTableName = Validacion ]
{

Property IDValidacion As %Integer [ Required, SqlFieldName = ID_Validacion ];

Property CodigLista As %Integer [ SqlFieldName = CodigLista ];

Property CodigRequi As %Integer [ SqlFieldName = CodigRequi ];

Property Validacion As %String(MAXLEN = 250) [ SqlFieldName = Validacion ];

Property Condicion As %Integer [ SqlFieldName = Condicion ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDValidacion [ PrimaryKey, Unique ];

Storage Default
{
<Data name="ValidacionDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDValidacion</Value>
</Value>
<Value name="3">
<Value>CodigLista</Value>
</Value>
<Value name="4">
<Value>CodigRequi</Value>
</Value>
<Value name="5">
<Value>Validacion</Value>
</Value>
<Value name="6">
<Value>Condicion</Value>
</Value>
<Value name="7">
<Value>FechaCrea</Value>
</Value>
<Value name="8">
<Value>FechaModif</Value>
</Value>
<Value name="9">
<Value>UserCreado</Value>
</Value>
<Value name="10">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.AU.ValidacionD</DataLocation>
<DefaultData>ValidacionDefaultData</DefaultData>
<IdLocation>^mySiss.Config.AU.ValidacionD</IdLocation>
<IndexLocation>^mySiss.Config.AU.ValidacionI</IndexLocation>
<StreamLocation>^mySiss.Config.AU.ValidacionS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
