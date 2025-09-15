# 同步问题修复指南

## 🚨 编码问题解决方案

### 问题描述
批处理文件中的中文字符导致执行错误：
```
'cho' 不是内部或外部命令
'湪鎻愪氦...' 不是内部或外部命令
```

### ✅ 修复后的文件

#### 1. 本地同步（Windows）
**使用简化版脚本：**
- **文件**: `sync_simple.bat` （无中文字符）
- **使用**: 双击运行

#### 2. 华为云更新（Linux）
**使用英文版脚本：**
- **文件**: `update_from_github.sh` （无中文字符）

### 🚀 新的同步流程

#### 步骤1：本地同步到GitHub
```bash
# 在 Windows 上
cd d:\demo\autoDemo
sync_simple.bat
```

#### 步骤2：华为云服务器更新
```bash
# 在华为云服务器上
./update_from_github.sh
```

### 📋 手动同步（备用方案）

#### 本地手动同步
```bash
# 检查状态
git status

# 添加更改
git add .

# 提交更改
git commit -m "update: describe your changes"

# 推送到GitHub
git push origin main
```

#### 华为云手动更新
```bash
# 在华为云服务器上
cd /path/to/autoDemo
git pull origin main
pip3 install -r requirements.txt --upgrade
python3 manage.py migrate
python3 manage.py collectstatic --noinput
```

### 🔧 文件列表

| 文件 | 用途 | 平台 |
|------|------|------|
| `sync_simple.bat` | 本地同步到GitHub | Windows |
| `update_from_github.sh` | 华为云更新代码 | Linux |
| `deploy_to_huaweicloud.sh` | 首次部署到华为云 | Linux |

### ⚡ 快速开始

1. **本地修改代码** → 开发功能
2. **一键同步** → 双击 `sync_simple.bat`
3. **华为云更新** → 运行 `./update_from_github.sh`
4. **验证** → 访问 http://华为云IP:8000

### 📝 注意事项

- 所有脚本已修复编码问题
- 使用英文提示避免乱码
- 保持简单易用的操作方式
- 支持手动和自动两种模式