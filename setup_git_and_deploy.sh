#!/bin/bash

# autoDemo Git仓库设置和华为云部署脚本

set -e

echo "🚀 autoDemo Git仓库设置和华为云部署向导"
echo "========================================"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 检查Git是否安装
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git未安装，请先安装Git${NC}"
    exit 1
fi

# 显示当前Git状态
echo -e "${YELLOW}📋 当前Git状态：${NC}"
git status

# 选择远程仓库平台
echo ""
echo -e "${GREEN}请选择远程仓库平台：${NC}"
echo "1) GitHub"
echo "2) Gitee"
echo "3) 华为云CodeHub"
echo "4) 已有远程仓库"
read -p "请输入选项 (1-4): " choice

case $choice in
    1)
        echo -e "${YELLOW}📝 请在GitHub创建仓库：https://github.com/new${NC}"
        echo -e "${YELLOW}仓库名称：autoDemo${NC}"
        read -p "请输入GitHub用户名: " username
        remote_url="https://github.com/$username/autoDemo.git"
        ;;
    2)
        echo -e "${YELLOW}📝 请在Gitee创建仓库：https://gitee.com/projects/new${NC}"
        echo -e "${YELLOW}仓库名称：autoDemo${NC}"
        read -p "请输入Gitee用户名: " username
        remote_url="https://gitee.com/$username/autoDemo.git"
        ;;
    3)
        echo -e "${YELLOW}📝 请在华为云CodeHub创建仓库${NC}"
        read -p "请输入华为云CodeHub仓库URL: " remote_url
        ;;
    4)
        read -p "请输入已有仓库URL: " remote_url
        ;;
    *)
        echo -e "${RED}❌ 无效选项${NC}"
        exit 1
        ;;
esac

# 配置远程仓库
echo ""
echo -e "${GREEN}🔗 配置远程仓库...${NC}"
git remote add origin $remote_url 2>/dev/null || git remote set-url origin $remote_url

# 推送代码
echo -e "${GREEN}📤 推送代码到远程仓库...${NC}"
git branch -M main
git push -u origin main

echo ""
echo -e "${GREEN}✅ Git仓库配置完成！${NC}"
echo "远程仓库地址: $remote_url"

# 更新部署脚本
echo -e "${GREEN}📝 更新部署脚本...${NC}"
sed -i "s|https://github.com/YOUR_USERNAME/autoDemo.git|$remote_url|g" deploy_to_huaweicloud.sh

echo ""
echo -e "${GREEN}🎯 华为云部署命令：${NC}"
echo "在华为云服务器上运行："
echo "git clone $remote_url"
echo "cd autoDemo"
echo "bash deploy_to_huaweicloud.sh"

echo ""
echo -e "${GREEN}📚 查看帮助文档：${NC}"
echo "- HUAWEICLOUD_DEPLOY.md - 详细部署指南"
echo "- GIT_SETUP_GUIDE.md - Git设置指南"
echo "- DEPLOYMENT_SUMMARY.md - 部署总结"