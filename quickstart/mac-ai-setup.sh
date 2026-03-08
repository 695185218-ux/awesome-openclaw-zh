#!/bin/bash

# Mac AI 开发环境一键安装脚本（第3步到第6步）
# 使用方法：在终端运行 bash mac-ai-setup.sh

set -e

echo ""
echo "======================================"
echo "  Mac AI 开发环境安装脚本"
echo "  自动完成第3步到第6步"
echo "======================================"
echo ""

# ---------- 第三步：Codex CLI ----------
echo "【第3步】安装 Codex CLI..."
npm install -g @openai/codex

echo ""
echo "✓ Codex 安装完成，版本："
codex --version

echo ""
echo ">>> 现在需要你输入 OpenAI API Key"
echo "    没有的话去这里获取：https://platform.openai.com/api-keys"
echo "    格式是 sk-xxxx 开头的一串字符"
echo ""
read -p "请粘贴你的 API Key（回车确认）：" API_KEY

if [ -n "$API_KEY" ]; then
  # 写入 ~/.zshrc
  echo "" >> ~/.zshrc
  echo "# OpenAI API Key" >> ~/.zshrc
  echo "export OPENAI_API_KEY=\"$API_KEY\"" >> ~/.zshrc
  export OPENAI_API_KEY="$API_KEY"
  echo "✓ API Key 已保存"
else
  echo "⚠ 跳过 API Key 配置，稍后可手动添加到 ~/.zshrc"
fi

echo ""
echo "======================================"

# ---------- 第四步：Cursor IDE ----------
echo ""
echo "【第4步】安装 Cursor IDE..."
echo ""

# 用 Homebrew 安装
if brew install --cask cursor 2>/dev/null; then
  echo "✓ Cursor 安装完成"
else
  echo "⚠ Homebrew 安装失败，请手动下载："
  echo "   访问 https://cursor.sh 点击下载"
fi

echo ""
echo "======================================"

# ---------- 第五步：Playwright ----------
echo ""
echo "【第5步】安装 Playwright 浏览器自动化..."
echo ""

# 在用户主目录创建一个专用文件夹
PLAYWRIGHT_DIR="$HOME/ai-browser-tools"
mkdir -p "$PLAYWRIGHT_DIR"
cd "$PLAYWRIGHT_DIR"

# 初始化 package.json（静默）
npm init -y > /dev/null 2>&1

# 安装 playwright
npm install playwright

# 安装浏览器驱动
echo ""
echo "正在下载浏览器驱动（可能需要几分钟）..."
npx playwright install chromium

echo ""
echo "✓ Playwright 安装完成"
echo "  工具目录：$PLAYWRIGHT_DIR"

# 写一个示例脚本
cat > "$PLAYWRIGHT_DIR/demo.mjs" << 'DEMO'
// 浏览器自动化示例
// 运行方法：node demo.mjs
import { chromium } from "playwright";

const browser = await chromium.launch({ headless: false });
const page = await browser.newPage();

await page.goto("https://www.baidu.com");
await page.fill("input#kw", "美食推荐");
await page.press("input#kw", "Enter");
await page.waitForTimeout(2000);

console.log("搜索完成！");
await browser.close();
DEMO

echo "✓ 示例脚本已创建：$PLAYWRIGHT_DIR/demo.mjs"
echo "  运行方式：cd ~/ai-browser-tools && node demo.mjs"

echo ""
echo "======================================"

# ---------- 第六步：Stagehand ----------
echo ""
echo "【第6步】安装 Stagehand AI 浏览器 Agent..."
echo ""

npm install -g @browserbase/stagehand 2>/dev/null || {
  echo "⚠ Stagehand 全局安装失败（不影响核心功能）"
  echo "  可以在项目里单独安装：npm install @browserbase/stagehand"
}

echo ""
echo "======================================"
echo ""
echo "  全部安装完成！"
echo ""
echo "  快速开始："
echo "  1. 打开 Cursor → 用它写代码（AI 自动补全）"
echo "  2. 进入任意项目文件夹 → 运行 codex → 输入中文指令"
echo "  3. 浏览器自动化：cd ~/ai-browser-tools && node demo.mjs"
echo ""
echo "  详细文档：playbooks/05-mac-ai-dev-setup.md"
echo "======================================"
echo ""

# 让新的环境变量立刻生效
source ~/.zshrc 2>/dev/null || true
