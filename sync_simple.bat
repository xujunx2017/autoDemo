@echo off
setlocal enabledelayedexpansion

echo ================================
echo    Auto Sync to GitHub
echo ================================
echo.

REM 检查是否在Git仓库目录
git rev-parse --git-dir >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Not in a Git repository
    echo Please run this script in the autoDemo folder
    echo.
    pause
    exit /b 1
)

REM 显示当前状态
echo Checking current status...
git status --short
echo.

REM 检查是否有未提交的更改
git status --porcelain > temp.txt
set /p changes=<temp.txt
del temp.txt

if "%changes%"=="" (
    echo [INFO] No new changes to commit
) else (
    echo [ACTION] Found changes, preparing to commit...
    git add .
    git commit -m "Auto sync %date% %time%"
    echo [SUCCESS] Changes committed
)
echo.

REM 推送到GitHub
echo [ACTION] Pushing to GitHub...
git push origin main

if %errorlevel% neq 0 (
    echo [ERROR] Push failed!
    echo Possible reasons:
    echo 1. No internet connection
    echo 2. GitHub authentication issues
    echo 3. Repository access problems
    echo.
    echo [SOLUTION] Check your connection and try again
    pause
    exit /b 1
)

echo [SUCCESS] Code synced to GitHub successfully!
echo.
echo ================================
echo    Next Steps for Huawei Cloud
echo ================================
echo.
echo 1. SSH to your Huawei Cloud server:
echo    ssh username@your-server-ip
echo.
echo 2. Navigate to project directory:
echo    cd /path/to/autoDemo
echo.
echo 3. Update from GitHub:
echo    git pull origin main
echo.
echo 4. Or run the update script:
echo    bash update_from_github.sh
echo.
echo Press any key to exit...
pause >nul