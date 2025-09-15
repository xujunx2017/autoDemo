@echo off
REM Fix remote repository issues
chcp 65001 >nul 2>&1
title Fix Git Remote Issues

cd /d "%~dp0"

echo ================================================
echo    Fixing Git Remote Issues
echo ================================================
echo.

REM Check current remotes
echo Current remotes:
git remote -v
echo.

REM Remove existing origin if it exists
git remote remove origin 2>nul
if errorlevel 1 (
    echo No existing remote to remove
) else (
    echo Removed existing remote origin
)
echo.

REM Simple setup menu
echo Select your repository platform:
echo 1. GitHub
echo 2. Gitee  
echo 3. Huawei Cloud CodeHub
echo 4. Enter custom URL
echo.

set /p choice=Enter choice (1-4): 

if "%choice%"=="1" (
    set /p username=Enter GitHub username: 
    set remote_url=https://github.com/%username%/autoDemo.git
) else if "%choice%"=="2" (
    set /p username=Enter Gitee username: 
    set remote_url=https://gitee.com/%username%/autoDemo.git
) else if "%choice%"=="3" (
    set /p remote_url=Enter Huawei Cloud CodeHub URL: 
) else if "%choice%"=="4" (
    set /p remote_url=Enter repository URL: 
) else (
    echo Invalid choice
    pause
    exit /b 1
)

echo.
echo Setting remote to: %remote_url%
git remote add origin %remote_url%

echo.
echo Testing connection...
git remote -v

echo.
echo To push your code, run:
echo git branch -M main
echo git push -u origin main
echo.
pause