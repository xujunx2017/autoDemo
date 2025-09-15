# autoDemo 快速开始指南

## 🚀 项目设置

### 1. 创建GitHub仓库
访问 https://github.com/new 创建仓库：
- Repository name: `autoDemo`
- 保持公开
- 不要初始化README

### 2. 设置远程仓库
双击运行：`setup_remote_now.bat`
输入您的GitHub用户名即可

### 3. 本地运行
```bash
python manage.py runserver
```
访问：http://localhost:8000/tools/json-formatter/

## 🎯 核心功能

- **JSON格式化工具**: http://localhost:8000/tools/json-formatter/
- **JSON比较工具**: http://localhost:8000/tools/json-compare/
- **管理员界面**: http://localhost:8000/admin/

## 🌩️ 华为云部署

### 方法一：一键部署
双击运行：`deploy_to_huaweicloud.sh`

### 方法二：手动部署
```bash
# 在华为云服务器上运行
git clone https://github.com/YOUR_USERNAME/autoDemo.git
cd autoDemo
bash deploy_to_huaweicloud.sh
```

## 📁 项目结构

```
autoDemo/
├── autoDemo/          # Django项目配置
├── jsoncompare/       # 应用逻辑
├── templates/         # HTML模板
├── static/           # 静态文件
├── requirements.txt  # 依赖列表
├── manage.py         # Django管理脚本
├── Dockerfile        # 容器化配置
└── deploy_to_huaweicloud.sh  # 部署脚本
```

## 🔧 开发命令

```bash
# 安装依赖
pip install -r requirements.txt

# 运行开发服务器
python manage.py runserver

# 创建管理员
python manage.py createsuperuser

# 运行测试
python manage.py test
```

## 📞 支持

- 查看 `README.md` 获取完整文档
- 查看 `HUAWEICLOUD_DEPLOY.md` 获取部署指南
- 查看 `REMOTE_SETUP_GUIDE.md` 获取Git设置帮助