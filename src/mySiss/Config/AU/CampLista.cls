Class mySiss.Config.AU.CampLista Extends %Persistent [ SqlTableName = CampLista ]
{

Property IDLista As %Integer [ Required, SqlFieldName = ID_Lista ];

Property Lista As %String(MAXLEN = 250) [ SqlFieldName = Lista ];

Property Activo As %String(MAXLEN = 1) [ SqlFieldName = Activo ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property Creado As %Integer [ SqlFieldName = Creado ];

Property Modif As %Integer [ SqlFieldName = Modif ];

Index PK On IDLista [ PrimaryKey, Unique ];

Index IDXLista On Lista [ Unique ];

Storage Default
{
<Data name="CampListaDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDLista</Value>
</Value>
<Value name="3">
<Value>Lista</Value>
</Value>
<Value name="4">
<Value>Activo</Value>
</Value>
<Value name="5">
<Value>FechaCrea</Value>
</Value>
<Value name="6">
<Value>FechaModif</Value>
</Value>
<Value name="7">
<Value>Creado</Value>
</Value>
<Value name="8">
<Value>Modif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.AU.CampListaD</DataLocation>
<DefaultData>CampListaDefaultData</DefaultData>
<IdLocation>^mySiss.Config.AU.CampListaD</IdLocation>
<IndexLocation>^mySiss.Config.AU.CampListaI</IndexLocation>
<StreamLocation>^mySiss.Config.AU.CampListaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
