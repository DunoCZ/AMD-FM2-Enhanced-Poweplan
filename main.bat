@ECHO OFF
setlocal
powershell -Command "[guid]::NewGuid().ToString()">guuid.txt
SET /P curtempguuid=<%cd%\guuid.txt
SET curtempdir=%cd%\powerplan.pow
:MAIN
cls
echo ################################################################################
echo #                                                                              #
echo #                          Welcome to this ugly installer                      #
echo #                                                                              #
echo ################################################################################
echo.
echo Did you read 'readme.md' of repo you downloaded this exe from?
choice /m "If not, do you wanna read it now "
if %errorlevel% equ 1 goto OPENREADME
if %errorlevel% equ 2 goto PREINSTALL
goto MAIN


:OPENREADME
cls
echo ################################################################################
echo #                                                                              #
echo #                          Welcome to this ugly installer                      #
echo #                                                                              #
echo ################################################################################
echo. 
echo Opening it...
start /B https://github.com/DunoCZ/AMD-FM2-Enhanced-Poweplan
choice /m "Can we continue now "
if %errorlevel% equ 1 goto PREINSTALL
if %errorlevel% equ 2 goto END
goto MAIN


:PREINSTALL
cls
echo ################################################################################
echo #                                                                              #
echo #                          Welcome to this ugly installer                      #
echo #                                                                              #
echo ################################################################################
echo.
choice /m "Do you wanna install this power plan and also activate it "
if %errorlevel% equ 1 goto INSTALL
if %errorlevel% equ 2 goto END
goto PREINSTALL


:INSTALL
echo %cd%
echo.
echo.Installing powerplan...
powercfg /import "%curtempdir%" %curtempguuid%>import.log 
echo.
echo.Activating powerplan...
powercfg /setactive "%curtempguuid%">setactive.log
goto LOGS

:LOGS
echo.
choice /m "Do you wanna see logs "
if %errorlevel% equ 1 goto LOGSYES
if %errorlevel% equ 2 goto END
goto LOGS

:LOGSYES
echo Opening them...
start /B notepad %cd%\import.log
start /B notepad %cd%\setactive.log
goto END



:END
echo.
echo We are done then :)
pause