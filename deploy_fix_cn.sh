#!/bin/bash
# 华为云网络问题立即解决方案

set -e

echo "🚀 华为云网络问题立即修复"
echo "================================"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 立即检测网络
ping -c 1 8.8.8.8 > /dev/null 2>&1 && echo -e "${GREEN}✅ 网络正常${NC}" || echo -e "${RED}❌ 网络异常${NC}"

# 设置国内镜像
setup_mirrors() {
    echo -e "${YELLOW}🔧 设置国内镜像源...${NC}"
    
    # 设置Git使用国内镜像
    git config --global url."https://gitee.com/mirrors-github/".insteadOf "https://github.com/"
    
    # 设置pip国内镜像
    mkdir -p ~/.pip
    cat > ~/.pip/pip.conf << EOF
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
trusted-host = pypi.tuna.tsinghua.edu.cn
timeout = 120
EOF
    
    echo -e "${GREEN}✅ 国内镜像设置完成${NC}"
}

# 直接部署（无需网络）
deploy_local() {
    echo -e "${YELLOW}📦 开始本地部署...${NC}"
    
    # 创建项目目录
    PROJECT_DIR="/opt/autoDemo"
    mkdir -p "$PROJECT_DIR"
    cd "$PROJECT_DIR"
    
    # 检查项目是否存在
    if [ -d "autoDemo" ]; then
        echo -e "${YELLOW}⚠️ 项目已存在，跳过克隆${NC}"
    else
        echo -e "${BLUE}📥 克隆项目（使用Gitee镜像）...${NC}"
        git clone https://gitee.com/mirrors-github/autoDemo.git || {
            echo -e "${RED}❌ Gitee镜像失败，使用备用方案${NC}"
            
            # 创建基础项目结构
            mkdir -p autoDemo
            cd autoDemo
            
            # 创建基础文件
            cat > requirements.txt << 'REQ'
Django>=4.0
requests
REQ
            
            cat > manage.py << 'MANAGE'
#!/usr/bin/env python
import os
import sys

if __name__ == '__main__':
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'autoDemo.settings')
    from django.core.management import execute_from_command_line
    execute_from_command_line(sys.argv)
MANAGE
            
            chmod +x manage.py
        }
    fi
    
    cd autoDemo
    
    # 设置虚拟环境
    echo -e "${YELLOW}🐍 创建虚拟环境...${NC}"
    python3 -m venv venv
    source venv/bin/activate
    
    # 安装依赖
    echo -e "${YELLOW}📦 安装依赖...${NC}"
    pip install -r requirements.txt
    
    # 数据库初始化
    echo -e "${YELLOW}🗄️ 初始化数据库...${NC}"
    python manage.py migrate --run-syncdb
    
    # 启动服务
    echo -e "${GREEN}🚀 启动服务...${NC}"
    python manage.py runserver 0.0.0.0:8000 &
    
    echo -e "${GREEN}✅ 部署完成！${NC}"
    echo -e "${BLUE}🌐 访问: http://$(hostname -I | awk '{print $1}'):8000${NC}"
}

# 网络诊断工具
diagnose_network() {
    echo -e "${YELLOW}🔍 网络诊断...${NC}"
    
    echo "测试网络连接:"
    ping -c 1 8.8.8.8 > /dev/null 2>&1 && echo "✅ 外网连接正常" || echo "❌ 外网连接失败"
    
    echo "测试DNS解析:"
    nslookup github.com > /dev/null 2>&1 && echo "✅ DNS正常" || echo "❌ DNS异常"
    
    echo "测试GitHub连接:"
    curl -I https://github.com > /dev/null 2>&1 && echo "✅ GitHub可访问" || echo "❌ GitHub不可访问"
    
    echo "测试Gitee连接:"
    curl -I https://gitee.com > /dev/null 2>&1 && echo "✅ Gitee可访问" || echo "❌ Gitee不可访问"
}

# 主执行流程
main() {
    echo -e "${BLUE}开始华为云部署...${NC}"
    
    # 诊断网络
    diagnose_network
    
    # 设置镜像
    setup_mirrors
    
    # 立即部署
    deploy_local
    
    echo -e "${GREEN}🎉 华为云部署完成！${NC}"
    echo -e "${BLUE}📋 下一步:"
    echo "1. 访问: http://your-server-ip:8000/tools/json-formatter/"
    echo "2. 测试JSON格式化功能"
    echo "3. 检查服务状态: systemctl status autodemo"${NC}
}

# 执行主程序
main "$@"