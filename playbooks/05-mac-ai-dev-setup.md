# Mac AI 开发环境完整搭建指南（2026版）

适合：想在 Mac 上搭建一套 AI 自动改代码 + 浏览器自动操作的完整环境。
目标：接近甚至超过 Claude Desktop + Claude Code + Cowork 的体验。

---

## 你将拥有什么能力

| 能力 | 工具 |
|---|---|
| AI 读整个项目、自动改代码 | Codex CLI |
| AI 协作写代码、多文件重构 | Cursor IDE |
| 随时呼出 AI 助手 | ChatGPT 桌面版 |
| 浏览器自动操作（抓数据/填表单） | Playwright |
| AI 自己点网页做任务 | Stagehand |

---

## 第一步：装好基础工具

打开 Mac 的 **Terminal**（终端），把下面几条命令依次粘贴进去，按回车。

### 1-1. 安装 Homebrew（Mac 软件管理器）

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

安装完成后验证：

```bash
brew -v
```

有版本号输出就成功了。

---

### 1-2. 安装 Node.js（AI 工具的运行基础）

```bash
brew install node
```

验证：

```bash
node -v
npm -v
```

---

### 1-3. 安装 Git（代码版本管理）

```bash
brew install git
```

---

## 第二步：安装 ChatGPT 桌面版

1. 打开浏览器，访问：**https://chatgpt.com/download**
2. 下载并安装
3. 登录你的 OpenAI / ChatGPT Plus 账号

安装完成后你会得到：

- 系统级 AI 助手
- 快捷键 `Option + Space` 随时呼出
- 无需每次打开浏览器

**常见用途：**

- 写小红书文案、视频脚本、标题
- 写菜单介绍、活动策划、外卖详情页
- 规划任务、解释代码、设计架构

---

## 第三步：安装 Codex CLI（AI 自动改代码）

这是最接近 Claude Code 的工具，可以读整个项目并自动修改代码。

### 安装

```bash
npm install -g @openai/codex
```

验证：

```bash
codex --version
```

### 配置 API Key

```bash
# 替换成你自己的 Key（从 platform.openai.com 获取）
export OPENAI_API_KEY="sk-xxxxxxxxxxxxxxxx"
```

写入配置文件让它永久生效（zsh 用户，Mac 默认是 zsh）：

```bash
echo 'export OPENAI_API_KEY="sk-xxxxxxxxxxxxxxxx"' >> ~/.zshrc
source ~/.zshrc
```

### 在项目里使用

进入你的项目文件夹：

```bash
cd 你的项目路径
codex
```

示例输入（中文即可）：

```
分析整个项目架构
找出性能瓶颈
自动修复所有 eslint 错误
```

Codex 会自动读取整个 repo、修改多个文件、运行命令、生成改动记录。

### Agent 模式（最像 Cowork）

```bash
codex --agent
```

Agent 模式可以连续执行：修改代码 → 运行测试 → 再修复错误，全程自动。

---

## 第四步：安装 Cursor IDE（强烈推荐）

很多 AI 开发者已经从 VS Code 切换到 Cursor。

1. 打开浏览器，访问：**https://cursor.sh**
2. 下载并安装

打开项目后，Cursor 会自动提供：

- AI 自动改代码（Tab 补全）
- 多文件重构
- 自动运行终端命令
- 生成 commit 信息

体验非常接近 Claude Cowork。

---

## 第五步：安装 Playwright（浏览器自动操作）

Playwright 可以让 AI 控制浏览器，自动点击、填写表单、抓取数据。

### 安装

```bash
npm install playwright
```

初始化浏览器驱动：

```bash
npx playwright install
```

### 示例脚本

新建一个文件 `auto.mjs`，粘贴以下内容：

```javascript
import { chromium } from "playwright";

const browser = await chromium.launch({ headless: false }); // headless: false 可以看到浏览器操作
const page = await browser.newPage();

await page.goto("https://google.com");
await page.fill("input[name=q]", "MacBook Pro 评测");
await page.press("input[name=q]", "Enter");

console.log("搜索完成");
await browser.close();
```

运行：

```bash
node auto.mjs
```

**可以用来做什么：**

- 自动抓数据（竞品价格、评论）
- 自动登录网站
- 自动提交表单
- 自动做网页任务

---

## 第六步：安装 Stagehand（AI 自己点网页）

Stagehand 是更高级的浏览器 AI Agent，可以直接用自然语言描述操作。

```bash
npm install -g @browserbase/stagehand
```

示例任务：

```
打开亚马逊
搜索 MacBook
提取评分最高的10个商品名称和价格
```

AI 会自动执行浏览器操作，不需要你写代码。

---

## 完整工作流示例

进入项目：

```bash
codex --agent
```

输入：

```
分析整个项目
列出技术债
制定重构计划
分步骤执行，每步完成后运行测试
```

AI 会自动：

1. 扫描 repo
2. 规划修改
3. 自动改代码
4. 运行测试
5. 修复错误

---

## 高级技巧：让 AI 自己生成任务列表

输入：

```
把这个项目当成一个初创产品
做一次完整 code audit
自动修复最重要的10个问题
```

AI 会分析架构 → 生成任务 → 自动改代码。

---

## 一键安装脚本（第3步到第6步）

不想一条条复制命令？直接运行这个脚本：

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/your-org/awesome-openclaw-zh/main/quickstart/mac-ai-setup.sh)
```

或者下载脚本后运行：

```bash
# 下载脚本
curl -O https://raw.githubusercontent.com/your-org/awesome-openclaw-zh/main/quickstart/mac-ai-setup.sh

# 运行
bash mac-ai-setup.sh
```

脚本会自动完成：Codex CLI 安装 → API Key 配置 → Cursor IDE → Playwright → Stagehand

---

## 遇到问题？

| 报错 | 原因 | 解法 |
|---|---|---|
| `command not found: codex` | npm 全局路径未加入 PATH | 执行 `export PATH="$PATH:$(npm bin -g)"` |
| `Invalid API key` | Key 未设置或格式错误 | 检查 `OPENAI_API_KEY` 环境变量 |
| `brew: command not found` | Homebrew 未安装或路径未加载 | 重新按第一步安装 |

更多排查 → [常见错误排查](./03-fix-common-errors.md)
