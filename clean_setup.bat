@echo off
REM Clean setup script for autoDemo
chcp 65001 >nul 2>&1

cd /d "%~dp0"

echo === autoDemo Clean Setup ===
echo.

:: Display current Git status
echo Current Git Status:
git status
echo.

:: Display current remotes
echo Current Remote Repositories:
git remote -v
echo.

:: Simple commands for manual setup
echo Ready to setup your repository!
echo.
echo Commands to run manually:
echo.
echo 1. Remove existing remote (if any):
echo    git remote remove origin
echo.
echo 2. Add your repository:
echo    For GitHub:
echo    git remote add origin https://github.com/YOUR_USERNAME/autoDemo.git
echo.
echo    For Gitee:
echo    git remote add origin https://gitee.com/YOUR_USERNAME/autoDemo.git
echo.
echo 3. Push to repository:
echo    git branch -M main
echo    git push -u origin main
echo.
echo Copy and paste these commands as needed!

pause