Class mySiss.Config.AU.Opcion Extends %Persistent [ SqlTableName = Opcion ]
{

Property IDOpcion As %Integer [ Required, SqlFieldName = ID_Opcion ];

Property Opcion As %String(MAXLEN = 250) [ SqlFieldName = Opcion ];

Property Activo As %String(MAXLEN = 1) [ SqlFieldName = Activo ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDOpcion [ PrimaryKey, Unique ];

Index IDXOpcion On Opcion [ Unique ];

Storage Default
{
<Data name="OpcionDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDOpcion</Value>
</Value>
<Value name="3">
<Value>Opcion</Value>
</Value>
<Value name="4">
<Value>Activo</Value>
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
<DataLocation>^mySiss.Config.AU.OpcionD</DataLocation>
<DefaultData>OpcionDefaultData</DefaultData>
<IdLocation>^mySiss.Config.AU.OpcionD</IdLocation>
<IndexLocation>^mySiss.Config.AU.OpcionI</IndexLocation>
<StreamLocation>^mySiss.Config.AU.OpcionS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
