Class mySiss.Config.MS.Asegur Extends %Persistent [ SqlTableName = Asegur ]
{

Property IDAsegur As %Integer [ Required, SqlFieldName = ID_Asegur ];

Property IDAsegu As %Integer [ SqlFieldName = ID_Asegu ];

Property Nombre As %String(MAXLEN = 250) [ Required, SqlFieldName = Nombre ];

Property NIT As %String(MAXLEN = 80) [ Required, SqlFieldName = NIT ];

Property Direccion As %String(MAXLEN = 250) [ SqlFieldName = Direccion ];

Property Telefono As %String(MAXLEN = 250) [ SqlFieldName = Telefono ];

Property Email As %String(MAXLEN = 180) [ SqlFieldName = Email ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_Crea ];

Property FechaAct As %TimeStamp [ SqlFieldName = Fecha_Act ];

Index PK On IDAsegur [ PrimaryKey, Unique ];

Index IDXNombre On Nombre [ Unique ];

Index IDXNIT On NIT [ Unique ];

Storage Default
{
<Data name="AsegurDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDAsegur</Value>
</Value>
<Value name="3">
<Value>IDAsegu</Value>
</Value>
<Value name="4">
<Value>Nombre</Value>
</Value>
<Value name="5">
<Value>NIT</Value>
</Value>
<Value name="6">
<Value>Direccion</Value>
</Value>
<Value name="7">
<Value>Telefono</Value>
</Value>
<Value name="8">
<Value>Email</Value>
</Value>
<Value name="9">
<Value>FechaCrea</Value>
</Value>
<Value name="10">
<Value>FechaAct</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.MS.AsegurD</DataLocation>
<DefaultData>AsegurDefaultData</DefaultData>
<IdLocation>^mySiss.Config.MS.AsegurD</IdLocation>
<IndexLocation>^mySiss.Config.MS.AsegurI</IndexLocation>
<StreamLocation>^mySiss.Config.MS.AsegurS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
