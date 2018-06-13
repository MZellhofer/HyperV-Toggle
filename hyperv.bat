@ECHO OFF

FOR /F "tokens=2" %%a in ('bcdedit /enum ^| find /i "hypervisorlaunchtype"') do set $CURRENT_LAUNCHTYPE=%%a
ECHO Welcome! Hypervisor Launch Type is set to [%$CURRENT_LAUNCHTYPE%] at the moment.
ECHO.

choice /C DAVO /M "Do you want to set up Hypervisor Launch Type for [D]ocker/[A]uto or [V]MWare/[O]ff?" /N
ECHO.

IF "%ERRORLEVEL%" == "1" SET LAUNCHTYPE=Auto
IF "%ERRORLEVEL%" == "2" SET LAUNCHTYPE=Auto
IF "%ERRORLEVEL%" == "3" SET LAUNCHTYPE=Off
IF "%ERRORLEVEL%" == "4" SET LAUNCHTYPE=Off
IF "%$CURRENT_LAUNCHTYPE%" == "%LAUNCHTYPE%" GOTO unchanged

ECHO Setting Hypervisor Launch Type to [%LAUNCHTYPE%]
bcdedit /set hypervisorlaunchtype %LAUNCHTYPE%
ECHO.

ECHO Note: Changed Hypervisor Launch Type only take effect after a restart!
choice /C YN /M "Do you want to reboot computer in order to activate the new Hypervisor Launch Type setting [Y/N]?" /N
ECHO.
IF "%ERRORLEVEL%" == "1" GOTO reboot
IF "%ERRORLEVEL%" == "2" GOTO end

:reboot
shutdown /r /t 0
goto end

:unchanged
ECHO Hypervisor Launch Type will remain unchanged [%LAUNCHTYPE%], no need to reboot.
ECHO.
goto end

:end
ECHO Have a nice day!
SET LAUNCHTYPE=
SET $CURRENT_LAUNCHTYPE=
