Class mySiss.Config.SG.User Extends %Persistent [ SqlTableName = User ]
{

Property IDUser As %Integer [ Required, SqlFieldName = ID_user ];

Property IDCliente As %Integer [ SqlFieldName = ID_Cliente ];

Property Person As mySiss.Config.SG.Person [ Required, SqlFieldName = ID_Person ];

Property NombreUser As %String(MAXLEN = 60) [ Required, SqlFieldName = Nombre_user ];

Property Password As mySiss.Config.SG.Passw [ Required, SqlFieldName = ID_Password ];

Property ValidoDe As %Date [ SqlFieldName = Valido_de ];

Property ValidoHasta As %Date [ SqlFieldName = Valido_hasta ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDUser [ PrimaryKey, Unique ];

Index IDXNombreUser On NombreUser [ Unique ];

Index IDXPerson On Person;

Index IDXPassword On Password;

Index IDXCliente On IDCliente;

ForeignKey FKUserPerson(Person) References mySiss.Config.SG.Person();

ForeignKey FKUserPassw(Password) References mySiss.Config.SG.Passw();

Storage Default
{
<Data name="UserDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDUser</Value>
</Value>
<Value name="3">
<Value>IDCliente</Value>
</Value>
<Value name="4">
<Value>Person</Value>
</Value>
<Value name="5">
<Value>NombreUser</Value>
</Value>
<Value name="6">
<Value>Password</Value>
</Value>
<Value name="7">
<Value>ValidoDe</Value>
</Value>
<Value name="8">
<Value>ValidoHasta</Value>
</Value>
<Value name="9">
<Value>FechaCrea</Value>
</Value>
<Value name="10">
<Value>FechaModif</Value>
</Value>
<Value name="11">
<Value>UserCreado</Value>
</Value>
<Value name="12">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.SG.UserD</DataLocation>
<DefaultData>UserDefaultData</DefaultData>
<ExtentSize>2</ExtentSize>
<IdLocation>^mySiss.Config.SG.UserD</IdLocation>
<IndexLocation>^mySiss.Config.SG.UserI</IndexLocation>
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
<Property name="IDCliente">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="IDUser">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="NombreUser">
<AverageFieldSize>8</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Password">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="Person">
<AverageFieldSize>3</AverageFieldSize>
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
<Property name="ValidoDe">
<AverageFieldSize>5</AverageFieldSize>
<OutlierSelectivity>.999999:67655</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="ValidoHasta">
<AverageFieldSize>5</AverageFieldSize>
<OutlierSelectivity>.999999:94598</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IDXCliente">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IDXNombreUser">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IDXPassword">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IDXPerson">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="PK">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^mySiss.Config.SG.UserS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
