Class mySiss.Config.AU.ListasPosi Extends %Persistent [ SqlTableName = ListasPosi ]
{

Property CodigLista As %Integer [ Required, SqlFieldName = CodigLista ];

Property CodigRequi As %Integer [ SqlFieldName = CodigRequi ];

Property DescriRequ As %String(MAXLEN = 500) [ SqlFieldName = DescriRequ ];

Property Observacio As %String(MAXLEN = 500) [ SqlFieldName = Observacio ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On CodigLista [ PrimaryKey, Unique ];

Storage Default
{
<Data name="ListasPosiDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CodigLista</Value>
</Value>
<Value name="3">
<Value>CodigRequi</Value>
</Value>
<Value name="4">
<Value>DescriRequ</Value>
</Value>
<Value name="5">
<Value>Observacio</Value>
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
<DataLocation>^mySiss.Config.AU.ListasPosiD</DataLocation>
<DefaultData>ListasPosiDefaultData</DefaultData>
<IdLocation>^mySiss.Config.AU.ListasPosiD</IdLocation>
<IndexLocation>^mySiss.Config.AU.ListasPosiI</IndexLocation>
<StreamLocation>^mySiss.Config.AU.ListasPosiS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
