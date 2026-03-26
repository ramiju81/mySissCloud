Class mySiss.Config.SG.Motivo Extends %Persistent [ SqlTableName = Motivo ]
{

Property IDMotivo As %Integer [ Required, SqlFieldName = ID_motivo ];

Property Motivo As %String(MAXLEN = 150) [ Required, SqlFieldName = motivo ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDMotivo [ PrimaryKey, Unique ];

Index IDXMotivo On Motivo [ Unique ];

Storage Default
{
<Data name="MotivoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDMotivo</Value>
</Value>
<Value name="3">
<Value>Motivo</Value>
</Value>
<Value name="4">
<Value>FechaCrea</Value>
</Value>
<Value name="5">
<Value>FechaModif</Value>
</Value>
<Value name="6">
<Value>UserCreado</Value>
</Value>
<Value name="7">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.SG.MotivoD</DataLocation>
<DefaultData>MotivoDefaultData</DefaultData>
<IdLocation>^mySiss.Config.SG.MotivoD</IdLocation>
<IndexLocation>^mySiss.Config.SG.MotivoI</IndexLocation>
<StreamLocation>^mySiss.Config.SG.MotivoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
