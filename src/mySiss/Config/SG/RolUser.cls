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
<IdLocation>^mySiss.Config.SG.RolUserD</IdLocation>
<IndexLocation>^mySiss.Config.SG.RolUserI</IndexLocation>
<StreamLocation>^mySiss.Config.SG.RolUserS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
