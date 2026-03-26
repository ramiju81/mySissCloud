Class mySiss.Config.WS.Paciente Extends %Persistent [ SqlTableName = Paciente ]
{

Property IDPaciente As %Integer [ Required, SqlFieldName = ID_Paciente ];

Property IDAsegu As %Integer [ SqlFieldName = ID_Asegu ];

Property NumPaciente As %String(MAXLEN = 80) [ SqlFieldName = num_paciente ];

Property PrimerNombre As %String(MAXLEN = 250) [ SqlFieldName = primer_nombre ];

Property SegundoNombre As %String(MAXLEN = 250) [ SqlFieldName = segundo_nombre ];

Property PrimerApellido As %String(MAXLEN = 250) [ SqlFieldName = primer_apellido ];

Property SegundoApellido As %String(MAXLEN = 250) [ SqlFieldName = segundo_apellido ];

Property TipoDocumento As %String(MAXLEN = 80) [ SqlFieldName = tipo_documento ];

Property NumeroDocumento As %String(MAXLEN = 80) [ SqlFieldName = numero_documento ];

Property FechaNacimiento As %Date [ SqlFieldName = fecha_nacimiento ];

Property Sexo As %String(MAXLEN = 250) [ SqlFieldName = sexo ];

Property Nacionalidad As %String(MAXLEN = 250) [ SqlFieldName = nacionalidad ];

Property PaisNacmto As %String(MAXLEN = 250) [ SqlFieldName = pais_nacmto ];

Property Idioma As %String(MAXLEN = 250) [ SqlFieldName = idioma ];

Property Telefono As %String(MAXLEN = 250) [ SqlFieldName = telefono ];

Property Email As %String(MAXLEN = 180) [ SqlFieldName = Email ];

Property GrupoEtnico As %String(MAXLEN = 250) [ SqlFieldName = grupo_etnico ];

Property Religion As %String(MAXLEN = 250) [ SqlFieldName = religion ];

Property CondEspecial As %String(MAXLEN = 250) [ SqlFieldName = cond_especial ];

Property IndFallecimiento As %String(MAXLEN = 250) [ SqlFieldName = ind_fallecimiento ];

Property TipoParentesco As %String(MAXLEN = 80) [ SqlFieldName = tipo_parentesco ];

Property NombreAcomp As %String(MAXLEN = 250) [ SqlFieldName = nombre_acomp ];

Property ApellidosAcomp As %String(MAXLEN = 250) [ SqlFieldName = apellidos_acomp ];

Property AdmisionAmbul As %String(MAXLEN = 250) [ SqlFieldName = admision_ambul ];

Property AdmisionHosp As %String(MAXLEN = 250) [ SqlFieldName = admision_hosp ];

Property FechaSinc As %TimeStamp [ SqlFieldName = Fecha_Sinc ];

Index PK On IDPaciente [ PrimaryKey, Unique ];

Index IDXNumPaciente On NumPaciente [ Unique ];

Storage Default
{
<Data name="PacienteDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDPaciente</Value>
</Value>
<Value name="3">
<Value>IDAsegu</Value>
</Value>
<Value name="4">
<Value>NumPaciente</Value>
</Value>
<Value name="5">
<Value>PrimerNombre</Value>
</Value>
<Value name="6">
<Value>SegundoNombre</Value>
</Value>
<Value name="7">
<Value>PrimerApellido</Value>
</Value>
<Value name="8">
<Value>SegundoApellido</Value>
</Value>
<Value name="9">
<Value>TipoDocumento</Value>
</Value>
<Value name="10">
<Value>NumeroDocumento</Value>
</Value>
<Value name="11">
<Value>FechaNacimiento</Value>
</Value>
<Value name="12">
<Value>Sexo</Value>
</Value>
<Value name="13">
<Value>Nacionalidad</Value>
</Value>
<Value name="14">
<Value>PaisNacmto</Value>
</Value>
<Value name="15">
<Value>Idioma</Value>
</Value>
<Value name="16">
<Value>Telefono</Value>
</Value>
<Value name="17">
<Value>Email</Value>
</Value>
<Value name="18">
<Value>GrupoEtnico</Value>
</Value>
<Value name="19">
<Value>Religion</Value>
</Value>
<Value name="20">
<Value>CondEspecial</Value>
</Value>
<Value name="21">
<Value>IndFallecimiento</Value>
</Value>
<Value name="22">
<Value>TipoParentesco</Value>
</Value>
<Value name="23">
<Value>NombreAcomp</Value>
</Value>
<Value name="24">
<Value>ApellidosAcomp</Value>
</Value>
<Value name="25">
<Value>AdmisionAmbul</Value>
</Value>
<Value name="26">
<Value>AdmisionHosp</Value>
</Value>
<Value name="27">
<Value>FechaSinc</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.WS.PacienteD</DataLocation>
<DefaultData>PacienteDefaultData</DefaultData>
<IdLocation>^mySiss.Config.WS.PacienteD</IdLocation>
<IndexLocation>^mySiss.Config.WS.PacienteI</IndexLocation>
<StreamLocation>^mySiss.Config.WS.PacienteS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
