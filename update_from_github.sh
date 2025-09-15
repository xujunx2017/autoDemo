#!/bin/bash

# 华为云服务器自动更新脚本
# 放置在华为云服务器上运行

set -e

echo "🔄 从GitHub拉取最新代码..."

# 检查是否在项目目录中
if [ ! -f "manage.py" ]; then
    echo "❌ 请在 autoDemo 目录下运行此脚本"
    exit 1
fi

# 拉取最新代码
echo "📥 拉取最新代码..."
git pull origin main

# 检查是否有更新
if [ $? -eq 0 ]; then
    echo "✅ 代码已更新到最新版本"
    
    # 更新依赖（如果有requirements.txt变更）
    echo "📦 检查依赖更新..."
    pip3 install -r requirements.txt --upgrade
    
    # 数据库迁移（如果有变更）
    echo "🗄️ 检查数据库迁移..."
    python3 manage.py makemigrations
    python3 manage.py migrate
    
    # 收集静态文件
    echo "📁 收集静态文件..."
    python3 manage.py collectstatic --noinput
    
    echo "🎉 更新完成！"
    echo ""
    echo "重启服务命令："
    echo "1. 开发环境: python3 manage.py runserver 0.0.0.0:8000"
    echo "2. 生产环境: gunicorn autoDemo.wsgi:application --bind 0.0.0.0:8000"
    echo ""
    echo "访问地址: http://您的服务器IP:8000"
    
else
    echo "❌ 拉取代码失败，请检查网络连接和Git配置"
    exit 1
fi