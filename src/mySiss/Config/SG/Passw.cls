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
<ExtentSize>2</ExtentSize>
<IdLocation>^mySiss.Config.SG.PasswD</IdLocation>
<IndexLocation>^mySiss.Config.SG.PasswI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="FechaCrea">
<AverageFieldSize>21</AverageFieldSize>
<OutlierSelectivity>.999999:"2026-03-26 11:47:10"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="FechaModif">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="IDPassw">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="PasswHash">
<AverageFieldSize>46</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="UserCreado">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:0</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="UserModif">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="PK">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^mySiss.Config.SG.PasswS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
