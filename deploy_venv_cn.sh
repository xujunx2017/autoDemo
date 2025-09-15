#!/bin/bash
# 华为云国内镜像部署脚本

set -e

echo "🚀 华为云部署 - 使用国内镜像"
echo "================================"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查系统
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
else
    echo -e "${RED}❌ 不支持的操作系统${NC}"
    exit 1
fi

echo -e "${GREEN}✅ 检测系统: $OS${NC}"

# 更新系统包
echo -e "${YELLOW}📦 更新系统包...${NC}"
if [[ $OS == "linux" ]]; then
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y python3-pip python3-venv curl wget git
elif [[ $OS == "macos" ]]; then
    brew update
    brew install python3 curl wget git
fi

# 设置项目目录
PROJECT_DIR="/opt/autoDemo"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# 使用国内镜像克隆或更新
echo -e "${YELLOW}📥 获取代码...${NC}"
if [ -d ".git" ]; then
    echo -e "${YELLOW}⚠️ 项目已存在，更新代码...${NC}"
    git remote set-url origin https://gitee.com/mirrors-github/autoDemo.git || \
    git remote add origin https://gitee.com/mirrors-github/autoDemo.git
    git pull origin main
else
    echo -e "${YELLOW}📥 克隆代码（Gitee镜像）...${NC}"
    git clone https://gitee.com/mirrors-github/autoDemo.git .
fi

# 创建虚拟环境
echo -e "${YELLOW}🐍 创建虚拟环境...${NC}"
python3 -m venv venv
source venv/bin/activate

# 使用国内pip镜像
echo -e "${YELLOW}📦 安装依赖（国内镜像）...${NC}"
cat > pip.conf << EOF
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
trusted-host = pypi.tuna.tsinghua.edu.cn
EOF

mkdir -p ~/.pip
cp pip.conf ~/.pip/pip.conf

# 安装依赖
pip install --upgrade pip
pip install -r requirements.txt

# 数据库迁移
echo -e "${YELLOW}🗄️ 数据库迁移...${NC}"
python manage.py makemigrations
python manage.py migrate

# 收集静态文件
python manage.py collectstatic --noinput

# 创建启动脚本
cat > start_server.sh << 'EOF'
#!/bin/bash
cd /opt/autoDemo
source venv/bin/activate
python manage.py runserver 0.0.0.0:8000
EOF

chmod +x start_server.sh

# 创建系统服务
cat > /etc/systemd/system/autodemo.service << EOF
[Unit]
Description=AutoDemo Django Service
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/autoDemo
Environment=PATH=/opt/autoDemo/venv/bin
ExecStart=/opt/autoDemo/venv/bin/python manage.py runserver 0.0.0.0:8000
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# 启动服务
systemctl daemon-reload
systemctl enable autodemo
systemctl start autodemo

# 防火墙设置
if command -v ufw &> /dev/null; then
    ufw allow 8000/tcp
fi

# 显示状态
echo -e "${GREEN}✅ 部署完成！${NC}"
echo -e "${GREEN}🌐 访问地址: http://your-server-ip:8000${NC}"
echo -e "${GREEN}🔧 管理命令: systemctl status autodemo${NC}"
echo -e "${GREEN}📁 项目目录: $PROJECT_DIR${NC}"

# 测试服务
sleep 3
curl -f http://localhost:8000/tools/json-formatter/ || echo -e "${YELLOW}⚠️ 服务启动中，请稍后再试${NC}"