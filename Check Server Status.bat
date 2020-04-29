cd %~dp0

set "file=check_server_status.properties"

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

		call set "check_server_name=%%param:server_name:=%%"
				
		if not !check_server_name! == !param! (
			call set "server_name=%%param:server_name:=%%"
		)				
		
		call set "check_server_stop_email_sub_text=%%param:server_stop_email_sub_text:=%%"
				
		if not !check_server_stop_email_sub_text! == !param! (
			call "set server_stop_email_sub_text=%%param:server_stop_email_sub_text:=%%"
		)		
		
		call set "check_server_stop_email_body_text=%%param:server_stop_email_body_text:=%%"
				
		if not !check_server_stop_email_body_text! == !param! (
			call set "server_stop_email_body_text=%%param:server_stop_email_body_text:=%%"
		)		
)

call "%websphere_portal_bin_path%\serverStatus.bat" %server_name% -username %username% -password %password% > "%script_file_path%\server_status.txt"

set /A "isServerStart=2"

find "ADMU0508I" "%script_file_path%\server_status.txt" >nul
if %errorlevel% equ 0 call set isServerStart=1

find "ADMU0509I" "%script_file_path%\server_status.txt" >nul
if %errorlevel% equ 0 call set isServerStart=0

::call del "%script_file_path%\server_status.txt"

if  %isServerStart% equ 1 (
    call echo ---server is down---
	
	call echo ---Sending Email---
	cd ".."
	send_email.vbs "%server_stop_email_sub_text%" "%server_stop_email_body_text%"
	call echo ---Email Sent---
	
	call echo ---Server Starting---
	call "%websphere_portal_bin_path%\startServer.bat" %server_name%
	call echo ---Server Started---
) else (
	call echo ---server is up---
)