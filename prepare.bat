@echo off
echo %1
echo %2
set BINDIR=%2\export\html5\bin

echo %BINDIR%

powershell -Command "git --git-dir=%BINDIR%\.git --work-tree=%BINDIR% add ."

if %1%==debug (
    goto :dev
) else (
	goto :master
)

:master

powershell -Command "git --git-dir=%BINDIR%\.git --work-tree=%BINDIR% commit -m cleaning_for_prod"
powershell -Command "git --git-dir=%BINDIR%\.git --work-tree=%BINDIR% push origin dev"
powershell -Command "git --git-dir=%BINDIR%\.git --work-tree=%BINDIR% checkout master"

echo "PREPARE PROD PUSHED DEV"

goto :end

:dev

powershell -Command "git --git-dir=%BINDIR%\.git --work-tree=%BINDIR% commit -m cleaning_for_test"
powershell -Command "git --git-dir=%BINDIR%\.git --work-tree=%BINDIR% push origin dev"
powershell -Command "git --git-dir=%BINDIR%\.git --work-tree=%BINDIR% checkout dev"
echo "PREPARE DEV COMMITED MASTER"

goto :end

:end
echo "PREPARE END"