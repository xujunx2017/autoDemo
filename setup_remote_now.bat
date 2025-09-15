@echo off
REM Quick remote repository setup
chcp 65001 >nul 2>&1

cd /d "%~dp0"

echo === Remote Repository Setup ===
echo.

:: Remove existing remote
git remote remove origin 2>nul
echo Removed existing remote (if any)

echo.
echo Please select your platform:
echo 1. GitHub
echo 2. Gitee
echo 3. Huawei Cloud CodeHub
echo 4. Other
echo.

set /p platform=Enter your choice (1-4): 
set /p username=Enter your username: 

if "%platform%"=="1" (
    set remote_url=https://github.com/%username%/autoDemo.git
) else if "%platform%"=="2" (
    set remote_url=https://gitee.com/%username%/autoDemo.git
) else if "%platform%"=="3" (
    set remote_url=https://codehub.devcloud.cn-north-4.huaweicloud.com/%username%/autoDemo.git
) else (
    set /p remote_url=Enter full repository URL: 
)

echo.
echo Setting remote to: %remote_url%
git remote add origin %remote_url%

echo.
echo Pushing to remote repository...
git branch -M main
git push -u origin main

echo.
echo Setup complete!
echo Repository URL: %remote_url%
pause