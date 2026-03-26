Class mySiss.Config.SG.PerValidez Extends %Persistent [ SqlTableName = PerValidez ]
{

Property IDPerValidez As %Integer [ Required, SqlFieldName = ID_PerValidez ];

Property User As mySiss.Config.SG.User [ Required, SqlFieldName = ID_user ];

Property Motivo As mySiss.Config.SG.Motivo [ Required, SqlFieldName = ID_motivo ];

Property Status As %String(MAXLEN = 1) [ Required, SqlFieldName = status ];

Property ValidoDe As %Date [ SqlFieldName = valido_de ];

Property ValidoHasta As %Date [ SqlFieldName = valido_hasta ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDPerValidez [ PrimaryKey, Unique ];

Index IDXUser On User;

Index IDXMotivo On Motivo;

Index IDXStatusFechas On (Status, ValidoDe, ValidoHasta);

ForeignKey FKPerValidezUser(User) References mySiss.Config.SG.User();

ForeignKey FKPerValidezMotivo(Motivo) References mySiss.Config.SG.Motivo();

Storage Default
{
<Data name="PerValidezDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDPerValidez</Value>
</Value>
<Value name="3">
<Value>User</Value>
</Value>
<Value name="4">
<Value>Motivo</Value>
</Value>
<Value name="5">
<Value>Status</Value>
</Value>
<Value name="6">
<Value>ValidoDe</Value>
</Value>
<Value name="7">
<Value>ValidoHasta</Value>
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
<DataLocation>^mySiss.Config.SG.PerValidezD</DataLocation>
<DefaultData>PerValidezDefaultData</DefaultData>
<IdLocation>^mySiss.Config.SG.PerValidezD</IdLocation>
<IndexLocation>^mySiss.Config.SG.PerValidezI</IndexLocation>
<StreamLocation>^mySiss.Config.SG.PerValidezS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
