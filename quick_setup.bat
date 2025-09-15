@echo off
echo 正在设置autoDemo项目...
echo.

cd /d "%~dp0"

echo 检查Git安装...
git --version >nul 2>&1 || (
    echo 请先安装Git：https://git-scm.com/downloads
    pause
    exit /b 1
)

echo 当前状态：
git status
echo.

echo 要设置远程仓库，请按以下步骤：
echo 1. 在GitHub/Gitee创建仓库：autoDemo
echo 2. 复制仓库URL
echo 3. 运行以下命令：
echo.
echo 示例：
echo git remote add origin https://github.com/用户名/autoDemo.git
echo git branch -M main
echo git push -u origin main
echo.

pause