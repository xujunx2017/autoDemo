#!/bin/bash

# 快速部署脚本 - 华为云专用
# 使用方法: bash deploy_quick.sh [仓库地址]

set -e

# 默认仓库地址
REPO_URL=${1:-"https://github.com/xujunx2017/autoDemo.git"}

echo "🚀 开始部署到华为云..."
echo "📦 使用仓库: $REPO_URL"

# 检查环境
echo "🔍 检查环境..."
python3 --version || { echo "❌ Python3未安装"; exit 1; }
pip3 --version || { echo "❌ pip3未安装"; exit 1; }

# 克隆代码
echo "📥 克隆代码..."
if [ -d "autoDemo" ]; then
    echo "⚠️ 目录已存在，更新代码..."
    cd autoDemo
    git pull
else
    git clone $REPO_URL
    cd autoDemo
fi

# 安装依赖
echo "📦 安装依赖..."
pip3 install -r requirements.txt

# 数据库迁移
echo "🗄️ 数据库迁移..."
python3 manage.py makemigrations
python3 manage.py migrate

# 收集静态文件
echo "📁 收集静态文件..."
python3 manage.py collectstatic --noinput

# 创建管理员
echo "👤 创建管理员..."
python3 manage.py shell -c "
from django.contrib.auth.models import User
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
    print('✅ 管理员已创建: admin/admin123')
else:
    print('✅ 管理员已存在')
"

echo ""
echo "🎉 部署完成！"
echo "🌐 访问地址: http://$(hostname -I | awk '{print $1}'):8000"
echo "🛠️ 启动命令:"
echo "   开发环境: python3 manage.py runserver 0.0.0.0:8000"
echo "   生产环境: pip3 install gunicorn && gunicorn autoDemo.wsgi:application --bind 0.0.0.0:8000"
echo ""
echo "📋 测试地址:"
echo "   JSON工具: http://$(hostname -I | awk '{print $1}'):8000/tools/json-formatter/"
echo "   管理后台: http://$(hostname -I | awk '{print $1}'):8000/admin/"