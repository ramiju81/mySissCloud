Class mySiss.Config.GL.DiasRes Extends %Persistent [ SqlTableName = DiasRes ]
{

Property IDDiasRes As %Integer [ Required, SqlFieldName = ID_DiasRes ];

Property IDPagador As %String(MAXLEN = 80) [ SqlFieldName = ID_pagador ];

Property NombrePagador As %String(MAXLEN = 250) [ SqlFieldName = Nombre_pagador ];

Property DiasHabiles As %Date [ SqlFieldName = Dias_habiles ];

Property IDEstadoFact As %Integer [ SqlFieldName = ID_Estado_fact ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDDiasRes [ PrimaryKey, Unique ];

Storage Default
{
<Data name="DiasResDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDDiasRes</Value>
</Value>
<Value name="3">
<Value>IDPagador</Value>
</Value>
<Value name="4">
<Value>NombrePagador</Value>
</Value>
<Value name="5">
<Value>DiasHabiles</Value>
</Value>
<Value name="6">
<Value>IDEstadoFact</Value>
</Value>
<Value name="7">
<Value>FechaCrea</Value>
</Value>
<Value name="8">
<Value>FechaModif</Value>
</Value>
<Value name="9">
<Value>UserCreado</Value>
</Value>
<Value name="10">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.GL.DiasResD</DataLocation>
<DefaultData>DiasResDefaultData</DefaultData>
<IdLocation>^mySiss.Config.GL.DiasResD</IdLocation>
<IndexLocation>^mySiss.Config.GL.DiasResI</IndexLocation>
<StreamLocation>^mySiss.Config.GL.DiasResS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
