Class mySiss.Config.MS.Cliente Extends %Persistent [ SqlTableName = Cliente ]
{

Property IDCliente As %Integer [ Required, SqlFieldName = ID_Cliente ];

Property FiscalPrest As %Integer [ SqlFieldName = Fiscal_Prest ];

Property NombrePrest As %String(MAXLEN = 250) [ SqlFieldName = Nombre_Prest ];

Property DireccionPrest As %String(MAXLEN = 250) [ SqlFieldName = Direccion_Prest ];

Property DeptoPrest As %String(MAXLEN = 250) [ SqlFieldName = Depto_Prest ];

Property CiudadPrest As %String(MAXLEN = 250) [ SqlFieldName = Ciudad_Prest ];

Property PaisPrest As %String(MAXLEN = 250) [ SqlFieldName = Pais_Prest ];

Property TelefonoPrest As %Numeric [ SqlFieldName = Telefono_Prest ];

Property EmailPrestador As %String(MAXLEN = 180) [ SqlFieldName = Email_Prestador ];

Property FirmaDigPrest As %String(MAXLEN = 250) [ SqlFieldName = Firma_dig_Prest ];

Property LogoPrest As %String(MAXLEN = 250) [ SqlFieldName = Logo_Prest ];

Property IdSede As %Integer [ SqlFieldName = id_sede ];

Index PK On IDCliente [ PrimaryKey, Unique ];

Index IDXFiscalPrest On FiscalPrest [ Unique ];

Storage Default
{
<Data name="ClienteDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDCliente</Value>
</Value>
<Value name="3">
<Value>FiscalPrest</Value>
</Value>
<Value name="4">
<Value>NombrePrest</Value>
</Value>
<Value name="5">
<Value>DireccionPrest</Value>
</Value>
<Value name="6">
<Value>DeptoPrest</Value>
</Value>
<Value name="7">
<Value>CiudadPrest</Value>
</Value>
<Value name="8">
<Value>PaisPrest</Value>
</Value>
<Value name="9">
<Value>TelefonoPrest</Value>
</Value>
<Value name="10">
<Value>EmailPrestador</Value>
</Value>
<Value name="11">
<Value>FirmaDigPrest</Value>
</Value>
<Value name="12">
<Value>LogoPrest</Value>
</Value>
<Value name="13">
<Value>IdSede</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.MS.ClienteD</DataLocation>
<DefaultData>ClienteDefaultData</DefaultData>
<IdLocation>^mySiss.Config.MS.ClienteD</IdLocation>
<IndexLocation>^mySiss.Config.MS.ClienteI</IndexLocation>
<StreamLocation>^mySiss.Config.MS.ClienteS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
