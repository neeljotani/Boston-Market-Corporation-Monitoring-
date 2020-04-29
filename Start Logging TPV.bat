cd %~dp0

set "file=Start_Logging_TPV.properties"

setlocal ENABLEDELAYEDEXPANSION

for /F "usebackq delims=" %%a in (!file!) do (
		call set "param=%%a"
		
		call set "param=%%param:: =:%%"

		call set "check_drive_name=%%param:drive_name:=%%"
		
		if not !check_drive_name! == !param! (
			call set "drive_name=%%param:drive_name:=%%"
		)		
		
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
		
		call set "check_server_name=%%param:server_name:=%%"
				
		if not !check_server_name! == !param! (
			call set "server_name=%%param:server_name:=%%"
		)	

		call set "check_node_name=%%param:node_name:=%%"
				
		if not !check_node_name! == !param! (
			call set "node_name=%%param:node_name:=%%"
		)

		call set "check_log_file_name=%%param:log_file_name:=%%"
				
		if not !check_log_file_name! == !param! (
			call set "log_file_name=%%param:log_file_name:=%%"
		)

		call set "check_refresh_rate=%%param:refresh_rate:=%%"
				
		if not !check_refresh_rate! == !param! (
			call set "refresh_rate=%%param:refresh_rate:=%%"
		)

		call set "check_buffer_size=%%param:buffer_size:=%%"
				
		if not !check_buffer_size! == !param! (
			call set "buffer_size=%%param:buffer_size:=%%"
		)

		call set "check_max_log_files=%%param:max_log_files:=%%"
				
		if not !check_max_log_files! == !param! (
			call set "max_log_files=%%param:max_log_files:=%%"
		)

		call set "check_log_file_size=%%param:log_file_size:=%%"
				
		if not !check_log_file_size! == !param! (
			call set "log_file_size=%%param:log_file_size:=%%"
		)

		call set "check_logging_duration=%%param:logging_duration:=%%"
				
		if not !check_logging_duration! == !param! (
			call set "logging_duration=%%param:logging_duration:=%%"
		)

		call set "check_log_file_format=%%param:log_file_format:=%%"
				
		if not !check_log_file_format! == !param! (
			call set "log_file_format=%%param:log_file_format:=%%"
		)		
)

call "%websphere_portal_bin_path%\wsadmin.bat" "%server_name%" -username %username% -password %password% -lang jython -f %script_file_path%\LoggingTPV.py "%server_name%" "%username%" "%node_name%" "%log_file_name%" %refresh_rate% %buffer_size% %max_log_files% %log_file_size% %logging_duration% "%log_file_format%" "start"
