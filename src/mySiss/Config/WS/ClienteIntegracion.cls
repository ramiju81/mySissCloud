Class mySiss.Config.WS.ClienteIntegracion Extends %Persistent [ SqlTableName = WSClienteIntegracion ]
{

Property IDRel As %Integer [ Required, SqlFieldName = id_rel ];

Property IDCliente As %Integer [ Required, SqlFieldName = id_cliente ];

Property IDIntegracion As %Integer [ Required, SqlFieldName = id_integracion ];

Property Activo As %Integer [ SqlFieldName = activo ];

Property Configuracion As %String(MAXLEN = 4000) [ SqlFieldName = configuracion ];

Property FechaCreacion As %TimeStamp [ SqlFieldName = fecha_creacion ];

Property FechaActualizacion As %TimeStamp [ SqlFieldName = fecha_actualizacion ];

Index PK On IDRel [ PrimaryKey, Unique ];

Index IDXClienteIntegracion On (IDCliente, IDIntegracion) [ Unique ];

Index IDXCliente On IDCliente;

Index IDXIntegracion On IDIntegracion;

}
