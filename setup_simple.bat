@echo off
REM 简化版Git设置脚本 - 解决Windows双击运行问题
title autoDemo Git设置向导

echo =================================================
echo    autoDemo Git仓库设置向导
echo =================================================
echo.

REM 检查是否在正确目录
cd /d "%~dp0"
echo 当前目录: %CD%
echo.

REM 检查Git是否安装
git --version >nul 2>&1
if errorlevel 1 (
    echo 错误: 未检测到Git！
    echo.
    echo 请按以下步骤操作：
    echo 1. 访问 https://git-scm.com/downloads
    echo 2. 下载并安装Git
    echo 3. 安装完成后重新运行此脚本
    echo.
    pause
    exit /b 1
)

echo ✅ Git已安装
echo.

REM 显示当前Git状态
echo 📋 当前Git状态：
git status
echo.

REM 检查是否已有远程仓库
git remote -v
echo.

REM 提供选项
echo 请选择操作：
echo 1. 设置GitHub仓库
echo 2. 设置Gitee仓库
echo 3. 设置华为云CodeHub
echo 4. 设置其他仓库
echo 5. 仅查看当前状态
echo.

set /p choice=请输入选项(1-5): 

if "%choice%"=="1" (
    call :setup_repo "GitHub" "github.com"
) else if "%choice%"=="2" (
    call :setup_repo "Gitee" "gitee.com"
) else if "%choice%"=="3" (
    call :setup_codehub
) else if "%choice%"=="4" (
    call :setup_custom
) else if "%choice%"=="5" (
    echo ✅ 操作完成！
    pause
    exit /b 0
) else (
    echo ❌ 无效选项
    pause
    exit /b 1
)

goto :end

:setup_repo
echo.
echo 📝 %~1仓库设置
echo 请先在%~1创建仓库：
echo   仓库名称: autoDemo
echo   创建地址: https://%~2/new
echo.
set /p username=请输入%~1用户名: 
if "%username%"=="" (
    echo ❌ 用户名不能为空
    pause
    exit /b 1
)
set remote_url=https://%~2/%username%/autoDemo.git
goto :setup_remote

:setup_codehub
echo.
echo 📝 华为云CodeHub设置
echo 请先在华为云CodeHub创建仓库
echo.
set /p remote_url=请输入CodeHub仓库URL: 
if "%remote_url%"=="" (
    echo ❌ URL不能为空
    pause
    exit /b 1
)
goto :setup_remote

:setup_custom
echo.
echo 📝 自定义仓库设置
set /p remote_url=请输入仓库URL: 
if "%remote_url%"=="" (
    echo ❌ URL不能为空
    pause
    exit /b 1
)
goto :setup_remote

:setup_remote
echo.
echo 🔗 配置远程仓库...
git remote remove origin 2>nul
git remote add origin %remote_url%
echo.
echo 📤 推送代码...
git branch -M main 2>nul
git push -u origin main
echo.
echo ✅ 配置完成！
echo 仓库地址: %remote_url%
echo.
echo 📚 下一步：
echo 1. 在华为云服务器上运行：
echo    git clone %remote_url%
echo    cd autoDemo
echo    bash deploy_to_huaweicloud.sh
echo.
pause
goto :end

:end
echo.
echo 按任意键退出...