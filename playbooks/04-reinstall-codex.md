# 重新安装 Codex（完整指南）

如果你的 Codex 出现异常、报错频繁或配置损坏，重装是最干净的解决方法。

## 什么时候需要重装？

- 升级后出现不兼容报错
- 配置文件损坏无法启动
- 依赖库冲突导致功能异常
- 长期未更新，版本落后太多

---

## 第一步：彻底卸载旧版本

### 如果通过 npm 安装

```bash
npm uninstall -g @openai/codex
```

### 如果通过其他方式安装，清理残留文件

```bash
# 清理全局缓存
npm cache clean --force

# 检查是否还有残留
which codex
# 如果仍有输出，手动删除该路径下的文件
```

---

## 第二步：清理配置文件（可选但推荐）

```bash
# macOS / Linux
rm -rf ~/.codex

# Windows（PowerShell）
Remove-Item -Recurse -Force "$env:USERPROFILE\.codex"
```

> 注意：这会清除你的本地历史和配置。如果需要保留，先备份 `~/.codex` 目录。

---

## 第三步：重新安装 Codex

```bash
npm install -g @openai/codex
```

安装完成后验证：

```bash
codex --version
```

---

## 第四步：重新配置

### 设置 API Key

```bash
export OPENAI_API_KEY="sk-xxxxxxxxxxxxxxxx"
```

建议写入 shell 配置文件（永久生效）：

```bash
# bash 用户
echo 'export OPENAI_API_KEY="sk-xxxxxxxxxxxxxxxx"' >> ~/.bashrc
source ~/.bashrc

# zsh 用户
echo 'export OPENAI_API_KEY="sk-xxxxxxxxxxxxxxxx"' >> ~/.zshrc
source ~/.zshrc
```

### 验证配置是否生效

```bash
codex "写一个 hello world 的 Python 脚本"
```

---

## 常见重装后报错

| 报错信息 | 原因 | 解法 |
|---|---|---|
| `command not found: codex` | npm 全局路径未加入 PATH | 将 `npm bin -g` 的输出路径加入 PATH |
| `Invalid API key` | API Key 未设置或格式错误 | 重新检查 `OPENAI_API_KEY` 环境变量 |
| `permission denied` | npm 全局目录权限不足 | 用 `sudo` 安装或修复 npm 权限 |
| `EACCES: permission denied` | 同上 | 参考 npm 官方文档修复权限 |

### 修复 npm 全局路径问题

```bash
# 查看当前全局安装路径
npm bin -g

# 将路径加入 PATH（以 /usr/local/bin 为例）
export PATH="$PATH:$(npm bin -g)"
```

---

## 在 OpenClaw 中重新接入 Codex

重装完成后，如果你在 OpenClaw 中使用了 Codex 相关的 Skill 或工作流：

1. 进入 OpenClaw 后台 → **Skills**
2. 找到 Codex 相关 Skill，点击**重新授权**
3. 更新 API Key（如果更换了新 Key）
4. 测试一条简单指令确认连通

---

## 还是有问题？

- 查看 OpenClaw 官方文档：https://docs.openclaw.ai/
- 参考 [常见错误排查](./03-fix-common-errors.md)
- 到社区提问时，贴上：你的操作系统 + Node.js 版本（`node -v`）+ 报错完整信息
