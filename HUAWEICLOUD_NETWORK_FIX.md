# 华为云网络连接问题解决方案

## 问题分析

华为云服务器无法连接GitHub，出现：
```
error: RPC failed; curl 28 Failed to connect to github.com port 443 after 133532 ms: Couldn't connect to server
```

## 解决方案

### 方案1：使用国内镜像源

创建备用部署脚本：

```bash
#!/bin/bash
# deploy_venv_cn.sh - 使用国内镜像的部署脚本

echo "🚀 使用国内镜像部署..."

# 使用Gitee镜像
if [ ! -d "autoDemo" ]; then
    echo "📥 克隆代码（Gitee镜像）..."
    git clone https://gitee.com/mirrors-github/autoDemo.git
else
    echo "⚠️ 项目已存在，更新代码..."
    cd autoDemo
    git remote set-url origin https://gitee.com/mirrors-github/autoDemo.git
    git pull origin main
fi

echo "✅ 部署完成！"
```

### 方案2：手动下载部署

如果镜像也连接失败，可以手动部署：

```bash
#!/bin/bash
# manual_deploy.sh - 手动部署方案

echo "🚀 开始手动部署..."

# 1. 创建项目目录
mkdir -p /opt/autoDemo
cd /opt/autoDemo

# 2. 在本地打包项目，上传到服务器
# 使用scp上传本地项目到华为云：
# scp -r /path/to/local/autoDemo root@your-huawei-ip:/opt/

# 3. 设置虚拟环境
python3 -m venv venv
source venv/bin/activate

# 4. 安装依赖
pip install -r requirements.txt

# 5. 运行服务
python manage.py runserver 0.0.0.0:8000
```

### 方案3：使用代理

```bash
#!/bin/bash
# deploy_with_proxy.sh - 使用代理部署

# 设置HTTP代理（如果有可用代理）
export http_proxy=http://your-proxy:port
export https_proxy=http://your-proxy:port

# 然后运行原始部署脚本
curl -fsSL https://raw.githubusercontent.com/xujunx2017/autoDemo/main/deploy_venv.sh | bash
```

### 方案4：离线部署包

创建离线部署包：

```bash
# 在本地创建部署包
cd /path/to/autoDemo
tar -czf autoDemo-deploy.tar.gz \
    --exclude="*.pyc" \
    --exclude="__pycache__" \
    --exclude=".git" \
    --exclude="venv" \
    .

# 上传到华为云
scp autoDemo-deploy.tar.gz root@your-huawei-ip:/opt/

# 在华为云解压部署
ssh root@your-huawei-ip 'cd /opt && tar -xzf autoDemo-deploy.tar.gz'
```

## 快速修复命令

在华为云服务器上执行：

```bash
# 方法1：使用国内镜像
git clone https://gitee.com/mirrors-github/autoDemo.git

# 方法2：如果已有项目，切换镜像
cd autoDemo
git remote set-url origin https://gitee.com/mirrors-github/autoDemo.git
git pull origin main

# 方法3：直接下载ZIP包
wget https://github.com/xujunx2017/autoDemo/archive/refs/heads/main.zip
unzip main.zip
mv autoDemo-main autoDemo
```

## 验证部署

```bash
# 检查项目状态
cd autoDemo
git status

# 运行测试
python manage.py check

# 启动服务
python manage.py runserver 0.0.0.0:8000
```

## 网络诊断

```bash
# 检查网络连接
ping github.com
nslookup github.com

# 检查DNS解析
cat /etc/resolv.conf

# 使用国内DNS
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
echo "nameserver 114.114.114.114" >> /etc/resolv.conf
```

## 联系支持

如果以上方法都无效：
1. 检查华为云安全组设置
2. 确认出站网络策略
3. 联系华为云技术支持