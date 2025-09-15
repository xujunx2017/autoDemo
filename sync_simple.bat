@echo off
setlocal enabledelayedexpansion

echo Starting auto-sync...

REM Check Git status
git status --porcelain > temp.txt
set /p changes=<temp.txt
del temp.txt

if "%changes%"=="" (
    echo No changes to commit
) else (
    echo Changes detected, committing...
    git add .
    git commit -m "Auto sync %date% %time%"
    echo Changes committed
)

echo Pushing to GitHub...
git push origin main
if %errorlevel% neq 0 (
    echo Push failed - check internet connection
    pause
    exit /b 1
)

echo Sync completed successfully!
echo.
echo Next: Run on Huawei Cloud server:
echo   git pull origin main
echo   bash update_from_github.sh
pause