Class mySiss.Config.WS.DocClin Extends %Persistent [ SqlTableName = DocClin ]
{

Property IDDocClin As %Integer [ Required, SqlFieldName = ID_DocClin ];

Property IDCaso As %Integer [ SqlFieldName = ID_Caso ];

Property TipoDato As %String(MAXLEN = 80) [ SqlFieldName = tipo_dato ];

Property Nombre As %String(MAXLEN = 250) [ SqlFieldName = nombre ];

Property IDDoc As %String(MAXLEN = 80) [ SqlFieldName = ID_Doc ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property Serv As %String(MAXLEN = 250) [ SqlFieldName = Serv ];

Property EmpleadoRespons As %String(MAXLEN = 250) [ SqlFieldName = Empleado_respons ];

Property CatalogoDx As %String(MAXLEN = 250) [ SqlFieldName = Catalogo_Dx ];

Property CodDx As %String(MAXLEN = 80) [ SqlFieldName = Cod_Dx ];

Property TipoDx As %String(MAXLEN = 80) [ SqlFieldName = Tipo_Dx ];

Property Certeza As %String(MAXLEN = 250) [ SqlFieldName = certeza ];

Property Localizacion As %String(MAXLEN = 250) [ SqlFieldName = Localizacion ];

Property ClaseDx As %String(MAXLEN = 250) [ SqlFieldName = Clase_Dx ];

Property FechaSinc As %TimeStamp [ SqlFieldName = Fecha_Sinc ];

Index PK On IDDocClin [ PrimaryKey, Unique ];

Storage Default
{
<Data name="DocClinDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDDocClin</Value>
</Value>
<Value name="3">
<Value>IDCaso</Value>
</Value>
<Value name="4">
<Value>TipoDato</Value>
</Value>
<Value name="5">
<Value>Nombre</Value>
</Value>
<Value name="6">
<Value>IDDoc</Value>
</Value>
<Value name="7">
<Value>FechaCrea</Value>
</Value>
<Value name="8">
<Value>Serv</Value>
</Value>
<Value name="9">
<Value>EmpleadoRespons</Value>
</Value>
<Value name="10">
<Value>CatalogoDx</Value>
</Value>
<Value name="11">
<Value>CodDx</Value>
</Value>
<Value name="12">
<Value>TipoDx</Value>
</Value>
<Value name="13">
<Value>Certeza</Value>
</Value>
<Value name="14">
<Value>Localizacion</Value>
</Value>
<Value name="15">
<Value>ClaseDx</Value>
</Value>
<Value name="16">
<Value>FechaSinc</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.WS.DocClinD</DataLocation>
<DefaultData>DocClinDefaultData</DefaultData>
<IdLocation>^mySiss.Config.WS.DocClinD</IdLocation>
<IndexLocation>^mySiss.Config.WS.DocClinI</IndexLocation>
<StreamLocation>^mySiss.Config.WS.DocClinS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
