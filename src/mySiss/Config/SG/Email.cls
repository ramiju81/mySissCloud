Class mySiss.Config.SG.Email Extends %Persistent [ SqlTableName = Email ]
{

Property IDEmail As %Integer [ Required, SqlFieldName = ID_Email ];

Property Email As %String(MAXLEN = 180) [ Required, SqlFieldName = Email ];

Index PK On IDEmail [ PrimaryKey, Unique ];

Index IDXEmail On Email [ Unique ];

Storage Default
{
<Data name="EmailDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDEmail</Value>
</Value>
<Value name="3">
<Value>Email</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.SG.EmailD</DataLocation>
<DefaultData>EmailDefaultData</DefaultData>
<IdLocation>^mySiss.Config.SG.EmailD</IdLocation>
<IndexLocation>^mySiss.Config.SG.EmailI</IndexLocation>
<StreamLocation>^mySiss.Config.SG.EmailS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
