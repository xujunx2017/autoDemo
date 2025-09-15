# 🔧 华为云部署故障排除指南

## 🚨 常见问题及解决方案

### 问题1：curl命令无反应
**症状**：`curl -fsSL ... | bash` 无响应

**解决方案**：

#### 方法A：手动下载脚本
```bash
# 1. 手动下载脚本
wget https://raw.githubusercontent.com/xujunx2017/autoDemo/main/deploy_quick.sh

# 2. 运行脚本
chmod +x deploy_quick.sh
bash deploy_quick.sh
```

#### 方法B：使用备用脚本
```bash
# 使用备用部署脚本
curl -fsSL https://raw.githubusercontent.com/xujunx2017/autoDemo/main/deploy_backup.sh | bash
```

#### 方法C：完整手动部署
```bash
# 完整手动步骤
sudo apt update && sudo apt install -y python3 python3-pip git
git clone https://github.com/xujunx2017/autoDemo.git
cd autoDemo
pip3 install -r requirements.txt
python3 manage.py migrate
python3 manage.py collectstatic --noinput
python3 manage.py runserver 0.0.0.0:8000
```

### 问题2：网络连接问题
**症状**：无法访问GitHub

**解决方案**：
```bash
# 检查网络连接
ping github.com

# 使用镜像源
git clone https://hub.fastgit.org/xujunx2017/autoDemo.git

# 或使用Gitee镜像
git clone https://gitee.com/mirrors/autoDemo.git
```

### 问题3：权限问题
**症状**：Permission denied

**解决方案**：
```bash
# 检查Python和pip
python3 --version
pip3 --version

# 安装缺失组件
sudo apt install -y python3-dev python3-venv
```

## 📋 验证步骤

### 1. 检查服务器状态
```bash
# 检查系统
lsb_release -a

# 检查Python
python3 --version

# 检查网络
curl -I https://github.com
```

### 2. 测试部署
```bash
# 测试Python环境
python3 -c "print('Python环境正常')"

# 测试Git
git --version

# 测试端口
netstat -tuln | grep 8000
```

## 🎯 一键解决方案

### 方案1：完整手动部署
```bash
# 复制粘贴到华为云服务器
cd /tmp
cat > deploy_manual.sh << 'EOF'
#!/bin/bash
set -e

# 安装依赖
sudo apt update -y
sudo apt install -y python3 python3-pip git

# 克隆项目
git clone https://github.com/xujunx2017/autoDemo.git
cd autoDemo

# 安装Python包
pip3 install -r requirements.txt

# 数据库迁移
python3 manage.py migrate

# 收集静态文件
python3 manage.py collectstatic --noinput

# 创建管理员
python3 manage.py shell -c "
from django.contrib.auth.models import User
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
    print('管理员创建成功')
"

echo "部署完成！访问: http://$(hostname -I | awk '{print $1}'):8000"
EOF

chmod +x deploy_manual.sh
bash deploy_manual.sh
```

### 方案2：分步执行
```bash
# 步骤1：检查环境
python3 --version && pip3 --version && git --version

# 步骤2：克隆代码
git clone https://github.com/xujunx2017/autoDemo.git

# 步骤3：安装依赖
cd autoDemo && pip3 install -r requirements.txt

# 步骤4：启动服务
python3 manage.py runserver 0.0.0.0:8000
```

## 🔍 调试命令

### 检查网络
```bash
# 检查DNS
nslookup github.com

# 检查路由
traceroute github.com

# 检查端口
telnet github.com 443
```

### 检查服务
```bash
# 查看进程
ps aux | grep python

# 查看日志
tail -f /var/log/syslog

# 检查端口占用
lsof -i :8000
```

## 📞 技术支持

如果以上方法都无效：
1. 检查服务器防火墙设置
2. 确认GitHub访问权限
3. 尝试使用代理或镜像
4. 联系华为云技术支持