Class mySiss.Config.HO.Periodo Extends %Persistent [ SqlTableName = Periodo ]
{

Property IDPeriodo As %Integer [ Required, SqlFieldName = ID_Periodo ];

Property AnioMes As %Integer [ SqlFieldName = AnioMes ];

Property Ejercicio As %Integer [ SqlFieldName = ejercicio ];

Property FechaIniVig As %TimeStamp [ SqlFieldName = fechaIniVig ];

Property FechaFinVig As %TimeStamp [ SqlFieldName = fechaFinVig ];

Property Activo As %String(MAXLEN = 1) [ SqlFieldName = activo ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDPeriodo [ PrimaryKey, Unique ];

Storage Default
{
<Data name="PeriodoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDPeriodo</Value>
</Value>
<Value name="3">
<Value>AnioMes</Value>
</Value>
<Value name="4">
<Value>Ejercicio</Value>
</Value>
<Value name="5">
<Value>FechaIniVig</Value>
</Value>
<Value name="6">
<Value>FechaFinVig</Value>
</Value>
<Value name="7">
<Value>Activo</Value>
</Value>
<Value name="8">
<Value>FechaCrea</Value>
</Value>
<Value name="9">
<Value>FechaModif</Value>
</Value>
<Value name="10">
<Value>UserCreado</Value>
</Value>
<Value name="11">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.HO.PeriodoD</DataLocation>
<DefaultData>PeriodoDefaultData</DefaultData>
<IdLocation>^mySiss.Config.HO.PeriodoD</IdLocation>
<IndexLocation>^mySiss.Config.HO.PeriodoI</IndexLocation>
<StreamLocation>^mySiss.Config.HO.PeriodoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
