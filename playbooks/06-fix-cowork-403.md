# 修复 Cowork 403：Request not allowed

遇到这个报错说明 cowork 认证已失效，按以下步骤操作，5 分钟内可以恢复。

```
Failed to authenticate. API Error: 403
{"error":{"type":"forbidden","message":"Request not allowed"}}
```

---

## 第一步：重新授权 Cowork 连接（最常见原因）

1. 进入 OpenClaw 后台 → **Settings → Cowork**
2. 找到当前的 cowork 连接，点击 **Disconnect**
3. 等待 5 秒，再点击 **Connect / Re-authorize**
4. 完成授权后，重新发一条消息测试

> 大多数情况下，这一步就能解决。

---

## 第二步：检查 API Key 是否有 Cowork 权限

部分 API Key 默认不开启 cowork 功能：

1. 进入你的 AI 供应商后台（OpenAI / Anthropic 等）
2. 找到当前使用的 API Key → 查看 **权限/Permissions**
3. 确认 **"Allow API access"** 和相关协作权限已开启
4. 如果不确定，生成一个新的 API Key，在 OpenClaw 中替换后重试

---

## 第三步：清除本地会话缓存

认证 Token 可能已过期但未自动刷新：

1. 退出 OpenClaw 账号（Logout）
2. 清除浏览器缓存 / 或删除客户端本地数据
3. 重新登录
4. 重新配置 cowork 连接

---

## 第四步：确认 Cowork 对端 Bot 也有权限

多人/多 Bot 协作时，**每一方**都需要独立授权：

- 检查对端 Bot 是否绑定了有效 API Key
- 检查对端 Bot 是否对共享资源（Google Drive、Notion 等）有访问权限
- 如果使用共享 Workspace，确认对端账号已接受邀请

---

## 第五步：检查账号套餐是否支持 Cowork

`Request not allowed` 有时表示当前套餐不包含 cowork 功能：

- 进入 OpenClaw 后台 → **Billing / Plan**
- 确认你的套餐包含 **Cowork / Multi-agent** 功能
- 如果不包含，升级套餐或联系支持

---

## 快速自查清单

遇到 cowork 403 时，按顺序检查：

| # | 检查项 | 操作 |
|---|---|---|
| 1 | Cowork 连接是否授权 | 后台重新 Connect |
| 2 | API Key 权限是否足够 | 供应商后台确认 / 换新 Key |
| 3 | 本地缓存是否过期 | 退出重登，清除缓存 |
| 4 | 对端 Bot 是否也有权限 | 逐一检查协作方授权 |
| 5 | 套餐是否支持 Cowork | Billing 页面确认 |

---

## 还是不行？

收集以下信息发给支持团队或社区：

- 错误完整截图（包含错误码和消息）
- 你的套餐类型
- cowork 的使用场景（几个 Bot？用了哪些 Skill？）
- 上次正常使用的时间

社区提问：参考 [贡献指南](../CONTRIBUTING.md)
官方文档：https://docs.openclaw.ai/
