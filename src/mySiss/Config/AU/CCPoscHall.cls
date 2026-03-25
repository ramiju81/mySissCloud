Class mySiss.Config.AU.CCPoscHall Extends %Persistent [ SqlTableName = CCPoscHall ]
{

Property IDCCPoscHall As %Integer [ Required, SqlFieldName = ID_CCPoscHall ];

Property CodigAudit As %Integer [ SqlFieldName = CodigAudit ];

Property CodCompAud As %Integer [ SqlFieldName = CodCompAud ];

Property TxtoAudito As %String(MAXLEN = 250) [ SqlFieldName = TxtoAudito ];

Property UsuAuditor As %Integer [ SqlFieldName = UsuAuditor ];

Property SolucAudit As %String(MAXLEN = 500) [ SqlFieldName = SolucAudit ];

Property UsuaRespon As %Integer [ SqlFieldName = UsuaRespon ];

Property JustCierre As %Integer [ SqlFieldName = JustCierre ];

Property UsuaCierre As %Integer [ SqlFieldName = UsuaCierre ];

Property EstadoGral As %Integer [ SqlFieldName = EstadoGral ];

Property FechaActualiza As %TimeStamp [ SqlFieldName = Fecha_Actualiza ];

Property EvidAudito As %Integer [ SqlFieldName = EvidAudito ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDCCPoscHall [ PrimaryKey, Unique ];

Storage Default
{
<Data name="CCPoscHallDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDCCPoscHall</Value>
</Value>
<Value name="3">
<Value>CodigAudit</Value>
</Value>
<Value name="4">
<Value>CodCompAud</Value>
</Value>
<Value name="5">
<Value>TxtoAudito</Value>
</Value>
<Value name="6">
<Value>UsuAuditor</Value>
</Value>
<Value name="7">
<Value>SolucAudit</Value>
</Value>
<Value name="8">
<Value>UsuaRespon</Value>
</Value>
<Value name="9">
<Value>JustCierre</Value>
</Value>
<Value name="10">
<Value>UsuaCierre</Value>
</Value>
<Value name="11">
<Value>EstadoGral</Value>
</Value>
<Value name="12">
<Value>FechaActualiza</Value>
</Value>
<Value name="13">
<Value>EvidAudito</Value>
</Value>
<Value name="14">
<Value>FechaCrea</Value>
</Value>
<Value name="15">
<Value>FechaModif</Value>
</Value>
<Value name="16">
<Value>UserCreado</Value>
</Value>
<Value name="17">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.AU.CCPoscHallD</DataLocation>
<DefaultData>CCPoscHallDefaultData</DefaultData>
<IdLocation>^mySiss.Config.AU.CCPoscHallD</IdLocation>
<IndexLocation>^mySiss.Config.AU.CCPoscHallI</IndexLocation>
<StreamLocation>^mySiss.Config.AU.CCPoscHallS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
