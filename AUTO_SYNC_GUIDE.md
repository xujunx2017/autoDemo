# 🔄 代码自动同步指南

## 📋 同步方案概述

为了保证代码变动后华为云代码也及时更新，我们提供了**双向自动同步**解决方案：

### 🎯 同步流程
```
本地开发 → GitHub → 华为云服务器
```

## 🚀 使用方法

### 方法一：一键同步（推荐）

#### 1. 本地同步到GitHub
双击运行：`sync_to_huaweicloud.bat`

功能：
- ✅ 自动检测并提交本地更改
- ✅ 推送到GitHub远程仓库
- ✅ 显示下一步操作指引

#### 2. 华为云服务器同步
在华为云服务器上运行：
```bash
# 首次设置
chmod +x update_from_github.sh

# 每次更新
./update_from_github.sh
```

功能：
- ✅ 自动拉取最新代码
- ✅ 更新依赖包
- ✅ 执行数据库迁移
- ✅ 收集静态文件

### 方法二：手动同步

#### 本地到GitHub
```bash
cd d:\demo\autoDemo
git add .
git commit -m "更新描述"
git push origin main
```

#### GitHub到华为云
```bash
# 在华为云服务器上
ssh root@华为云IP
cd /path/to/autoDemo
git pull origin main
pip3 install -r requirements.txt --upgrade
python3 manage.py migrate
python3 manage.py collectstatic --noinput
```

## 🔧 设置定时自动同步

### 华为云服务器设置定时任务
```bash
# 编辑crontab
crontab -e

# 每10分钟自动检查更新
*/10 * * * * cd /path/to/autoDemo && git pull origin main && pip3 install -r requirements.txt --upgrade && python3 manage.py migrate && python3 manage.py collectstatic --noinput
```

### 本地设置定时推送（Windows）
1. 创建计划任务
2. 设置运行 `sync_to_huaweicloud.bat`
3. 设置触发器（如每小时检查一次）

## 📊 同步状态检查

### 检查本地状态
```bash
git status
git log --oneline -5
```

### 检查华为云状态
```bash
# 在华为云服务器上
git log --oneline -5
python3 manage.py check
```

## 🚨 常见问题解决

### 1. 同步失败
- 检查网络连接
- 确认GitHub仓库权限
- 检查华为云服务器网络

### 2. 依赖更新失败
```bash
# 强制重新安装依赖
pip3 uninstall -r requirements.txt -y
pip3 install -r requirements.txt
```

### 3. 数据库迁移问题
```bash
# 重置数据库（谨慎使用）
python3 manage.py makemigrations
python3 manage.py migrate --fake-initial
```

## 🔄 完整工作流

### 日常开发流程
1. **本地开发** → 修改代码
2. **一键同步** → 运行 `sync_to_huaweicloud.bat`
3. **自动部署** → 华为云服务器自动更新
4. **在线验证** → 访问 http://华为云IP:8000

### 紧急更新
```bash
# 立即强制同步
./update_from_github.sh --force
```

## 📞 支持

- 查看 `AUTO_SYNC_GUIDE.md` 获取详细说明
- 检查 `sync_to_huaweicloud.bat` 本地同步脚本
- 检查 `update_from_github.sh` 华为云更新脚本