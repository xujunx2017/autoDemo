# 华为云部署指南

## 项目简介
autoDemo是一个基于Django的JSON工具集合，包含JSON格式化、验证和比较功能。

## 部署方式

### 方式1：云服务器ECS部署

#### 1. 准备云服务器
- 登录华为云控制台
- 创建ECS实例（推荐配置：2核4GB内存，CentOS 8/Ubuntu 20.04）
- 开放端口：8000（应用端口）

#### 2. 连接服务器
```bash
ssh root@your-server-ip
```

#### 3. 安装环境
```bash
# 更新系统
yum update -y  # CentOS
apt update -y  # Ubuntu

# 安装Python3和pip
yum install python3 python3-pip -y  # CentOS
apt install python3 python3-pip -y  # Ubuntu

# 安装Git
git --version || (yum install git -y || apt install git -y)
```

#### 4. 部署应用
```bash
# 克隆代码
git clone <your-repo-url>
cd autoDemo

# 运行部署脚本
chmod +x deploy_to_huaweicloud.sh
bash deploy_to_huaweicloud.sh

# 启动应用
python3 manage.py runserver 0.0.0.0:8000
```

#### 5. 使用Gunicorn（推荐）
```bash
# 安装Gunicorn
pip3 install gunicorn

# 启动Gunicorn
gunicorn autoDemo.wsgi:application --bind 0.0.0.0:8000 --workers 3
```

#### 6. 配置Nginx（可选）
```bash
# 安装Nginx
yum install nginx -y || apt install nginx -y

# 配置Nginx
sudo tee /etc/nginx/conf.d/autodemo.conf > /dev/null <<EOF
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }

    location /static/ {
        alias /path/to/autoDemo/staticfiles/;
    }
}
EOF

# 启动Nginx
systemctl start nginx
systemctl enable nginx
```

### 方式2：容器服务部署

#### 1. 使用Docker部署
```bash
# 构建镜像
docker build -t autodemo:latest .

# 运行容器
docker run -d -p 8000:8000 --name autodemo autodemo:latest
```

#### 2. 使用华为云容器服务
- 登录华为云容器镜像服务（SWR）
- 推送镜像到SWR
- 在CCE中创建部署

### 方式3：函数工作流部署

#### 1. 准备函数代码
```bash
# 打包项目
zip -r autodemo.zip . -x "*.git*" "__pycache__*" "*.pyc"
```

#### 2. 创建函数
- 登录华为云函数工作流控制台
- 创建Python函数
- 上传autodemo.zip
- 设置入口函数为autoDemo.wsgi.application

## 访问地址

部署完成后，可以通过以下地址访问：
- 直接访问：http://your-server-ip:8000/tools/json-formatter/
- 域名访问：http://your-domain.com/tools/json-formatter/

## 管理员账户
- 用户名：admin
- 密码：admin123

## 环境变量配置

### 数据库配置（可选）
```bash
export DB_NAME=autodemo
export DB_USER=root
export DB_PASSWORD=yourpassword
export DB_HOST=your-rds-endpoint
export DB_PORT=3306
```

### 安全配置
```bash
export SECRET_KEY=your-secret-key
export HUAWEICLOUD_ENV=production
```

## 监控和日志

### 查看应用日志
```bash
# 查看Django日志
tail -f /path/to/autoDemo/logs/django.log

# 查看Gunicorn日志
tail -f /var/log/gunicorn/error.log
```

### 健康检查
访问：http://your-server-ip:8000/health/

## 故障排查

### 常见问题
1. **端口未开放**：检查安全组配置
2. **静态文件404**：运行`python3 manage.py collectstatic`
3. **数据库连接失败**：检查RDS配置和网络连通性
4. **权限问题**：确保文件权限正确

### 调试模式
```bash
# 临时开启调试模式
export DEBUG=True
python3 manage.py runserver 0.0.0.0:8000
```

## 更新部署

### 热更新
```bash
# 拉取最新代码
git pull origin main

# 更新依赖
pip3 install -r requirements.txt

# 数据库迁移
python3 manage.py migrate

# 收集静态文件
python3 manage.py collectstatic --noinput

# 重启服务
sudo systemctl restart gunicorn
```

### 蓝绿部署
- 使用华为云容器服务的滚动更新
- 或者使用负载均衡器进行流量切换

## 性能优化

### 数据库优化
- 使用华为云RDS MySQL
- 配置连接池
- 开启查询缓存

### 缓存优化
- 使用Redis作为缓存
- 配置Django缓存框架

### CDN配置
- 使用华为云CDN加速静态文件
- 配置域名和证书

## 安全建议

1. **使用HTTPS**：配置SSL证书
2. **定期更新**：及时更新依赖包
3. **访问控制**：配置IP白名单
4. **日志审计**：开启访问日志和错误日志
5. **备份策略**：定期备份数据库和文件

## 联系支持

如有问题，请联系：
- 华为云技术支持
- 项目维护团队