Class mySiss.Config.SG.Funcion Extends %Persistent [ SqlTableName = Funcion ]
{

Property IDFuncion As %Integer [ Required, SqlFieldName = ID_Funcion ];

Property Modulo As mySiss.Config.SG.Modulo [ Required, SqlFieldName = ID_Modulo ];

Property CodFuncion As %String(MAXLEN = 50) [ Required, SqlFieldName = Cod_Funcion ];

Property Funcion As %String(MAXLEN = 150) [ Required, SqlFieldName = Funcion ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDFuncion [ PrimaryKey, Unique ];

Index IDXModulo On Modulo;

Index IDXCodFuncion On CodFuncion [ Unique ];

Index IDXFuncion On Funcion;

ForeignKey FKFuncionModulo(Modulo) References mySiss.Config.SG.Modulo();

Storage Default
{
<Data name="FuncionDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDFuncion</Value>
</Value>
<Value name="3">
<Value>Modulo</Value>
</Value>
<Value name="4">
<Value>CodFuncion</Value>
</Value>
<Value name="5">
<Value>Funcion</Value>
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
<DataLocation>^mySiss.Config.SG.FuncionD</DataLocation>
<DefaultData>FuncionDefaultData</DefaultData>
<IdLocation>^mySiss.Config.SG.FuncionD</IdLocation>
<IndexLocation>^mySiss.Config.SG.FuncionI</IndexLocation>
<StreamLocation>^mySiss.Config.SG.FuncionS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
