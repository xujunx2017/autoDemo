@echo off
setlocal enabledelayedexpansion

echo ================================
echo    Auto Sync Debug Mode
echo ================================
echo.

REM 设置窗口标题
title Auto Sync to GitHub

REM 显示当前路径
echo Current directory: %cd%
echo.

REM 检查Git是否安装
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed or not in PATH
    echo Please install Git from: https://git-scm.com/
    pause
    exit /b 1
)
echo [SUCCESS] Git is available
git --version
echo.

REM 检查是否在Git仓库
git rev-parse --git-dir >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Not in a Git repository
    echo [SOLUTION] Please navigate to your autoDemo folder first
    echo Current folder: %cd%
    pause
    exit /b 1
)

echo [SUCCESS] In Git repository: %cd%
echo.

REM 显示远程仓库信息
echo [INFO] Remote repositories:
git remote -v
echo.

REM 显示当前分支
echo [INFO] Current branch:
git branch --show-current
echo.

REM 显示当前状态
echo [INFO] Current status:
git status --short
if %errorlevel% neq 0 (
    echo [ERROR] Failed to get Git status
    pause
    exit /b 1
)
echo.

REM 询问用户是否继续
set /p continue=Do you want to continue with sync? (y/n): 
if /i "%continue%" neq "y" (
    echo Sync cancelled by user
    pause
    exit /b 0
)

REM 检查是否有未提交的更改
git status --porcelain > temp.txt 2>&1
set /p changes=<temp.txt
del temp.txt

if "%changes%"=="" (
    echo [INFO] No new changes to commit
) else (
    echo [ACTION] Found changes, showing details:
    git status --short
    echo.
    
    echo [ACTION] Adding changes...
    git add .
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to add changes
        pause
        exit /b 1
    )
    
    echo [ACTION] Committing changes...
    git commit -m "Auto sync %date% %time%"
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to commit changes
        pause
        exit /b 1
    )
    echo [SUCCESS] Changes committed
)
echo.

REM 推送到GitHub
echo [ACTION] Pushing to GitHub...
git push origin main 2>&1

if %errorlevel% neq 0 (
    echo [ERROR] Push failed!
    echo.
    echo [TROUBLESHOOTING]:
    echo 1. Check your internet connection
    echo 2. Verify GitHub credentials:
    echo    - git config --global user.name
    echo    - git config --global user.email
    echo 3. Test GitHub access:
    echo    - git remote -v
    echo    - git push --dry-run origin main
    pause
    exit /b 1
)

echo [SUCCESS] Sync completed successfully!
echo.
echo ================================
echo    Next Steps for Huawei Cloud
echo ================================
echo.
echo 1. Connect to your Huawei Cloud server:
echo    ssh username@your-server-ip
echo.
echo 2. Update the code:
echo    cd /path/to/autoDemo
echo    git pull origin main
echo.
echo 3. Or use the auto-update script:
echo    bash update_from_github.sh
echo.
echo.
echo Press any key to exit...
pause >nul