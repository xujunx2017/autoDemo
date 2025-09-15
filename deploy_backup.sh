#!/bin/bash

# 华为云部署备用脚本 - 解决网络问题
# 使用方法：复制粘贴整个脚本到服务器运行

set -e

echo "🚀 开始华为云部署..."

# 检查网络连接
echo "🔍 检查网络连接..."
if ! curl -s --connect-timeout 5 google.com > /dev/null 2>&1; then
    echo "⚠️ 网络连接异常，使用离线模式"
else
    echo "✅ 网络连接正常"
fi

# 检查系统
echo "🔍 检查系统环境..."
if command -v apt-get > /dev/null 2>&1; then
    PKG_MANAGER="apt-get"
elif command -v yum > /dev/null 2>&1; then
    PKG_MANAGER="yum"
else
    echo "❌ 不支持的操作系统"
    exit 1
fi

# 安装必要工具
echo "📦 安装必要工具..."
sudo $PKG_MANAGER update -y
sudo $PKG_MANAGER install -y python3 python3-pip git curl wget

# 创建项目目录
echo "📁 创建项目目录..."
mkdir -p /opt/autoDemo
cd /opt/autoDemo

# 克隆代码
echo "📥 克隆代码..."
if [ -d "autoDemo" ]; then
    echo "⚠️ 项目已存在，更新代码..."
    cd autoDemo
    git pull origin main
else
    git clone https://github.com/xujunx2017/autoDemo.git
    cd autoDemo
fi

# 创建虚拟环境
echo "🐍 创建虚拟环境..."
python3 -m venv venv
source venv/bin/activate

# 安装依赖
echo "📦 安装依赖..."
pip install --upgrade pip
pip install -r requirements.txt

# 数据库迁移
echo "🗄️ 数据库迁移..."
python manage.py makemigrations
python manage.py migrate

# 收集静态文件
echo "📁 收集静态文件..."
python manage.py collectstatic --noinput

# 创建管理员
echo "👤 创建管理员..."
python manage.py shell -c "
from django.contrib.auth.models import User
import os
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
    print('✅ 管理员已创建: admin/admin123')
else:
    print('✅ 管理员已存在')
"

# 设置防火墙
echo "🔥 设置防火墙..."
sudo ufw allow 8000/tcp 2>/dev/null || echo "⚠️ 防火墙设置跳过"

# 创建启动脚本
echo "📝 创建启动脚本..."
cat > start_server.sh << 'EOF'
#!/bin/bash
cd /opt/autoDemo/autoDemo
source /opt/autoDemo/venv/bin/activate
echo "🚀 启动Django服务..."
python manage.py runserver 0.0.0.0:8000
EOF

chmod +x start_server.sh

echo ""
echo "🎉 部署完成！"
echo "📍 项目路径: /opt/autoDemo/autoDemo"
echo "🚀 启动命令: /opt/autoDemo/start_server.sh"
echo "🌐 访问地址: http://$(hostname -I | awk '{print $1}'):8000"
echo "📋 测试工具: http://$(hostname -I | awk '{print $1}'):8000/tools/json-formatter/"
echo "🔧 管理后台: http://$(hostname -I | awk '{print $1}'):8000/admin/"