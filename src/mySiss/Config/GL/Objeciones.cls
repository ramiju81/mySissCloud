Class mySiss.Config.GL.Objeciones Extends %Persistent [ SqlTableName = Objeciones ]
{

Property IDObjeciones As %Integer [ Required, SqlFieldName = ID_Objeciones ];

Property NumFactura As %Integer [ SqlFieldName = Num_factura ];

Property FechaObj As %TimeStamp [ SqlFieldName = Fecha_Obj ];

Property ConsecServ As %Numeric [ SqlFieldName = Consec_Serv ];

Property CodServ As %String(MAXLEN = 80) [ SqlFieldName = Cod_Serv ];

Property DescripServ As %String(MAXLEN = 500) [ SqlFieldName = Descrip_serv ];

Property CantidadServ As %Numeric [ SqlFieldName = Cantidad_Serv ];

Property IDEstadoServ As %Integer [ SqlFieldName = ID_estado_Serv ];

Property IDMotObj As %Integer [ SqlFieldName = ID_mot_Obj ];

Property IDMotEspecif As %Integer [ SqlFieldName = ID_mot_Especif ];

Property UserAsignado As %String(MAXLEN = 250) [ SqlFieldName = User_Asignado ];

Property FechaActual As %Date [ SqlFieldName = Fecha_Actual ];

Property VrServ As %String(MAXLEN = 250) [ SqlFieldName = Vr_Serv ];

Property VrPagador As %String(MAXLEN = 250) [ SqlFieldName = Vr_Pagador ];

Property FechaPagador As %TimeStamp [ SqlFieldName = Fecha_Pagador ];

Property NotaPagador As %String(MAXLEN = 500) [ SqlFieldName = Nota_Pagador ];

Property VrPrestador As %Numeric [ SqlFieldName = Vr_Prestador ];

Property FechaPrestad As %TimeStamp [ SqlFieldName = Fecha_Prestad ];

Property NotaPrestador As %String(MAXLEN = 80) [ SqlFieldName = Nota_Prestador ];

Property NumIteraccion As %Numeric [ SqlFieldName = Num_iteraccion ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDObjeciones [ PrimaryKey, Unique ];

Storage Default
{
<Data name="ObjecionesDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDObjeciones</Value>
</Value>
<Value name="3">
<Value>NumFactura</Value>
</Value>
<Value name="4">
<Value>FechaObj</Value>
</Value>
<Value name="5">
<Value>ConsecServ</Value>
</Value>
<Value name="6">
<Value>CodServ</Value>
</Value>
<Value name="7">
<Value>DescripServ</Value>
</Value>
<Value name="8">
<Value>CantidadServ</Value>
</Value>
<Value name="9">
<Value>IDEstadoServ</Value>
</Value>
<Value name="10">
<Value>IDMotObj</Value>
</Value>
<Value name="11">
<Value>IDMotEspecif</Value>
</Value>
<Value name="12">
<Value>UserAsignado</Value>
</Value>
<Value name="13">
<Value>FechaActual</Value>
</Value>
<Value name="14">
<Value>VrServ</Value>
</Value>
<Value name="15">
<Value>VrPagador</Value>
</Value>
<Value name="16">
<Value>FechaPagador</Value>
</Value>
<Value name="17">
<Value>NotaPagador</Value>
</Value>
<Value name="18">
<Value>VrPrestador</Value>
</Value>
<Value name="19">
<Value>FechaPrestad</Value>
</Value>
<Value name="20">
<Value>NotaPrestador</Value>
</Value>
<Value name="21">
<Value>NumIteraccion</Value>
</Value>
<Value name="22">
<Value>FechaCrea</Value>
</Value>
<Value name="23">
<Value>FechaModif</Value>
</Value>
<Value name="24">
<Value>UserCreado</Value>
</Value>
<Value name="25">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.GL.ObjecionesD</DataLocation>
<DefaultData>ObjecionesDefaultData</DefaultData>
<IdLocation>^mySiss.Config.GL.ObjecionesD</IdLocation>
<IndexLocation>^mySiss.Config.GL.ObjecionesI</IndexLocation>
<StreamLocation>^mySiss.Config.GL.ObjecionesS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
