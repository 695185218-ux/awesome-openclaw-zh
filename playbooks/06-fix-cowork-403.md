# 修复 Cowork 403：Request not allowed

遇到这个报错说明 cowork 认证已失效，按以下步骤操作，5 分钟内可以恢复。

```
Failed to authenticate. API Error: 403
{"error":{"type":"forbidden","message":"Request not allowed"}}
```

---

## 先确认你的登录方式

不同登录方式，修复路径不同：

- **直接用 Claude 账号登录（Claude Plan）** → 看下方「Claude Plan 用户」章节
- **填入 API Key 登录** → 看下方「API Key 用户」章节

---

## Claude Plan 用户（直接登录，无 API Key）

### 第一步：退出重新登录（最常见解法）

1. 在 OpenClaw 点击右上角头像 → **Logout**
2. 清除浏览器 Cookie 和缓存（Chrome：设置 → 隐私和安全 → 清除浏览数据）
3. 重新登录 Claude 账号
4. 回到 cowork，重新发一条消息测试

### 第二步：重新授权 Cowork 连接

1. 进入 **Settings → Cowork**
2. 找到当前连接，点击 **Disconnect**
3. 等待 5 秒，点击 **Connect / Re-authorize**
4. 按提示重新完成 Claude 账号授权

### 第三步：确认 Claude Plan 包含 Cowork 功能

`Request not allowed` 有时表示当前套餐不支持 cowork：

- Claude Pro 和 Team 套餐支持 cowork
- Claude Free 套餐**不支持** cowork
- 进入 [claude.ai](https://claude.ai) → **Settings → Plan** 确认当前套餐

### 第四步：换浏览器或无痕模式测试

排除浏览器扩展干扰：

1. 用无痕/隐私窗口重新登录
2. 或换 Chrome / Firefox 等其他浏览器测试
3. 如果无痕可以用，说明是某个浏览器扩展在拦截请求（常见：广告拦截器、VPN 插件）

---

## API Key 用户

### 第一步：重新授权 Cowork 连接

1. 进入 OpenClaw 后台 → **Settings → Cowork**
2. 找到当前的 cowork 连接，点击 **Disconnect**
3. 等待 5 秒，再点击 **Connect / Re-authorize**
4. 完成授权后，重新发一条消息测试

### 第二步：检查 API Key 权限

1. 进入你的 AI 供应商后台（OpenAI / Anthropic 等）
2. 找到当前使用的 API Key → 查看 **权限/Permissions**
3. 确认协作相关权限已开启
4. 如不确定，生成新 Key 替换后重试

---

## 快速自查清单

| # | 我的情况 | 先做这个 |
|---|---|---|
| Claude Plan 直接登录 | 退出 → 清缓存 → 重登 |
| Claude Free 套餐 | 升级到 Pro/Team |
| API Key 登录 | 后台重新 Connect |
| 之前能用，突然不行 | 退出重登 + 重新授权 |
| 无痕模式能用 | 检查浏览器扩展 |

---

## 还是不行？

收集以下信息发给支持团队：

- 错误完整截图（包含错误码和消息）
- 登录方式（Claude 账号 / API Key）
- 你的套餐类型（Free / Pro / Team）
- 上次正常使用的时间

官方文档：https://docs.openclaw.ai/
