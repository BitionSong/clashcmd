@echo off
chcp 936>nul
>NUL 2>&1 REG.exe query "HKU\S-1-5-19" || (
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "%*", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
    Exit /b
)

:init
title ��� Clash ��������
cd /d "%~dp0"
setlocal enabledelayedexpansion

:startup_menu
call misc.bat :arrinit "startup_options"
call misc.bat :arrappend "startup_options" "��ӿ�������"
call misc.bat :arrappend "startup_options" "ɾ����������"
call misc.bat :arrappend "startup_options" "�ر�"
call misc.bat :makemenu "- ��������" "startup_options" "EDX" "��ѡ��"
if "!selection!" == "E" (
  call :add-startup
  goto startup_menu
)
if "!selection!" == "D" (
  call :del-startup
  goto startup_menu
)
goto :eof

:add-startup
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "clash-web" /t REG_SZ /d "\"%~DP0start-clash.vbs\"" /f
echo ��ӳɹ���
call misc.bat :sleep 2000
goto :eof

:del-startup
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "clash-web"  /f>NUL 2>NUL
echo ɾ���ɹ���
call misc.bat :sleep 2000
goto :eof
