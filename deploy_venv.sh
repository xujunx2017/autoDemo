#!/bin/bash

# 华为云虚拟环境部署脚本
# 解决PEP 668环境问题

set -e

echo "🚀 华为云虚拟环境部署开始..."

# 检查系统
echo "🔍 检查系统..."
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3未安装"
    exit 1
fi

# 安装必要工具
echo "📦 安装必要工具..."
if command -v apt-get &> /dev/null; then
    sudo apt-get update -y
    sudo apt-get install -y python3-venv python3-pip git
elif command -v yum &> /dev/null; then
    sudo yum update -y
    sudo yum install -y python3-venv python3-pip git
fi

# 创建项目目录
echo "📁 创建项目目录..."
PROJECT_DIR="/opt/autoDemo"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

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
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi

# 激活虚拟环境
source venv/bin/activate

# 升级pip
echo "📦 升级pip..."
pip install --upgrade pip

# 安装依赖
echo "📦 安装项目依赖..."
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
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
    print('✅ 管理员已创建: admin/admin123')
else:
    print('✅ 管理员已存在')
"

# 创建启动脚本
echo "📝 创建启动脚本..."
cat > start_server.sh << 'EOF'
#!/bin/bash
cd /opt/autoDemo/autoDemo
source /opt/autoDemo/autoDemo/venv/bin/activate
echo "🚀 启动Django服务..."
python manage.py runserver 0.0.0.0:8000
EOF

chmod +x start_server.sh

# 创建系统服务
echo "🔧 创建系统服务..."
sudo tee /etc/systemd/system/autodemo.service > /dev/null << 'EOF'
[Unit]
Description=Django AutoDemo Service
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/autoDemo/autoDemo
Environment=PATH=/opt/autoDemo/autoDemo/venv/bin
ExecStart=/opt/autoDemo/autoDemo/venv/bin/python manage.py runserver 0.0.0.0:8000
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# 设置防火墙
echo "🔥 设置防火墙..."
sudo ufw allow 8000/tcp 2>/dev/null || echo "⚠️ 防火墙设置跳过"

echo ""
echo "🎉 部署完成！"
echo "📍 项目路径: $PROJECT_DIR/autoDemo"
echo "🚀 启动命令:"
echo "   开发环境: cd $PROJECT_DIR/autoDemo && source venv/bin/activate && python manage.py runserver 0.0.0.0:8000"
echo "   系统服务: sudo systemctl start autodemo && sudo systemctl enable autodemo"
echo "🌐 访问地址: http://$(hostname -I | awk '{print $1}'):8000"
echo "📋 测试工具: http://$(hostname -I | awk '{print $1}'):8000/tools/json-formatter/"
echo "🔧 管理后台: http://$(hostname -I | awk '{print $1}'):8000/admin/"