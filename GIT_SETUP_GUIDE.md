# Git仓库设置指南

## 🚀 创建远程仓库

### 选项1：GitHub（推荐）
1. 访问 https://github.com/new
2. 创建新仓库：
   - Repository name: `autoDemo`
   - Description: `Django JSON工具集合，支持华为云部署`
   - Public/Private: 根据需求选择
   - 不要勾选 "Initialize this repository with a README"

### 选项2：Gitee（国内推荐）
1. 访问 https://gitee.com/projects/new
2. 创建新仓库：
   - 仓库名称: `autoDemo`
   - 仓库介绍: `Django JSON工具集合，支持华为云部署`
   - 公开/私有: 根据需求选择

### 选项3：华为云CodeHub
1. 登录华为云控制台
2. 进入CodeHub服务
3. 创建新仓库：
   - 仓库名称: `autoDemo`
   - 描述: `Django JSON工具集合`

## 🔗 连接本地仓库到远程

### 步骤1：添加远程仓库
根据您选择的平台，运行对应的命令：

#### GitHub
```bash
git remote add origin https://github.com/YOUR_USERNAME/autoDemo.git
```

#### Gitee
```bash
git remote add origin https://gitee.com/YOUR_USERNAME/autoDemo.git
```

#### 华为云CodeHub
```bash
git remote add origin https://codehub.devcloud.cn-north-4.huaweicloud.com/YOUR_USERNAME/autoDemo.git
```

### 步骤2：推送代码
```bash
git branch -M main
git push -u origin main
```

## 📋 验证Git配置

### 检查远程仓库
```bash
git remote -v
```

### 测试克隆（在新目录）
```bash
cd /tmp  # 或 Windows: cd %TEMP%
git clone https://github.com/YOUR_USERNAME/autoDemo.git
cd autoDemo
ls -la
```

## 🚀 华为云部署使用

### 部署脚本中的Git克隆命令
在 `deploy_to_huaweicloud.sh` 中，将以下部分：
```bash
git clone <your-repo-url>
cd autoDemo
```

替换为您的实际仓库地址：
```bash
git clone https://github.com/YOUR_USERNAME/autoDemo.git
# 或
git clone https://gitee.com/YOUR_USERNAME/autoDemo.git
# 或
git clone https://codehub.devcloud.cn-north-4.huaweicloud.com/YOUR_USERNAME/autoDemo.git
cd autoDemo
```

## 📦 仓库结构

```
autoDemo/
├── .gitignore              # Git忽略文件
├── requirements.txt        # Python依赖
├── Dockerfile             # 容器配置
├── deploy_to_huaweicloud.sh # 部署脚本
├── huaweicloud_deploy.py   # 华为云配置
├── HUAWEICLOUD_DEPLOY.md   # 部署文档
├── DEPLOYMENT_SUMMARY.md   # 部署总结
├── autoDemo/              # Django主配置
├── jsoncompare/           # JSON工具应用
├── templates/             # HTML模板
├── static/               # 静态文件
└── manage.py             # Django管理脚本
```

## 🎯 下一步操作

1. **创建远程仓库**（选择上述任一平台）
2. **复制仓库URL**
3. **运行连接命令**
4. **推送代码**
5. **在华为云部署脚本中使用正确的仓库URL**

## 🔧 常见问题解决

### 认证问题
```bash
# 如果使用HTTPS需要认证
git config --global credential.helper store
# 或配置SSH key
```

### 权限问题
```bash
# 检查权限
git remote set-url origin git@github.com:YOUR_USERNAME/autoDemo.git
```

### 分支问题
```bash
# 如果main分支不存在
git branch -M main
```

## 📞 支持

如有Git配置问题：
- GitHub文档: https://docs.github.com/
- Gitee文档: https://gitee.com/help
- 华为云CodeHub文档: https://support.huaweicloud.com/codehub/