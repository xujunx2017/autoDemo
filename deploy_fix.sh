#!/bin/bash

# 🚀 华为云Django项目修复部署脚本
# 解决whitenoise版本不兼容、目录冲突、依赖安装问题

set -e

echo "🔄 开始修复部署..."

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. 清理已存在的目录
echo -e "${YELLOW}📁 清理已存在的项目目录...${NC}"
if [ -d "autoDemo" ]; then
    echo "发现已存在的autoDemo目录，正在备份并清理..."
    mv autoDemo autoDemo_backup_$(date +%Y%m%d_%H%M%S)
    echo "已备份旧目录"
fi

# 2. 系统更新和必要工具安装
echo -e "${YELLOW}🔧 更新系统并安装必要工具...${NC}"
sudo apt update
sudo apt install -y python3-venv python3-pip git curl

# 3. 克隆最新代码
echo -e "${YELLOW}📦 克隆最新代码...${NC}"
git clone https://github.com/xujunx2017/autoDemo.git
cd autoDemo

# 4. 创建虚拟环境
echo -e "${YELLOW}🐍 创建虚拟环境...${NC}"
python3 -m venv venv
source venv/bin/activate

# 5. 修复requirements.txt
echo -e "${YELLOW}⚙️ 修复依赖版本...${NC}"
# 创建修复版的requirements.txt
cat > requirements.txt << 'EOF'
Django==4.2.7
whitenoise==6.5.0
EOF

echo "已更新requirements.txt:"
cat requirements.txt

# 6. 安装依赖
echo -e "${YELLOW}📥 安装Python依赖...${NC}"
pip install --upgrade pip
pip install -r requirements.txt

# 7. 验证安装
echo -e "${YELLOW}✅ 验证Django安装...${NC}"
python -c "import django; print(f'Django版本: {django.VERSION}')"

# 8. 数据库迁移
echo -e "${YELLOW}🗄️ 数据库迁移...${NC}"
python manage.py migrate

# 9. 收集静态文件
echo -e "${YELLOW}📂 收集静态文件...${NC}"
python manage.py collectstatic --noinput

# 10. 创建超级用户（如果不存在）
echo -e "${YELLOW}👤 创建管理员账户...${NC}"
python manage.py shell -c "
from django.contrib.auth.models import User
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
    print('✅ 管理员账户已创建: admin/admin123')
else:
    print('✅ 管理员账户已存在')
"

# 11. 启动Django开发服务器
echo -e "${YELLOW}🚀 启动Django服务器...${NC}"
echo "服务器将在后台运行，端口8000"
nohup python manage.py runserver 0.0.0.0:8000 > django.log 2>&1 &

# 12. 等待服务器启动
echo -e "${YELLOW}⏳ 等待服务器启动...${NC}"
sleep 5

# 13. 验证服务器状态
echo -e "${YELLOW}🔍 验证服务器状态...${NC}"
if curl -s http://localhost:8000 > /dev/null; then
    echo -e "${GREEN}✅ Django服务器已成功启动！${NC}"
    echo -e "${GREEN}🌐 访问地址: http://$(curl -s ifconfig.me):8000/tools/json-formatter/${NC}"
    echo -e "${GREEN}🔑 管理员账号: admin/admin123${NC}"
else
    echo -e "${RED}❌ 服务器启动失败，请检查日志${NC}"
    cat django.log
fi

echo -e "${GREEN}🎉 修复部署完成！${NC}"