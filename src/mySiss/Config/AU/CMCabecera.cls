Class mySiss.Config.AU.CMCabecera Extends %Persistent [ SqlTableName = CMCabecera ]
{

Property CodigAudit As %Integer [ Required, SqlFieldName = CodigAudit ];

Property NumeroCaso As %Integer [ SqlFieldName = NumeroCaso ];

Property EstadoAudi As %Integer [ SqlFieldName = EstadoAudi ];

Property UserAuditor As %Integer [ SqlFieldName = UserAuditor ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On CodigAudit [ PrimaryKey, Unique ];

Storage Default
{
<Data name="CMCabeceraDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CodigAudit</Value>
</Value>
<Value name="3">
<Value>NumeroCaso</Value>
</Value>
<Value name="4">
<Value>EstadoAudi</Value>
</Value>
<Value name="5">
<Value>UserAuditor</Value>
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
<DataLocation>^mySiss.Config.AU.CMCabeceraD</DataLocation>
<DefaultData>CMCabeceraDefaultData</DefaultData>
<IdLocation>^mySiss.Config.AU.CMCabeceraD</IdLocation>
<IndexLocation>^mySiss.Config.AU.CMCabeceraI</IndexLocation>
<StreamLocation>^mySiss.Config.AU.CMCabeceraS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
