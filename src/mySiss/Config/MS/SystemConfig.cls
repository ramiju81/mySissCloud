Class mySiss.Config.MS.SystemConfig Extends %Persistent [ SqlTableName = SystemConfig ]
{

Property IDConfig As %Integer [ Required, SqlFieldName = ID_Config ];

Property Environment As %String(MAXLEN = 10) [ Required, SqlFieldName = environment ];

Property DatabaseEngine As %String(MAXLEN = 10) [ Required, SqlFieldName = database_engine ];

Property BackendBaseURL As %String(MAXLEN = 500) [ SqlFieldName = backend_base_url ];

Property FrontendBaseURL As %String(MAXLEN = 500) [ SqlFieldName = frontend_base_url ];

Property WebappBasePath As %String(MAXLEN = 200) [ SqlFieldName = webapp_base_path ];

Property DatabaseHost As %String(MAXLEN = 150) [ SqlFieldName = database_host ];

Property DatabasePort As %Integer [ SqlFieldName = database_port ];

Property DatabaseName As %String(MAXLEN = 150) [ SqlFieldName = database_name ];

Property DatabaseNamespace As %String(MAXLEN = 100) [ SqlFieldName = database_namespace ];

Property ConnectionStatus As %String(MAXLEN = 20) [ SqlFieldName = connection_status ];

Property LastCheckAt As %TimeStamp [ SqlFieldName = last_check_at ];

Property UpdatedAt As %TimeStamp [ SqlFieldName = updated_at ];

Property UpdatedBy As %String(MAXLEN = 60) [ SqlFieldName = updated_by ];

Index PK On IDConfig [ PrimaryKey, Unique ];

Index IDXEnvironment On Environment;

Storage Default
{
<Data name="SystemConfigDefaultData">
<Value name="1"><Value>%%CLASSNAME</Value></Value>
<Value name="2"><Value>IDConfig</Value></Value>
<Value name="3"><Value>Environment</Value></Value>
<Value name="4"><Value>DatabaseEngine</Value></Value>
<Value name="5"><Value>BackendBaseURL</Value></Value>
<Value name="6"><Value>FrontendBaseURL</Value></Value>
<Value name="7"><Value>WebappBasePath</Value></Value>
<Value name="8"><Value>DatabaseHost</Value></Value>
<Value name="9"><Value>DatabasePort</Value></Value>
<Value name="10"><Value>DatabaseName</Value></Value>
<Value name="11"><Value>DatabaseNamespace</Value></Value>
<Value name="12"><Value>ConnectionStatus</Value></Value>
<Value name="13"><Value>LastCheckAt</Value></Value>
<Value name="14"><Value>UpdatedAt</Value></Value>
<Value name="15"><Value>UpdatedBy</Value></Value>
</Data>
<DataLocation>^mySiss.Config.MS.SystemConfigD</DataLocation>
<DefaultData>SystemConfigDefaultData</DefaultData>
<IdLocation>^mySiss.Config.MS.SystemConfigD</IdLocation>
<IndexLocation>^mySiss.Config.MS.SystemConfigI</IndexLocation>
<StreamLocation>^mySiss.Config.MS.SystemConfigS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
