@echo off
setlocal enabledelayedexpansion

echo ================================
echo    Auto Sync to GitHub
echo ================================
echo.

REM 确保在正确的目录
cd /d "%~dp0"
echo Running from: %cd%
echo.

REM 检查Git是否安装
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Git is not installed
    echo Please install Git from: https://git-scm.com/
    pause
    exit /b 1
)

echo Git version:
git --version
echo.

REM 检查是否在Git仓库
git rev-parse --git-dir >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Not in a Git repository
    echo Please run this in your autoDemo folder
    pause
    exit /b 1
)

REM 显示当前状态
echo Current Git status:
git status --short
echo.

REM 检查是否有更改
git diff --quiet
if %errorlevel% neq 0 (
    echo Found changes, adding and committing...
    git add .
    git commit -m "Auto sync: %date% %time%"
    echo Changes committed
) else (
    echo No changes to commit
)
echo.

REM 推送到GitHub
echo Pushing to GitHub...
git push origin main

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Push failed!
    echo.
    echo Possible solutions:
    echo 1. Check internet connection
    echo 2. Verify GitHub login: git config --global user.name
    echo 3. Check remote: git remote -v
    echo.
    pause
    exit /b 1
)

echo.
echo SUCCESS: Code synced to GitHub!
echo.
echo Next steps for Huawei Cloud:
echo 1. SSH: ssh username@server-ip
echo 2. Update: git pull origin main
echo 3. Or run: bash update_from_github.sh
echo.
echo Press any key to close...
pause