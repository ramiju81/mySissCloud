Class mySiss.Config.AU.PosiHallaz Extends %Persistent [ SqlTableName = PosiHallaz ]
{

Property CodHalla As %Integer [ Required, SqlFieldName = Cod_Halla ];

Property CodLista As %Integer [ SqlFieldName = Cod_Lista ];

Property CodRequi As %Integer [ SqlFieldName = Cod_Requi ];

Property DescriRequ As %String(MAXLEN = 500) [ SqlFieldName = DescriRequ ];

Property Observacion As %String(MAXLEN = 500) [ SqlFieldName = Observacion ];

Property Cumplimien As %Integer [ SqlFieldName = Cumplimien ];

Property Impacto As %Integer [ SqlFieldName = Impacto ];

Property Evidencia As %String(MAXLEN = 500) [ SqlFieldName = Evidencia ];

Property FuenteVide As %Integer [ SqlFieldName = FuenteVide ];

Property Comentario As %String(MAXLEN = 250) [ SqlFieldName = Comentario ];

Property AccionMejo As %String(MAXLEN = 250) [ SqlFieldName = AccionMejo ];

Property RespoMejor As %String(MAXLEN = 250) [ SqlFieldName = RespoMejor ];

Property FechCumACC As %Date [ SqlFieldName = FechCumACC ];

Property EstadoACCI As %Integer [ SqlFieldName = EstadoACCI ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On CodHalla [ PrimaryKey, Unique ];

Storage Default
{
<Data name="PosiHallazDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CodHalla</Value>
</Value>
<Value name="3">
<Value>CodLista</Value>
</Value>
<Value name="4">
<Value>CodRequi</Value>
</Value>
<Value name="5">
<Value>DescriRequ</Value>
</Value>
<Value name="6">
<Value>Observacion</Value>
</Value>
<Value name="7">
<Value>Cumplimien</Value>
</Value>
<Value name="8">
<Value>Impacto</Value>
</Value>
<Value name="9">
<Value>Evidencia</Value>
</Value>
<Value name="10">
<Value>FuenteVide</Value>
</Value>
<Value name="11">
<Value>Comentario</Value>
</Value>
<Value name="12">
<Value>AccionMejo</Value>
</Value>
<Value name="13">
<Value>RespoMejor</Value>
</Value>
<Value name="14">
<Value>FechCumACC</Value>
</Value>
<Value name="15">
<Value>EstadoACCI</Value>
</Value>
<Value name="16">
<Value>FechaCrea</Value>
</Value>
<Value name="17">
<Value>FechaModif</Value>
</Value>
<Value name="18">
<Value>UserCreado</Value>
</Value>
<Value name="19">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.AU.PosiHallazD</DataLocation>
<DefaultData>PosiHallazDefaultData</DefaultData>
<IdLocation>^mySiss.Config.AU.PosiHallazD</IdLocation>
<IndexLocation>^mySiss.Config.AU.PosiHallazI</IndexLocation>
<StreamLocation>^mySiss.Config.AU.PosiHallazS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
