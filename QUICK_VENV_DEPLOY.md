# 🚀 华为云虚拟环境部署指南

## 🚨 解决PEP 668错误

### 错误信息
```
error: externally-managed-environment
This environment is externally managed
```

### 原因
Ubuntu 23.04+ 和 Debian 12+ 启用了PEP 668标准，禁止系统级Python包安装

## 🎯 解决方案

### 方法1：虚拟环境部署（推荐）
```bash
# 连接华为云服务器
ssh root@YOUR_SERVER_IP

# 一键虚拟环境部署
curl -fsSL https://raw.githubusercontent.com/xujunx2017/autoDemo/main/deploy_venv.sh | bash
```

### 方法2：手动虚拟环境部署
```bash
# 步骤1：安装必要工具
sudo apt update && sudo apt install -y python3-venv python3-pip git

# 步骤2：克隆代码
git clone https://github.com/xujunx2017/autoDemo.git
cd autoDemo

# 步骤3：创建虚拟环境
python3 -m venv venv
source venv/bin/activate

# 步骤4：安装依赖
pip install -r requirements.txt

# 步骤5：数据库迁移
python manage.py migrate

# 步骤6：启动服务
python manage.py runserver 0.0.0.0:8000
```

### 方法3：快速临时方案
```bash
# 使用--break-system-packages参数
pip3 install -r requirements.txt --break-system-packages
python3 manage.py runserver 0.0.0.0:8000
```

## 📋 验证部署

### 检查虚拟环境
```bash
# 检查虚拟环境是否激活
which python
# 应该显示: /opt/autoDemo/autoDemo/venv/bin/python

# 检查包安装
pip list
```

### 访问测试
```
浏览器访问: http://YOUR_SERVER_IP:8000/tools/json-formatter/
```

## 🔄 日常使用

### 启动服务
```bash
# 进入项目目录
cd /opt/autoDemo/autoDemo

# 激活虚拟环境
source venv/bin/activate

# 启动服务
python manage.py runserver 0.0.0.0:8000
```

### 更新代码
```bash
cd /opt/autoDemo/autoDemo
git pull origin main
source venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
```

## 🛠️ 系统服务（可选）
```bash
# 启动系统服务
sudo systemctl start autodemo
sudo systemctl enable autodemo

# 查看状态
sudo systemctl status autodemo
```