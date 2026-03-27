Class mySiss.Config.WS.IntegracionLog Extends %Persistent [ SqlTableName = WSIntegracionLog ]
{

Property IDLog As %Integer [ Required, SqlFieldName = id_log ];

Property IDIntegracion As %Integer [ Required, SqlFieldName = id_integracion ];

Property IDCliente As %Integer [ SqlFieldName = id_cliente ];

Property FechaEjecucion As %TimeStamp [ SqlFieldName = fecha_ejecucion ];

Property Estado As %String(MAXLEN = 10) [ SqlFieldName = estado ];

Property Mensaje As %String(MAXLEN = 500) [ SqlFieldName = mensaje ];

Property ResponseResumido As %String(MAXLEN = 4000) [ SqlFieldName = response_resumido ];

Property Error As %String(MAXLEN = 4000) [ SqlFieldName = error ];

Property UsuarioEjecucion As %String(MAXLEN = 120) [ SqlFieldName = usuario_ejecucion ];

Property ModuloOrigen As %String(MAXLEN = 80) [ SqlFieldName = modulo_origen ];

Property CodigoHTTP As %Integer [ SqlFieldName = codigo_http ];

Index PK On IDLog [ PrimaryKey, Unique ];

Index IDXIntegracion On IDIntegracion;

Index IDXCliente On IDCliente;

Index IDXFecha On FechaEjecucion;

}
