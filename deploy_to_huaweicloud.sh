#!/bin/bash

# 华为云部署脚本
# 使用方法: bash deploy_to_huaweicloud.sh

set -e

echo "开始部署到华为云..."

# 克隆代码
# 请替换为您的实际仓库地址
echo "请确保已创建远程仓库并替换下面的URL"
echo "GitHub: https://github.com/YOUR_USERNAME/autoDemo.git"
echo "Gitee: https://gitee.com/YOUR_USERNAME/autoDemo.git"
echo "华为云CodeHub: https://codehub.devcloud.cn-north-4.huaweicloud.com/YOUR_USERNAME/autoDemo.git"

# 使用您实际的仓库URL
git clone https://github.com/YOUR_USERNAME/autoDemo.git
cd autoDemo

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查Python环境
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}错误: Python3 未安装${NC}"
    exit 1
fi

# 检查pip
if ! command -v pip3 &> /dev/null; then
    echo -e "${RED}错误: pip3 未安装${NC}"
    exit 1
fi

echo -e "${GREEN}Python环境检查通过${NC}"

# 安装依赖
echo "正在安装项目依赖..."
pip3 install -r requirements.txt

# 收集静态文件
echo "正在收集静态文件..."
python3 manage.py collectstatic --noinput

# 数据库迁移
echo "正在执行数据库迁移..."
python3 manage.py makemigrations
python3 manage.py migrate

# 创建超级用户（如果不存在）
echo "检查超级用户..."
python3 manage.py shell -c "
from django.contrib.auth.models import User
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
    print('超级用户已创建: admin/admin123')
else:
    print('超级用户已存在')
"

echo -e "${GREEN}部署准备完成！${NC}"
echo ""
echo "启动应用命令:"
echo "开发环境: python3 manage.py runserver 0.0.0.0:8000"
echo "生产环境: gunicorn autoDemo.wsgi:application --bind 0.0.0.0:8000"
echo ""
echo "浏览器访问地址:"
echo "http://localhost:8000/tools/json-formatter/"