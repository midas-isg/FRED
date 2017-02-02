@echo off
cd %~dp0%..

set CYGWIN_HOME=C:\cygwin64
call :HAS_CYG

set CYGWIN=winsymlinks:native
set FRED_HOME=%cd%
set FRED_GNUPLOT=%CYGWIN_HOME%\bin\gnuplot;
PATH=%PATH%;%CYGWIN_HOME%\bin;%FRED_HOME%\bin;
for /f "delims=" %%i in ('cygpath -u %FRED_HOME%') do set FRED_HOME=%%i
for /f "delims=" %%i in ('cygpath -u %FRED_GNUPLOT%') do set FRED_GNUPLOT=%%i

perl bin\fred_help

bash.exe --login symlink_fix.bsh
tcsh
goto EOF

:: FUNCTION DEFINITIONS
:GET_CYG
	set /p CYGWIN_HOME=Please enter the installation directory of CYGWIN: 
	call :HAS_CYG
exit /b

:HAS_CYG
	if not exist %CYGWIN_HOME%\bin\mintty.exe (
		echo on
		echo Could not find %CYGWIN_HOME%\bin\mintty.exe
		echo off
		call :GET_CYG
	)
exit /b
:: END OF FUNCTION DEFINITIONS

:EOF
@echo on
