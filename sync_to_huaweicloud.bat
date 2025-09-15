@echo off
chcp 65001
setlocal enabledelayedexpansion

echo 🔄 自动同步代码到华为云...
echo.

REM 检查是否在Git仓库中
git rev-parse --git-dir >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 当前目录不是Git仓库
    echo 💡 请确保在 autoDemo 目录下运行
    pause
    exit /b 1
)

REM 检查是否有未提交的更改
git status --porcelain | findstr /r /c:"." >nul
if %errorlevel% equ 0 (
    echo 📋 发现未提交的更改，正在提交...
    git add .
    git commit -m "Auto sync: %date% %time%"
    echo ✅ 本地更改已提交
) else (
    echo ✅ 没有新的更改需要提交
)

REM 推送到远程仓库
echo 🚀 推送到GitHub...
git push origin main
if %errorlevel% neq 0 (
    echo ❌ 推送到GitHub失败
    pause
    exit /b 1
)

echo ✅ 代码已同步到GitHub

echo.
echo 🌩️ 接下来请在华为云服务器上运行以下命令：
echo.
echo ssh 用户名@华为云IP地址
echo cd /path/to/autoDemo
echo git pull origin main
echo.
echo 或者运行华为云上的自动更新脚本
echo bash update_from_github.sh
echo.

pause