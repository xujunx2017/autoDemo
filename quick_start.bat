@echo off
REM autoDemo Quick Start - Windows Batch Script
chcp 65001 >nul 2>&1
title autoDemo Git Setup

echo ================================================
echo    autoDemo Git Setup Wizard
echo ================================================
echo.

REM Change to script directory
cd /d "%~dp0"
echo Current directory: %CD%
echo.

REM Check Git installation
git --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Git is not installed!
    echo Please install Git from: https://git-scm.com/downloads
    echo Then run this script again.
    pause
    exit /b 1
)

echo [OK] Git is installed
echo.

REM Show current Git status
echo Current Git Status:
git status
echo.

REM Check remote repositories
echo Remote repositories:
git remote -v
echo.

REM Simple instructions
echo To setup remote repository:
echo 1. Create a repository on GitHub/Gitee with name "autoDemo"
echo 2. Copy the repository URL
echo 3. Run these commands:
echo.
echo Example for GitHub:
echo git remote add origin https://github.com/YOUR_USERNAME/autoDemo.git
echo git branch -M main
echo git push -u origin main
echo.
echo Example for Gitee:
echo git remote add origin https://gitee.com/YOUR_USERNAME/autoDemo.git
echo git branch -M main
echo git push -u origin main
echo.

echo Press any key to continue...
pause