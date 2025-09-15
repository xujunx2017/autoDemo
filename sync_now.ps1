# PowerShell版本同步脚本
# 双击运行或在PowerShell中执行

Write-Host "================" -ForegroundColor Green
Write-Host "  Auto Sync to GitHub" -ForegroundColor Green
Write-Host "================" -ForegroundColor Green
Write-Host ""

# 检查当前目录
$currentDir = Get-Location
Write-Host "Current directory: $currentDir" -ForegroundColor Yellow
Write-Host ""

# 检查Git是否安装
try {
    $gitVersion = git --version
    Write-Host "Git version: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Git is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Git from: https://git-scm.com/" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""

# 检查是否在Git仓库
try {
    git rev-parse --git-dir | Out-Null
    Write-Host "✓ In Git repository" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Not in a Git repository" -ForegroundColor Red
    Write-Host "Please navigate to your autoDemo folder first" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# 显示当前状态
Write-Host "Current Git status:" -ForegroundColor Yellow
git status --short
Write-Host ""

# 检查是否有未提交的更改
$changes = git status --porcelain
if ($changes) {
    Write-Host "Found changes, preparing to commit..." -ForegroundColor Yellow
    git add .
    git commit -m "Auto sync $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    Write-Host "✓ Changes committed" -ForegroundColor Green
} else {
    Write-Host "No changes to commit" -ForegroundColor Green
}

Write-Host ""

# 推送到GitHub
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
try {
    git push origin main
    Write-Host "✓ Successfully pushed to GitHub!" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Push failed!" -ForegroundColor Red
    Write-Host "Possible solutions:" -ForegroundColor Yellow
    Write-Host "1. Check internet connection" -ForegroundColor White
    Write-Host "2. Verify GitHub authentication" -ForegroundColor White
    Write-Host "3. Check remote repository settings" -ForegroundColor White
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "================" -ForegroundColor Green
Write-Host "  Next Steps" -ForegroundColor Green
Write-Host "================" -ForegroundColor Green
Write-Host ""
Write-Host "1. Connect to Huawei Cloud:" -ForegroundColor Yellow
Write-Host "   ssh username@your-server-ip" -ForegroundColor White
Write-Host ""
Write-Host "2. Update the code:" -ForegroundColor Yellow
Write-Host "   git pull origin main" -ForegroundColor White
Write-Host ""
Write-Host "3. Or use the update script:" -ForegroundColor Yellow
Write-Host "   bash update_from_github.sh" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter to close"