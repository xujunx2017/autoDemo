# 🚀 华为云部署完整指南

## 📋 部署前准备

### 1. 华为云服务器要求
- **操作系统**: Ubuntu 20.04+ / CentOS 7+
- **Python**: 3.8+
- **内存**: 至少2GB
- **端口**: 8000端口已开放

### 2. 服务器环境检查
```bash
# 连接服务器
ssh root@YOUR_SERVER_IP

# 检查Python
python3 --version
pip3 --version

# 检查端口
netstat -tuln | grep 8000
```

## 🎯 一键部署步骤

### 步骤1: 修改脚本仓库地址
```bash
# 下载脚本
wget https://raw.githubusercontent.com/xujunx2017/autoDemo/main/deploy_to_huaweicloud.sh

# 编辑脚本，替换仓库地址
nano deploy_to_huaweicloud.sh
```

**找到这一行并修改**:
```bash
# 替换为您的实际仓库地址
git clone https://github.com/YOUR_USERNAME/autoDemo.git
```

### 步骤2: 运行部署
```bash
# 赋予执行权限
chmod +x deploy_to_huaweicloud.sh

# 一键部署
bash deploy_to_huaweicloud.sh
```

### 步骤3: 启动服务
部署完成后，脚本会显示启动命令：

#### 开发环境启动
```bash
cd autoDemo
python3 manage.py runserver 0.0.0.0:8000
```

#### 生产环境启动（推荐）
```bash
cd autoDemo
pip3 install gunicorn
gunicorn autoDemo.wsgi:application --bind 0.0.0.0:8000 --workers 3
```

## 🔧 访问测试

### 浏览器访问
```
http://YOUR_SERVER_IP:8000/tools/json-formatter/
```

### 默认账号
- **用户名**: admin
- **密码**: admin123

## 📊 部署验证

### 1. 服务状态检查
```bash
# 查看进程
ps aux | grep python

# 查看端口监听
netstat -tuln | grep 8000

# 查看日志
tail -f autoDemo/logs/debug.log
```

### 2. 功能测试
- JSON格式化工具: `http://IP:8000/tools/json-formatter/`
- 管理员后台: `http://IP:8000/admin/`

## 🛠️ 常见问题解决

### 问题1: 端口未开放
```bash
# Ubuntu/Debian
ufw allow 8000

# CentOS
firewall-cmd --permanent --add-port=8000/tcp
firewall-cmd --reload
```

### 问题2: 依赖安装失败
```bash
# 更新pip
pip3 install --upgrade pip

# 单独安装依赖
pip3 install django==4.2.0
pip3 install djangorestframework
```

### 问题3: 权限问题
```bash
# 修改文件权限
chmod -R 755 autoDemo/
chown -R www-data:www-data autoDemo/
```

## 🔄 后续更新

部署完成后，日常更新使用：
```bash
cd autoDemo
./update_from_github.sh
```

## 📞 技术支持

如果遇到问题：
1. 检查服务器日志
2. 确认端口开放
3. 验证Python环境
4. 检查Git仓库权限