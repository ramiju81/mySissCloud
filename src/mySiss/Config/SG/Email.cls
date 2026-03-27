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
<ExtentSize>2</ExtentSize>
<IdLocation>^mySiss.Config.SG.EmailD</IdLocation>
<IndexLocation>^mySiss.Config.SG.EmailI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Email">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="IDEmail">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IDXEmail">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="PK">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^mySiss.Config.SG.EmailS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
