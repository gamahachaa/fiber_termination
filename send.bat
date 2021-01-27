%1

@echo off

rem PREPARE DATESTAMP ------------------------------------------------------------------------------------------------------------------------------
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%%MM%%DD%_%HH%%Min%%Sec%"
rem DEFINE FILE NAMES ------------------------------------------------------------------------------------------------------------------------------
set serverFolderName=can
set mainScript=cantool
set oldScriptName=%mainScript%.js
set newScriptName=%mainScript%_%fullstamp%.js
set newMapName=%mainScript%_%fullstamp%.js.map
rem PREPARE and CLEAR OLD FILE removal  ------------------------------------------------------------------------------------------------------------------------------
set BINDIR=%cd%\export\html5\bin\
set ASSETSDIR=%BINDIR%\assets\

set FILESDELETE=%BINDIR%%mainScript%_20*
rem DELETE  ------------------------------------------------------------------------------------------------------------------------------
del /F %FILESDELETE%
rem REPLACE META LINK TO JS FILES  ------------------------------------------------------------------------------------------------------------------------------
powershell -Command "(gc %BINDIR%/index.html) -replace './%oldScriptName%', './%newScriptName%' | Out-File -encoding UTF8 %BINDIR%/index.html"
powershell -Command "(gc %BINDIR%/index.html) -replace 'background: #000000;', 'background: #4c4d4d;' | Out-File -encoding UTF8 %BINDIR%/index.html"
rem REENAME JS FILES  ------------------------------------------------------------------------------------------------------------------------------
powershell -Command "Rename-Item -Path "%BINDIR%/%mainScript%.js" -NewName %newScriptName%"
powershell -Command "Rename-Item -Path "%BINDIR%/%mainScript%.js.map" -NewName %newMapName%"

rem echo %1

if "%1"=="" goto :dead
if "%1"=="debug" goto :test
if "%1"=="release" goto :release
rem echo %1

:test

rem PUSH to TEST SERVER  ------------------------------------------------------------------------------------------------------------------------------
echo COPY

robocopy export\html5\bin "C:\xampp\htdocs\localhost" * /E

echo "robocopy localhost"

rem if "%1"=="debug" goto :dead

"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.193.14.13/ -hostkey=""ssh-rsa 2048 wS00k9P56QO60lm1NS8bO+nPtjNA0htnzu/XzCyhfQg=""" ^
    "lcd %BINDIR%\flixel" ^
    "cd /home/qook/app/qook/%serverFolderName%/flixel" ^
    "put -nopreservetime *" ^
    "exit"

"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.193.14.13/ -hostkey=""ssh-rsa 2048 wS00k9P56QO60lm1NS8bO+nPtjNA0htnzu/XzCyhfQg=""" ^
    "lcd %BINDIR%\manifest" ^
    "cd /home/qook/app/qook/%serverFolderName%/manifest" ^
    "put -nopreservetime *" ^
    "exit"

"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.193.14.13/ -hostkey=""ssh-rsa 2048 wS00k9P56QO60lm1NS8bO+nPtjNA0htnzu/XzCyhfQg=""" ^
    "lcd %BINDIR%\lib" ^
    "cd /home/qook/app/qook/%serverFolderName%/lib" ^
    "put -nopreservetime *" ^
    "exit"
rem delete old JS
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.193.14.13/ -hostkey=""ssh-rsa 2048 wS00k9P56QO60lm1NS8bO+nPtjNA0htnzu/XzCyhfQg=""" ^
    "cd /home/qook/app/qook/%serverFolderName%/" ^
    "rm *.js" ^
    "exit"
rem add new JS	
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.193.14.13/ -hostkey=""ssh-rsa 2048 wS00k9P56QO60lm1NS8bO+nPtjNA0htnzu/XzCyhfQg=""" ^
    "lcd %BINDIR%\" ^
    "cd /home/qook/app/qook/%serverFolderName%/" ^
    "put -nopreservetime *.js" ^
    "exit"
	
