Class mySiss.Config.SG.Passw Extends %Persistent [ SqlTableName = Passw ]
{

Property IDPassw As %Integer [ Required, SqlFieldName = ID_Passw ];

Property PasswHash As %String(MAXLEN = 255) [ Required, SqlFieldName = Passw_hash ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDPassw [ PrimaryKey, Unique ];

Storage Default
{
<Data name="PasswDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDPassw</Value>
</Value>
<Value name="3">
<Value>PasswHash</Value>
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
<DataLocation>^mySiss.Config.SG.PasswD</DataLocation>
<DefaultData>PasswDefaultData</DefaultData>
<IdLocation>^mySiss.Config.SG.PasswD</IdLocation>
<IndexLocation>^mySiss.Config.SG.PasswI</IndexLocation>
<StreamLocation>^mySiss.Config.SG.PasswS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
