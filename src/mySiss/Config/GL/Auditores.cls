Class mySiss.Config.GL.Auditores Extends %Persistent [ SqlTableName = Auditores ]
{

Property IDAuditores As %Integer [ Required, SqlFieldName = ID_Auditores ];

Property UserAuditor As %String(MAXLEN = 250) [ SqlFieldName = User_Auditor ];

Property NombreAuditor As %String(MAXLEN = 250) [ SqlFieldName = Nombre_Auditor ];

Property IdClaseAuditor As %Integer [ SqlFieldName = Id_Clase_Auditor ];

Property CorreoAuditor As %String(MAXLEN = 180) [ SqlFieldName = Correo_Auditor ];

Property IDUser As %Integer [ SqlFieldName = ID_User ];

Property FechaCrea As %TimeStamp [ SqlFieldName = Fecha_crea ];

Property FechaModif As %TimeStamp [ SqlFieldName = Fecha_modif ];

Property UserCreado As %Integer [ SqlFieldName = UserCreado ];

Property UserModif As %Integer [ SqlFieldName = UserModif ];

Index PK On IDAuditores [ PrimaryKey, Unique ];

Storage Default
{
<Data name="AuditoresDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDAuditores</Value>
</Value>
<Value name="3">
<Value>UserAuditor</Value>
</Value>
<Value name="4">
<Value>NombreAuditor</Value>
</Value>
<Value name="5">
<Value>IdClaseAuditor</Value>
</Value>
<Value name="6">
<Value>CorreoAuditor</Value>
</Value>
<Value name="7">
<Value>IDUser</Value>
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
<DataLocation>^mySiss.Config.GL.AuditoresD</DataLocation>
<DefaultData>AuditoresDefaultData</DefaultData>
<IdLocation>^mySiss.Config.GL.AuditoresD</IdLocation>
<IndexLocation>^mySiss.Config.GL.AuditoresI</IndexLocation>
<StreamLocation>^mySiss.Config.GL.AuditoresS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
