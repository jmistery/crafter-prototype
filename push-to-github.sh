#!/bin/bash

# 五岳CMS-lite HTML原型 - 推送到GitHub脚本
# 使用方法：./push-to-github.sh YOUR_GITHUB_USERNAME

echo "=================================="
echo "推送代码到GitHub"
echo "=================================="
echo ""

if [ -z "$1" ]; then
    echo "❌ 错误：请提供你的GitHub用户名"
    echo ""
    echo "使用方法："
    echo "  ./push-to-github.sh YOUR_GITHUB_USERNAME"
    echo ""
    echo "例如："
    echo "  ./push-to-github.sh yanneswang"
    echo ""
    exit 1
fi

USERNAME=$1
REPO_NAME="crafter-prototype"

echo "📦 仓库信息："
echo "   用户名: $USERNAME"
echo "   仓库名: $REPO_NAME"
echo ""

# 检查是否已有远程仓库
if git remote get-url origin 2>/dev/null; then
    echo "⚠️  检测到已存在的远程仓库，正在移除..."
    git remote remove origin
fi

# 添加远程仓库
echo "🔗 添加远程仓库..."
git remote add origin "https://github.com/$USERNAME/$REPO_NAME.git"

# 重命名分支为main
echo "🌿 重命名分支为 main..."
git branch -M main

# 推送代码
echo "⬆️  推送代码到GitHub..."
echo ""
echo "💡 提示：如果这是第一次推送，系统会要求输入GitHub凭据"
echo "   - 用户名: 你的GitHub用户名"
echo "   - 密码: 使用Personal Access Token（不是密码）"
echo ""
echo "   如何获取Token？"
echo "   1. 访问: https://github.com/settings/tokens"
echo "   2. 点击 'Generate new token' → 'Generate new token (classic)'"
echo "   3. 勾选 'repo' 权限"
echo "   4. 生成并复制token"
echo ""

git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "=================================="
    echo "✅ 成功！代码已推送到GitHub"
    echo "=================================="
    echo ""
    echo "📍 仓库地址："
    echo "   https://github.com/$USERNAME/$REPO_NAME"
    echo ""
    echo "🎯 下一步："
    echo "   1. 访问 https://vercel.com"
    echo "   2. 用GitHub账号登录"
    echo "   3. 导入 $REPO_NAME 仓库"
    echo "   4. 点击 Deploy"
    echo ""
    echo "🎉 几秒钟后就能获得分享链接了！"
    echo ""
else
    echo ""
    echo "=================================="
    echo "❌ 推送失败"
    echo "=================================="
    echo ""
    echo "可能的原因："
    echo "1. GitHub仓库还没创建"
    echo "   → 访问 https://github.com/new 创建仓库"
    echo ""
    echo "2. 用户名输入错误"
    echo "   → 重新运行脚本，确保用户名正确"
    echo ""
    echo "3. 认证失败"
    echo "   → 使用Personal Access Token而不是密码"
    echo ""
fi

