Class mySiss.Config.SG.RolUser Extends %Persistent [ SqlTableName = RolUser ]
{

Property IDRolUser As %Integer [ Required, SqlFieldName = ID_roluser ];

Property User As mySiss.Config.SG.User [ Required, SqlFieldName = ID_user ];

Property Rol As mySiss.Config.SG.Rol [ Required, SqlFieldName = ID_rol ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDRolUser [ PrimaryKey, Unique ];

Index IDXUserRol On (User, Rol) [ Unique ];

Index IDXUser On User;

Index IDXRol On Rol;

ForeignKey FKRolUserUser(User) References mySiss.Config.SG.User();

ForeignKey FKRolUserRol(Rol) References mySiss.Config.SG.Rol();

Storage Default
{
<Data name="RolUserDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDRolUser</Value>
</Value>
<Value name="3">
<Value>User</Value>
</Value>
<Value name="4">
<Value>Rol</Value>
</Value>
<Value name="5">
<Value>FechaCrea</Value>
</Value>
<Value name="6">
<Value>FechaModif</Value>
</Value>
<Value name="7">
<Value>UserCreado</Value>
</Value>
<Value name="8">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.SG.RolUserD</DataLocation>
<DefaultData>RolUserDefaultData</DefaultData>
<ExtentSize>2</ExtentSize>
<IdLocation>^mySiss.Config.SG.RolUserD</IdLocation>
<IndexLocation>^mySiss.Config.SG.RolUserI</IndexLocation>
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
<Property name="IDRolUser">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Rol">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="User">
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
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IDXRol">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IDXUser">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IDXUserRol">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="PK">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^mySiss.Config.SG.RolUserS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
