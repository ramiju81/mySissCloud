Class mySiss.Config.HO.Preliquida Extends %Persistent [ SqlTableName = Preliquida ]
{

Property IDPreliquida As %Integer [ Required, SqlFieldName = ID_Preliquida ];

Property VrTotalPreli As %Numeric(MAXVAL = 9999999999999999.99, MINVAL = -9999999999999999.99, SCALE = 2) [ SqlFieldName = VrTotalPreli ];

Property IDCaso As %Integer [ SqlFieldName = ID_Caso ];

Property Medico As mySiss.Config.HO.Medico [ SqlFieldName = ID_Medico ];

Property IDEspecialidad As %Integer [ SqlFieldName = ID_Especialidad ];

Property ContratoRef As mySiss.Config.HO.Contrato [ SqlFieldName = ID_Contrato ];

Property IDServicio As %Integer [ SqlFieldName = ID_Servicio ];

Property IDDscto As %Integer [ SqlFieldName = ID_Dscto ];

Property FechaIni As %TimeStamp [ SqlFieldName = Fecha_Ini ];

Property FechaFin As %TimeStamp [ SqlFieldName = Fecha_Fin ];

Property IDAsegur As %Integer [ SqlFieldName = ID_Asegur ];

Property IDEstadoPreliq As %Integer [ SqlFieldName = ID_EstadoPreliq ];

Property PeriodoRef As mySiss.Config.HO.Periodo [ SqlFieldName = ID_Periodo ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDPreliquida [ PrimaryKey, Unique ];

Index IDXMedico On Medico;

Index IDXContratoRef On ContratoRef;

Index IDXPeriodoRef On PeriodoRef;

Storage Default
{
<Data name="PreliquidaDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDPreliquida</Value>
</Value>
<Value name="3">
<Value>VrTotalPreli</Value>
</Value>
<Value name="4">
<Value>IDCaso</Value>
</Value>
<Value name="5">
<Value>Medico</Value>
</Value>
<Value name="6">
<Value>IDEspecialidad</Value>
</Value>
<Value name="7">
<Value>ContratoRef</Value>
</Value>
<Value name="8">
<Value>IDServicio</Value>
</Value>
<Value name="9">
<Value>IDDscto</Value>
</Value>
<Value name="10">
<Value>FechaIni</Value>
</Value>
<Value name="11">
<Value>FechaFin</Value>
</Value>
<Value name="12">
<Value>IDAsegur</Value>
</Value>
<Value name="13">
<Value>IDEstadoPreliq</Value>
</Value>
<Value name="14">
<Value>PeriodoRef</Value>
</Value>
<Value name="15">
<Value>FechaCrea</Value>
</Value>
<Value name="16">
<Value>FechaModif</Value>
</Value>
<Value name="17">
<Value>UserCreado</Value>
</Value>
<Value name="18">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.HO.PreliquidaD</DataLocation>
<DefaultData>PreliquidaDefaultData</DefaultData>
<IdLocation>^mySiss.Config.HO.PreliquidaD</IdLocation>
<IndexLocation>^mySiss.Config.HO.PreliquidaI</IndexLocation>
<StreamLocation>^mySiss.Config.HO.PreliquidaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
