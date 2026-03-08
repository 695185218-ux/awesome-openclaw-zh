# Claude Code 桌面版 403 修复指南（Pro Plan 用户）

## 报错现象

```
Failed to authenticate. API Error: 403 {"error":{"type":"forbidden","message":"Request not allowed"}}
```

这是 Claude Pro 用户使用 Claude Code 桌面版最常见的报错。

---

## 根本原因

**Claude Pro 订阅 ≠ Anthropic API 访问权限。**

| 产品 | 用途 | 是否支持 Claude Code |
|---|---|---|
| Claude Pro（claude.ai）| 网页/App 对话 | 需要额外登录步骤 |
| Anthropic API Key | 开发者 API 调用 | 直接支持（需有余额） |

Claude Code 桌面版需要通过以下两种方式之一认证，**缺少任何一种都会 403**：

1. `claude login` — 通过 claude.ai OAuth 授权（推荐 Pro/Max 用户）
2. `ANTHROPIC_API_KEY` — 使用 console.anthropic.com 的 API Key（需单独开通计费）

---

## 修复步骤

### 方案 A：用 `claude login` 登录（Pro Plan 首选）

1. 打开终端（Terminal / 命令提示符）
2. 运行：
   ```bash
   claude login
   ```
3. 浏览器会自动打开，用你的 **claude.ai 账号**（即 Pro Plan 绑定的邮箱）登录
4. 授权完成后，回到终端，Claude Code 应该可以正常使用

> **注意**：如果之前设置过 `ANTHROPIC_API_KEY` 环境变量，可能会覆盖 OAuth 登录。
> 临时去掉它：
> ```bash
> unset ANTHROPIC_API_KEY   # macOS/Linux
> # 或在 Windows 系统环境变量中删除该变量
> ```

#### 遇到 401 "OAuth token has expired"？

OAuth token 有有效期，过期后需要重新登录。解决方法：

```bash
claude login
```

或在 Claude Code 界面内输入：

```
/login
```

重新授权一次即可获得新 token。**这不是 Pro 账号的问题，只是 token 自然失效，重新登录就好。**

---

### 方案 B：使用 API Key（开发者路线）

如果你需要在自动化脚本、OpenClaw cowork 中使用，必须用 API Key：

1. 访问 [console.anthropic.com](https://console.anthropic.com/)
2. 注册或登录（**与 claude.ai 账号独立**）
3. 进入 **Billing** → 添加支付方式并充值（最低 $5）
4. 进入 **API Keys** → 创建新 Key
5. 复制 Key（格式：`sk-ant-api03-...`）
6. 设置环境变量：
   ```bash
   export ANTHROPIC_API_KEY=sk-ant-api03-你的key  # macOS/Linux
   # 或在 Windows 系统环境变量中添加 ANTHROPIC_API_KEY
   ```
7. 重启 Claude Code 桌面版

---

## Cowork（多 Bot 协作）专项排查

Cowork 403 最常见原因：

| 原因 | 解法 |
|---|---|
| 某个 Bot 未配置有效 API Key | 每个参与 cowork 的 Bot 都需要独立的 API Key |
| API Key 余额为零 | 在 console.anthropic.com 充值 |
| OAuth Token 不支持 cowork | cowork 场景必须使用 API Key，不能用 OAuth 登录 |
| 多实例共用同一 Session Token | 每个实例需要独立认证，不能共享 |

**Cowork 正确配置方式：**

```
Bot A: ANTHROPIC_API_KEY=sk-ant-api03-xxxxxx（独立Key，有余额）
Bot B: ANTHROPIC_API_KEY=sk-ant-api03-yyyyyy（独立Key，有余额）
```

> Pro Plan 的 OAuth 登录仅适合单用户交互使用，**不适合 cowork 自动化场景**。

---

## 快速自查清单

遇到 Claude Code 403，按顺序检查：

- [ ] 是否运行过 `claude login`？（未登录直接报 403）
- [ ] 是否误设了无效的 `ANTHROPIC_API_KEY`？（格式错误或已过期）
- [ ] API Key 余额是否充足？（在 console.anthropic.com 确认）
- [ ] 如果是 cowork：每个 Bot 是否都有**独立**的有效 API Key？
- [ ] 网络是否可以访问 `api.anthropic.com`？（部分地区需要代理）

---

## 相关参考

- [常见错误排查（403等）](./03-fix-common-errors.md)
- [低成本稳定运行](./01-low-cost-stable-run.md)
- [安全与权限边界](./02-safe-usage-boundary.md)
