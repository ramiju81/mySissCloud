Class mySiss.Config.HO.Medico Extends %Persistent [ SqlTableName = Medico ]
{

Property IDMedico As %Integer [ Required, SqlFieldName = ID_Medico ];

Property Nombres As %String(MAXLEN = 180) [ SqlFieldName = Nombres ];

Property IDTipoDocumento As %Integer [ SqlFieldName = ID_TipoDocumento ];

Property Documento As %String(MAXLEN = 60) [ SqlFieldName = documento ];

Property TjProf As %String(MAXLEN = 60) [ SqlFieldName = Tj_Prof ];

Property IDEspecialidad As %Integer [ SqlFieldName = ID_Especialidad ];

Property IDUser As %Integer [ SqlFieldName = ID_User ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDMedico [ PrimaryKey, Unique ];

Index IDXDocumento On Documento;

Storage Default
{
<Data name="MedicoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDMedico</Value>
</Value>
<Value name="3">
<Value>Nombres</Value>
</Value>
<Value name="4">
<Value>IDTipoDocumento</Value>
</Value>
<Value name="5">
<Value>Documento</Value>
</Value>
<Value name="6">
<Value>TjProf</Value>
</Value>
<Value name="7">
<Value>IDEspecialidad</Value>
</Value>
<Value name="8">
<Value>IDUser</Value>
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
<DataLocation>^mySiss.Config.HO.MedicoD</DataLocation>
<DefaultData>MedicoDefaultData</DefaultData>
<IdLocation>^mySiss.Config.HO.MedicoD</IdLocation>
<IndexLocation>^mySiss.Config.HO.MedicoI</IndexLocation>
<StreamLocation>^mySiss.Config.HO.MedicoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
