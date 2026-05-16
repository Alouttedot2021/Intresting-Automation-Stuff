@echo off
REM ------------------------------------------------------------
REM Microsoft temporary workaround for Win11 24H2 / 25H2
REM Creates FeatureManagement override to disable enforcement
REM ------------------------------------------------------------

REM Create registry path and set DWORD value
reg add "HKLM\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" ^
 /v 1517186191 /t REG_DWORD /d 0 /f

IF %ERRORLEVEL% EQU 0 (
    echo Registry key applied successfully.
) ELSE (
    echo Failed to apply registry key.
)

echo.
echo A system reboot is REQUIRED for changes to take effect.
pause