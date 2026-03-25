Class mySiss.Config.AU.CMPosicion Extends %Persistent [ SqlTableName = CMPosicion ]
{

Property IDCMPosicion As %Integer [ Required, SqlFieldName = ID_CMPosicion ];

Property CodigAudit As %Integer [ SqlFieldName = CodigAudit ];

Property IDServicio As %Integer [ SqlFieldName = ID_Servicio ];

Property FechaReali As %Date [ SqlFieldName = FechaReali ];

Property DocSoporte As %String(MAXLEN = 250) [ SqlFieldName = DocSoporte ];

Property Cumplimien As %Integer [ SqlFieldName = Cumplimien ];

Property NotaAudito As %Integer [ SqlFieldName = NotaAudito ];

Property SoluAudito As %String(MAXLEN = 500) [ SqlFieldName = SoluAudito ];

Property UsuaRespon As %Integer [ SqlFieldName = UsuaRespon ];

Property FechaCorre As %TimeStamp [ SqlFieldName = FechaCorre ];

Property JustCierre As %String(MAXLEN = 500) [ SqlFieldName = JustCierre ];

Property FechaCierr As %TimeStamp [ SqlFieldName = FechaCierr ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDCMPosicion [ PrimaryKey, Unique ];

Storage Default
{
<Data name="CMPosicionDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDCMPosicion</Value>
</Value>
<Value name="3">
<Value>CodigAudit</Value>
</Value>
<Value name="4">
<Value>IDServicio</Value>
</Value>
<Value name="5">
<Value>FechaReali</Value>
</Value>
<Value name="6">
<Value>DocSoporte</Value>
</Value>
<Value name="7">
<Value>Cumplimien</Value>
</Value>
<Value name="8">
<Value>NotaAudito</Value>
</Value>
<Value name="9">
<Value>SoluAudito</Value>
</Value>
<Value name="10">
<Value>UsuaRespon</Value>
</Value>
<Value name="11">
<Value>FechaCorre</Value>
</Value>
<Value name="12">
<Value>JustCierre</Value>
</Value>
<Value name="13">
<Value>FechaCierr</Value>
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
<DataLocation>^mySiss.Config.AU.CMPosicionD</DataLocation>
<DefaultData>CMPosicionDefaultData</DefaultData>
<IdLocation>^mySiss.Config.AU.CMPosicionD</IdLocation>
<IndexLocation>^mySiss.Config.AU.CMPosicionI</IndexLocation>
<StreamLocation>^mySiss.Config.AU.CMPosicionS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
