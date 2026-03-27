Class mySiss.Config.SG.Actividad Extends %Persistent [ SqlTableName = Actividad ]
{

Property IDActividad As %Integer [ Required, SqlFieldName = ID_actividad ];

Property Funcion As mySiss.Config.SG.Funcion [ Required, SqlFieldName = ID_funcion ];

Property CodActividad As %String(MAXLEN = 50) [ Required, SqlFieldName = Cod_Actividad ];

Property Actividad As %String(MAXLEN = 150) [ Required, SqlFieldName = Actividad ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDActividad [ PrimaryKey, Unique ];

Index IDXFuncion On Funcion;

Index IDXCodActividad On CodActividad [ Unique ];

Index IDXActividad On Actividad;

ForeignKey FKActividadFuncion(Funcion) References mySiss.Config.SG.Funcion();

Storage Default
{
<Data name="ActividadDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDActividad</Value>
</Value>
<Value name="3">
<Value>Funcion</Value>
</Value>
<Value name="4">
<Value>CodActividad</Value>
</Value>
<Value name="5">
<Value>Actividad</Value>
</Value>
<Value name="6">
<Value>FechaCrea</Value>
</Value>
<Value name="7">
<Value>FechaModif</Value>
</Value>
<Value name="8">
<Value>UserCreado</Value>
</Value>
<Value name="9">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.SG.ActividadD</DataLocation>
<DefaultData>ActividadDefaultData</DefaultData>
<IdLocation>^mySiss.Config.SG.ActividadD</IdLocation>
<IndexLocation>^mySiss.Config.SG.ActividadI</IndexLocation>
<StreamLocation>^mySiss.Config.SG.ActividadS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