rem delete old JS MAP	
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.193.14.13/ -hostkey=""ssh-rsa 2048 wS00k9P56QO60lm1NS8bO+nPtjNA0htnzu/XzCyhfQg=""" ^
    "cd /home/qook/app/qook/%serverFolderName%" ^
    "rm *.js.map" ^
    "exit"
	
rem add new JS MAP	
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.193.14.13/ -hostkey=""ssh-rsa 2048 wS00k9P56QO60lm1NS8bO+nPtjNA0htnzu/XzCyhfQg=""" ^
    "lcd %BINDIR%" ^
    "cd /home/qook/app/qook/%serverFolderName%" ^
    "put -nopreservetime *.js.map" ^
    "exit"
rem ADD FONTS
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.193.14.13/ -hostkey=""ssh-rsa 2048 wS00k9P56QO60lm1NS8bO+nPtjNA0htnzu/XzCyhfQg=""" ^
    "lcd %ASSETSDIR%fonts" ^
    "cd /home/qook/app/qook/%serverFolderName%/assets/fonts" ^
    "put -nopreservetime *.ttf" ^
    "exit"
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.193.14.13/ -hostkey=""ssh-rsa 2048 wS00k9P56QO60lm1NS8bO+nPtjNA0htnzu/XzCyhfQg=""" ^
    "lcd %ASSETSDIR%fonts" ^
    "cd /home/qook/app/qook/%serverFolderName%/assets/fonts" ^
    "put -nopreservetime *.eot" ^
    "exit"
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.193.14.13/ -hostkey=""ssh-rsa 2048 wS00k9P56QO60lm1NS8bO+nPtjNA0htnzu/XzCyhfQg=""" ^
    "lcd %ASSETSDIR%fonts" ^
    "cd /home/qook/app/qook/%serverFolderName%/assets/fonts" ^
    "put -nopreservetime *.woff" ^
    "exit"
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.193.14.13/ -hostkey=""ssh-rsa 2048 wS00k9P56QO60lm1NS8bO+nPtjNA0htnzu/XzCyhfQg=""" ^
    "lcd %ASSETSDIR%fonts" ^
    "cd /home/qook/app/qook/%serverFolderName%/assets/fonts" ^
    "put -nopreservetime *.svg" ^
    "exit"
rem index
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.193.14.13/ -hostkey=""ssh-rsa 2048 wS00k9P56QO60lm1NS8bO+nPtjNA0htnzu/XzCyhfQg=""" ^
    "lcd %BINDIR%\" ^
    "cd /home/qook/app/qook/%serverFolderName%" ^
    "put -nopreservetime index.html" ^
    "exit"
goto :completed

:release


rem PUSH to PROD SERVER  ------------------------------------------------------------------------------------------------------------------------------
robocopy export\html5\bin "C:\xampp\htdocs\localhost" * /E

"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.192.14.13/ -hostkey=""ssh-rsa 2048 nqlUJZBRZk4+gCB8pRNrGcXJrx13iKLTftGfrXlqvk4=""" ^
    "lcd %BINDIR%\flixel" ^
    "cd /home/qook/app/entry_point_qook/%serverFolderName%/flixel" ^
    "put -nopreservetime *" ^
    "exit"

"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.192.14.13/ -hostkey=""ssh-rsa 2048 nqlUJZBRZk4+gCB8pRNrGcXJrx13iKLTftGfrXlqvk4=""" ^
    "lcd %BINDIR%\manifest" ^
    "cd /home/qook/app/entry_point_qook/%serverFolderName%/manifest" ^
    "put -nopreservetime *" ^
    "exit"

"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.192.14.13/ -hostkey=""ssh-rsa 2048 nqlUJZBRZk4+gCB8pRNrGcXJrx13iKLTftGfrXlqvk4=""" ^
    "lcd %BINDIR%\lib" ^
    "cd /home/qook/app/entry_point_qook/%serverFolderName%/lib" ^
    "put -nopreservetime *" ^
    "exit"
