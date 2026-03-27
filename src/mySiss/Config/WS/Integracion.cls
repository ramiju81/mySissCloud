Class mySiss.Config.WS.Integracion Extends %Persistent [ SqlTableName = WSIntegracion ]
{

Property IDIntegracion As %Integer [ Required, SqlFieldName = id_integracion ];

Property Nombre As %String(MAXLEN = 150) [ Required, SqlFieldName = nombre ];

Property Descripcion As %String(MAXLEN = 500) [ SqlFieldName = descripcion ];

Property MetodoHTTP As %String(MAXLEN = 10) [ SqlFieldName = metodo_http ];

Property UrlBase As %String(MAXLEN = 500) [ SqlFieldName = url_base ];

Property Endpoint As %String(MAXLEN = 500) [ SqlFieldName = endpoint ];

Property TipoAutenticacion As %String(MAXLEN = 40) [ SqlFieldName = tipo_autenticacion ];

Property Headers As %String(MAXLEN = 4000) [ SqlFieldName = headers ];

Property BodyTemplate As %String(MAXLEN = 8000) [ SqlFieldName = body_template ];

Property TimeoutSegundos As %Integer [ SqlFieldName = timeout ];

Property Activo As %Integer [ SqlFieldName = activo ];

Property FechaCreacion As %TimeStamp [ SqlFieldName = fecha_creacion ];

Property FechaActualizacion As %TimeStamp [ SqlFieldName = fecha_actualizacion ];

Index PK On IDIntegracion [ PrimaryKey, Unique ];

Index IDXActivo On Activo;

}
