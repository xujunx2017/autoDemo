@echo off
REM Simple remote repository setup
chcp 65001 >nul 2>&1

cd /d "%~dp0"

echo === autoDemo Remote Setup ===
echo.

echo 📋 Current Git Status:
git status --short
echo.

echo 🔗 Setting up remote repository...
echo.

:: Remove existing remote
git remote remove origin 2>nul

echo Please enter your GitHub username:
set /p username=Username: 
if "%username%"=="" (
    echo Username is required!
    pause
    exit /b 1
)

:: Set remote URL
git remote add origin https://github.com/%username%/autoDemo.git

echo.
echo 📤 Pushing to GitHub...
git branch -M main 2>nul
git push -u origin main

echo.
echo ✅ Setup complete!
echo Repository: https://github.com/%username%/autoDemo
echo.
echo 🎯 Next steps:
echo 1. Visit your repository on GitHub
echo 2. Check README.md for deployment guide
echo 3. Use deploy_to_huaweicloud.sh for cloud deployment
pause