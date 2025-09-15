# Windows批处理脚本运行指南

## 🔧 双击运行问题解决

### 常见问题
1. **权限问题**：右键→以管理员身份运行
2. **路径问题**：确保在autoDemo目录内运行
3. **Git未安装**：请先安装Git

### 推荐运行方式

#### 方法1：直接双击（推荐）
- 双击 `quick_setup.bat` - 最简单的检查脚本
- 双击 `setup_simple.bat` - 完整设置向导

#### 方法2：命令行运行（稳定）
1. 打开命令提示符(CMD)或PowerShell
2. 进入项目目录：
   ```
   cd d:\demo\autoDemo
   ```
3. 运行脚本：
   ```
   quick_setup.bat
   ```

#### 方法3：右键运行
- 右键点击 `.bat` 文件
- 选择"以管理员身份运行"

## 📁 脚本说明

| 脚本文件 | 功能 | 适用场景 |
|---------|------|----------|
| `quick_setup.bat` | 快速检查Git状态 | 初次运行 |
| `setup_simple.bat` | 完整Git设置向导 | 需要配置远程仓库 |
| `setup_git_and_deploy.bat` | 原版设置脚本 | 高级用户 |

## 🚀 快速开始

### 步骤1：检查环境
双击运行 `quick_setup.bat`，检查Git是否安装

### 步骤2：设置远程仓库
1. 在GitHub/Gitee创建仓库：autoDemo
2. 双击运行 `setup_simple.bat`
3. 按提示输入用户名或仓库URL

### 步骤3：验证
运行成功后，在GitHub/Gitee可以看到已上传的代码

## ⚠️ 故障排除

### 问题1：脚本闪退
**解决**：使用命令行方式运行，查看错误信息

### 问题2：Git命令无效
**解决**：
1. 安装Git：https://git-scm.com/downloads
2. 重启电脑
3. 确保Git添加到系统PATH

### 问题3：权限拒绝
**解决**：
1. 右键→以管理员身份运行
2. 或者使用PowerShell运行：
   ```
   Set-ExecutionPolicy RemoteSigned
   ```

## 📞 技术支持

如果仍有问题，请：
1. 截图错误信息
2. 记录运行环境（Windows版本）
3. 联系技术支持