rem delete old JS
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.192.14.13/ -hostkey=""ssh-rsa 2048 nqlUJZBRZk4+gCB8pRNrGcXJrx13iKLTftGfrXlqvk4=""" ^
    "cd /home/qook/app/entry_point_qook/%serverFolderName%/" ^
    "rm *.js" ^
    "exit"
rem add new JS	
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.192.14.13/ -hostkey=""ssh-rsa 2048 nqlUJZBRZk4+gCB8pRNrGcXJrx13iKLTftGfrXlqvk4=""" ^
    "lcd %BINDIR%\" ^
    "cd /home/qook/app/entry_point_qook/%serverFolderName%/" ^
    "put -nopreservetime *.js" ^
    "exit"
	
rem delete old JS MAP	
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.192.14.13/ -hostkey=""ssh-rsa 2048 nqlUJZBRZk4+gCB8pRNrGcXJrx13iKLTftGfrXlqvk4=""" ^
    "cd /home/qook/app/entry_point_qook/%serverFolderName%" ^
    "rm *.js.map" ^
    "exit"
	
rem add new JS MAP	
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.192.14.13/ -hostkey=""ssh-rsa 2048 nqlUJZBRZk4+gCB8pRNrGcXJrx13iKLTftGfrXlqvk4=""" ^
    "lcd %BINDIR%" ^
    "cd /home/qook/app/entry_point_qook/%serverFolderName%" ^
    "put -nopreservetime *.js.map" ^
    "exit"
rem ADD FONTS
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.192.14.13/ -hostkey=""ssh-rsa 2048 nqlUJZBRZk4+gCB8pRNrGcXJrx13iKLTftGfrXlqvk4=""" ^
    "lcd %ASSETSDIR%fonts" ^
    "cd /home/qook/app/entry_point_qook/%serverFolderName%/assets/fonts" ^
    "put -nopreservetime *.ttf" ^
    "exit"
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.192.14.13/ -hostkey=""ssh-rsa 2048 nqlUJZBRZk4+gCB8pRNrGcXJrx13iKLTftGfrXlqvk4=""" ^
    "lcd %ASSETSDIR%fonts" ^
    "cd /home/qook/app/entry_point_qook/%serverFolderName%/assets/fonts" ^
    "put -nopreservetime *.eot" ^
    "exit"
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.192.14.13/ -hostkey=""ssh-rsa 2048 nqlUJZBRZk4+gCB8pRNrGcXJrx13iKLTftGfrXlqvk4=""" ^
    "lcd %ASSETSDIR%fonts" ^
    "cd /home/qook/app/entry_point_qook/%serverFolderName%/assets/fonts" ^
    "put -nopreservetime *.woff" ^
    "exit"
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.192.14.13/ -hostkey=""ssh-rsa 2048 nqlUJZBRZk4+gCB8pRNrGcXJrx13iKLTftGfrXlqvk4=""" ^
    "lcd %ASSETSDIR%fonts" ^
    "cd /home/qook/app/entry_point_qook/%serverFolderName%/assets/fonts" ^
    "put -nopreservetime *.svg" ^
    "exit"
rem index
"C:\_mesProgs\WinSCP\WinSCP.com" ^
  /log="%cd%\WinSCP.log" /ini=nul ^
  /command ^
    "open sftp://qook:uU155cy54IGQf0M4Jek6@10.192.14.13/ -hostkey=""ssh-rsa 2048 nqlUJZBRZk4+gCB8pRNrGcXJrx13iKLTftGfrXlqvk4=""" ^
    "lcd %BINDIR%\" ^
    "cd /home/qook/app/entry_point_qook/%serverFolderName%" ^
    "put -nopreservetime index.html" ^
    "exit"
goto :completed

:end
echo "JUST DEBUGGING"
:dead
echo "NO DIRECTIVES"

:completed

echo "completed "%1