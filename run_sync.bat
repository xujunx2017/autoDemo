@echo off
REM 双击运行同步脚本
REM 使用PowerShell运行，避免CMD限制

echo Starting sync process...

REM 检查PowerShell是否可用
powershell -Command "Get-Host" >nul 2>&1
if %errorlevel% neq 0 (
    echo PowerShell not found, using CMD...
    cd /d "%~dp0"
    call sync_now.bat
) else (
    echo Running PowerShell version...
    powershell -ExecutionPolicy Bypass -File "%~dp0sync_now.ps1"
)

pause