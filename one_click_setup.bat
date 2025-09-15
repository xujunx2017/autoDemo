@echo off
REM One-click setup for autoDemo
chcp 65001 >nul 2>&1

:: Change to script directory
cd /d "%~dp0"

echo === autoDemo One-Click Setup ===
echo.

:: Check Git
git --version >nul 2>&1 || (
    echo Please install Git first: https://git-scm.com/downloads
    pause
    exit /b 1
)

:: Show current status
echo Current status:
git status --short
echo.

:: Check if remote exists
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    echo No remote repository configured.
    echo.
    echo To setup:
    echo 1. Create repository on GitHub/Gitee named "autoDemo"
    echo 2. Run: git remote add origin YOUR_REPO_URL
    echo 3. Run: git push -u origin main
) else (
    echo Remote repository already configured:
    git remote -v
    echo.
    echo To push changes:
    echo git push origin main
)

echo.
echo Press any key to exit...
pause