cd %~dp0

set "file=Check_Data_Source_Connectivity.properties"
set "datasource_connect_status_file_path=datasource_connect_status.txt"

setlocal ENABLEDELAYEDEXPANSION

for /F "usebackq delims=" %%a in (!file!) do (
		call set "param=%%a"
		
		call set "param=%%param:: =:%%"
		
		call set "check_websphere_portal_bin_path=%%param:websphere_portal_bin_path:=%%"
		
		if not !check_websphere_portal_bin_path! == !param! (
			call set "websphere_portal_bin_path=%%param:websphere_portal_bin_path:=%%"
		)
		
		call set "check_script_file_path=%%param:script_file_path:=%%"
		
		if not !check_script_file_path! == !param! (
			call set "script_file_path=%%param:script_file_path:=%%"
		)
		
		call set "check_username=%%param:username:=%%"
		
		if not !check_username! == !param! (
			call set "username=%%param:username:=%%"
		)
		
		call set "check_password=%%param:password:=%%"
				
		if not !check_password! == !param! (
			call set "password=%%param:password:=%%"
		)

		call set "check_cell_name=%%param:cell_name:=%%"
				
		if not !check_cell_name! == !param! (
			call set "cell_name=%%param:cell_name:=%%"
		)

		call set "check_node_name=%%param:node_name:=%%"
				
		if not !check_node_name! == !param! (
			call set "node_name=%%param:node_name:=%%"
		)
		
		call set "check_server_name=%%param:server_name:=%%"
				
		if not !check_server_name! == !param! (
			call set "server_name=%%param:server_name:=%%"
		)				
		
		call set "check_dataSource_conn_fail_email_sub_text=%%param:dataSource_conn_fail_email_sub_text:=%%"
				
		if not !check_dataSource_conn_fail_email_sub_text! == !param! (
			call set "dataSource_conn_fail_email_sub_text=%%param:dataSource_conn_fail_email_sub_text:=%%"
		)		
		
		call set "check_dataSource_conn_fail_email_body_text=%%param:dataSource_conn_fail_email_body_text:=%%"
				
		if not !check_dataSource_conn_fail_email_body_text! == !param! (
			call set "dataSource_conn_fail_email_body_text=%%param:dataSource_conn_fail_email_body_text:=%%"
		)			
)

call "%websphere_portal_bin_path%\wsadmin.bat" %server_name% -username %username% -password %password% -lang jython -f %script_file_path%\checkDSConnectivity.py %cell_name% %node_name%> "%script_file_path%\datasource_connect_status.txt"

for /F "usebackq delims=" %%a in (!datasource_connect_status_file_path!) do (
		call set "param=%%a"
		
		call set "check_data_source_connect_fail=%%param:data_source_connect_fail:=%%"
		
		if not !check_data_source_connect_fail! == !param! (
			call set "data_source_fail_name=%%param:data_source_connect_fail:=%%"

			call echo --Connection to provided datasource %%data_source_fail_name%% was not successful.--
			
			call set "bodyText=%%dataSource_conn_fail_email_body_text%% %%data_source_fail_name%%."

			call echo --Sending Email--
			cd ".."
			send_email.vbs "%dataSource_conn_fail_email_sub_text%" "!bodyText!"
			call echo --Email Sent--
		)
		
		call set "check_data_source_connect_success=%%param:data_source_connect_success:=%%"
		
		if not !check_data_source_connect_success! == !param! (
			call set "data_source_connect_success=%%param:data_source_connect_success:=%%"

			call echo --Connection to provided datasource %%data_source_connect_success%% was successful.--
		)
)

::call del "%script_file_path%\datasource_connect_status.txt"
PAUSE