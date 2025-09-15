@echo off
REM autoDemo Git仓库设置和华为云部署向导 - Windows版本
title autoDemo Git设置向导
cd /d "%~dp0"

echo =================================================
echo    autoDemo Git仓库设置和华为云部署向导
echo =================================================

REM 检查Git是否安装
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git未安装，请先安装Git
    pause
    exit /b 1
)

echo 📋 当前Git状态：
git status

echo.
echo 📝 请选择远程仓库平台：
echo 1) GitHub
echo 2) Gitee
echo 3) 华为云CodeHub
echo 4) 已有远程仓库
set /p choice=请输入选项 (1-4): 

if "%choice%"=="1" (
    echo 📝 请在GitHub创建仓库：https://github.com/new
    echo 仓库名称：autoDemo
    set /p username=请输入GitHub用户名: 
    set remote_url=https://github.com/%username%/autoDemo.git
) else if "%choice%"=="2" (
    echo 📝 请在Gitee创建仓库：https://gitee.com/projects/new
    echo 仓库名称：autoDemo
    set /p username=请输入Gitee用户名: 
    set remote_url=https://gitee.com/%username%/autoDemo.git
) else if "%choice%"=="3" (
    echo 📝 请在华为云CodeHub创建仓库
    set /p remote_url=请输入华为云CodeHub仓库URL: 
) else if "%choice%"=="4" (
    set /p remote_url=请输入已有仓库URL: 
) else (
    echo ❌ 无效选项
    pause
    exit /b 1
)

echo.
echo 🔗 配置远程仓库...
git remote add origin %remote_url% 2>nul || git remote set-url origin %remote_url%

echo 📤 推送代码到远程仓库...
git branch -M main
git push -u origin main

echo.
echo ✅ Git仓库配置完成！
echo 远程仓库地址: %remote_url%

echo.
echo 🎯 华为云部署命令：
echo 在华为云服务器上运行：
echo git clone %remote_url%
echo cd autoDemo
echo bash deploy_to_huaweicloud.sh

echo.
echo 📚 查看帮助文档：
echo - HUAWEICLOUD_DEPLOY.md - 详细部署指南
echo - GIT_SETUP_GUIDE.md - Git设置指南
echo - DEPLOYMENT_SUMMARY.md - 部署总结
pause