# 远程仓库设置指南

## 🎯 快速设置（推荐）

### 步骤1：创建远程仓库
根据您的平台选择：

- **GitHub**: https://github.com/new
  - Repository name: `autoDemo`
  - Public/Private: 选择Public
  - 不要勾选 README

- **Gitee**: https://gitee.com/projects/new
  - 仓库名称: `autoDemo`
  - 公开/私有: 选择公开
  - 不要初始化仓库

- **华为云CodeHub**: 登录华为云控制台 → CodeHub → 新建仓库
  - 仓库名称: `autoDemo`

### 步骤2：设置远程仓库

#### 选项A：一键设置（推荐）
双击运行 `setup_remote_now.bat`，按提示输入：
1. 选择平台（1-4）
2. 输入用户名
3. 自动完成设置

#### 选项B：手动设置
打开命令提示符，运行：

```bash
cd d:\demo\autoDemo

# 移除现有远程（如果有问题）
git remote remove origin

# 设置远程仓库（替换YOUR_USERNAME）
# GitHub:
git remote add origin https://github.com/YOUR_USERNAME/autoDemo.git

# Gitee:
git remote add origin https://gitee.com/YOUR_USERNAME/autoDemo.git

# 华为云:
git remote add origin https://codehub.devcloud.cn-north-4.huaweicloud.com/YOUR_USERNAME/autoDemo.git

# 推送代码
git branch -M main
git push -u origin main
```

### 步骤3：验证
运行以下命令验证：
```bash
git remote -v
git push origin main
```

## 🔧 故障排除

### 问题1：权限错误
```bash
git remote remove origin
git remote add origin https://username:token@github.com/username/autoDemo.git
```

### 问题2：用户名中文乱码
使用英文用户名或在GitHub/Gitee注册英文用户名

### 问题3：推送失败
```bash
git pull origin main --allow-unrelated-histories
git push origin main
```

## 📱 可用的脚本

| 脚本 | 功能 |
|------|------|
| `setup_remote_now.bat` | 一键设置远程仓库 |
| `fix_remote.bat` | 修复远程仓库问题 |
| `clean_setup.bat` | 提供手动命令指导 |
| `one_click_setup.bat` | 检查当前状态 |

## 🎯 下一步

设置完成后，您可以：
1. 在GitHub/Gitee查看您的代码
2. 使用华为云部署脚本部署到云端
3. 继续开发新功能