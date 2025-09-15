# 🔄 代码同步快速指南

## 🎯 一键同步方案

### 本地同步到GitHub
**双击运行**: `run_sync.bat`
- ✅ 自动检测Git状态
- ✅ 提交并推送更改
- ✅ 显示详细结果

### 华为云更新
**在华为云服务器上运行**:
```bash
./update_from_github.sh
```

## 📋 文件清单

### 核心同步文件
| 文件 | 用途 | 平台 |
|------|------|------|
| `run_sync.bat` | 本地一键同步 | Windows |
| `update_from_github.sh` | 华为云更新 | Linux |
| `setup_remote_now.bat` | 设置GitHub仓库 | Windows |

### 部署文件
| 文件 | 用途 | 平台 |
|------|------|------|
| `deploy_to_huaweicloud.sh` | 首次部署到华为云 | Linux |
| `setup_git_and_deploy.bat` | 完整部署流程 | Windows |

## 🚀 日常使用流程

### 1. 本地开发后同步
```bash
# 双击运行（推荐）
run_sync.bat

# 或手动命令
git add .
git commit -m "描述更改"
git push origin main
```

### 2. 华为云自动更新
```bash
# 在华为云服务器上
./update_from_github.sh
```

## 📖 详细指南
- [AUTO_SYNC_GUIDE.md](AUTO_SYNC_GUIDE.md) - 完整同步指南
- [SYNC_FIX.md](SYNC_FIX.md) - 问题修复指南
- [QUICK_START.md](QUICK_START.md) - 快速开始

## 🎯 推荐操作
1. **日常同步**: 双击 `run_sync.bat`
2. **首次设置**: 双击 `setup_remote_now.bat`
3. **华为云更新**: `./update_from_github.sh`