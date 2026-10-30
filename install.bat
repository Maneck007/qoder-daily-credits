@echo off
rem Launcher only - all logic lives in install-helper.ps1 (Unicode-safe).
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install-helper.ps1"
echo.
pause
