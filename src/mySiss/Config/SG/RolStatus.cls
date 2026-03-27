Class mySiss.Config.SG.RolStatus Extends %Persistent [ SqlTableName = RolStatus ]
{

Property IDRolStatus As %Integer [ Required, SqlFieldName = ID_RolStatus ];

Property IDRol As %Integer [ Required, SqlFieldName = ID_rol ];

Property Status As %String(MAXLEN = 20) [ Required, SqlFieldName = status ];

Property UpdatedAt As %TimeStamp [ SqlFieldName = updated_at ];

Index PK On IDRolStatus [ PrimaryKey, Unique ];

Index IDXRol On IDRol [ Unique ];

Storage Default
{
<Data name="RolStatusDefaultData">
<Value name="1"><Value>%%CLASSNAME</Value></Value>
<Value name="2"><Value>IDRolStatus</Value></Value>
<Value name="3"><Value>IDRol</Value></Value>
<Value name="4"><Value>Status</Value></Value>
<Value name="5"><Value>UpdatedAt</Value></Value>
</Data>
<DataLocation>^mySiss.Config.SG.RolStatusD</DataLocation>
<DefaultData>RolStatusDefaultData</DefaultData>
<IdLocation>^mySiss.Config.SG.RolStatusD</IdLocation>
<IndexLocation>^mySiss.Config.SG.RolStatusI</IndexLocation>
<StreamLocation>^mySiss.Config.SG.RolStatusS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
