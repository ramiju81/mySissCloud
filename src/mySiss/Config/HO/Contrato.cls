Class mySiss.Config.HO.Contrato Extends %Persistent [ SqlTableName = Contrato ]
{

Property IDContrato As %Integer [ Required, SqlFieldName = ID_Contrato ];

Property TipoContrato As %String(MAXLEN = 120) [ SqlFieldName = tipo_contrato ];

Property CondicionRef As mySiss.Config.HO.Condicion [ SqlFieldName = ID_Condicion ];

Property FechaVigInicio As %Date [ SqlFieldName = fecha_vig_inicio ];

Property FechaVigFin As %Date [ SqlFieldName = fecha_vig_fin ];

Property Medico As mySiss.Config.HO.Medico [ SqlFieldName = ID_medico ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDContrato [ PrimaryKey, Unique ];

Index IDXCondicionRef On CondicionRef;

Index IDXMedico On Medico;

Storage Default
{
<Data name="ContratoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDContrato</Value>
</Value>
<Value name="3">
<Value>TipoContrato</Value>
</Value>
<Value name="4">
<Value>CondicionRef</Value>
</Value>
<Value name="5">
<Value>FechaVigInicio</Value>
</Value>
<Value name="6">
<Value>FechaVigFin</Value>
</Value>
<Value name="7">
<Value>Medico</Value>
</Value>
<Value name="8">
<Value>FechaCrea</Value>
</Value>
<Value name="9">
<Value>FechaModif</Value>
</Value>
<Value name="10">
<Value>UserCreado</Value>
</Value>
<Value name="11">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.HO.ContratoD</DataLocation>
<DefaultData>ContratoDefaultData</DefaultData>
<IdLocation>^mySiss.Config.HO.ContratoD</IdLocation>
<IndexLocation>^mySiss.Config.HO.ContratoI</IndexLocation>
<StreamLocation>^mySiss.Config.HO.ContratoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
