@echo off
chcp 65001
setlocal enabledelayedexpansion

echo Starting automatic sync to Huawei Cloud...
echo.

REM Check if in Git repository
git rev-parse --git-dir >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Not in a Git repository
    echo Please ensure you are in the autoDemo directory
    pause
    exit /b 1
)

REM Check for uncommitted changes
git status --porcelain | findstr /r /c:"." >nul
if %errorlevel% equ 0 (
    echo Found uncommitted changes, committing...
    git add .
    git commit -m "Auto sync: %date% %time%"
    echo Local changes committed successfully
) else (
    echo No new changes to commit
)

REM Push to remote repository
echo Pushing to GitHub...
git push origin main
if %errorlevel% neq 0 (
    echo ERROR: Failed to push to GitHub
    pause
    exit /b 1
)

echo Code has been synced to GitHub successfully

echo.
echo Next steps on Huawei Cloud server:
echo.
echo ssh username@huawei-cloud-ip
echo cd /path/to/autoDemo
echo git pull origin main
echo.
echo Or run the auto-update script on Huawei Cloud:
echo bash update_from_github.sh
echo.

pause