Class mySiss.Config.SG.Person Extends %Persistent [ SqlTableName = Person ]
{

Property IDPerson As %Integer [ Required, SqlFieldName = ID_Person ];

Property Nombre As %String(MAXLEN = 80) [ Required, SqlFieldName = Nombre ];

Property Nombre2 As %String(MAXLEN = 80) [ SqlFieldName = Nombre2 ];

Property Apellido As %String(MAXLEN = 80) [ Required, SqlFieldName = Apellido ];

Property Apellido2 As %String(MAXLEN = 80) [ SqlFieldName = Apellido2 ];

Property IDTipoDoc As %Integer [ SqlFieldName = ID_Tipo_Doc ];

Property Cedula As %String(MAXLEN = 30) [ Required, SqlFieldName = Cedula ];

Property Celular As mySiss.Config.SG.Celular [ SqlFieldName = ID_Celular ];

Property Email As mySiss.Config.SG.Email [ SqlFieldName = ID_Email ];

Property Ocupacion As %String(MAXLEN = 100) [ SqlFieldName = Ocupacion ];

Property FechaNacmto As %Date [ SqlFieldName = Fecha_nacmto ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDPerson [ PrimaryKey, Unique ];

Index IDXCedula On (IDTipoDoc, Cedula) [ Unique ];

Index IDXApellidoNombre On (Apellido, Nombre);

Index IDXCelular On Celular;

Index IDXEmail On Email;

ForeignKey FKPersonCelular(Celular) References mySiss.Config.SG.Celular();

ForeignKey FKPersonEmail(Email) References mySiss.Config.SG.Email();

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDPerson</Value>
</Value>
<Value name="3">
<Value>Nombre</Value>
</Value>
<Value name="4">
<Value>Nombre2</Value>
</Value>
<Value name="5">
<Value>Apellido</Value>
</Value>
<Value name="6">
<Value>Apellido2</Value>
</Value>
<Value name="7">
<Value>IDTipoDoc</Value>
</Value>
<Value name="8">
<Value>Cedula</Value>
</Value>
<Value name="9">
<Value>Celular</Value>
</Value>
<Value name="10">
<Value>Email</Value>
</Value>
<Value name="11">
<Value>Ocupacion</Value>
</Value>
<Value name="12">
<Value>FechaNacmto</Value>
</Value>
<Value name="13">
<Value>FechaCrea</Value>
</Value>
<Value name="14">
<Value>FechaModif</Value>
</Value>
<Value name="15">
<Value>UserCreado</Value>
</Value>
<Value name="16">
<Value>UserModif</Value>
</Value>
</Data>
<DataLocation>^mySiss.Config.SG.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<ExtentSize>2</ExtentSize>
<IdLocation>^mySiss.Config.SG.PersonD</IdLocation>
<IndexLocation>^mySiss.Config.SG.PersonI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Apellido">
<AverageFieldSize>8</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="Apellido2">
<AverageFieldSize>5.5</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="Cedula">
<AverageFieldSize>16</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="Celular">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="Email">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="FechaCrea">
<AverageFieldSize>21</AverageFieldSize>
<OutlierSelectivity>.999999:"2026-03-26 11:47:10"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="FechaModif">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="FechaNacmto">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="IDPerson">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="IDTipoDoc">
<AverageFieldSize>3</AverageFieldSize>
<OutlierSelectivity>.999999:1</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="Nombre">
<AverageFieldSize>8</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="Nombre2">
<AverageFieldSize>5.5</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="Ocupacion">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="UserCreado">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:0</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="UserModif">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IDXApellidoNombre">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IDXCedula">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IDXCelular">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IDXEmail">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="PK">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^mySiss.Config.SG.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
