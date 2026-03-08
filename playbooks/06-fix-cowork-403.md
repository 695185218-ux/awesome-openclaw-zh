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

> 如果你用的是**桌面客户端**（Chat + Code + Cowork 三合一），按下方桌面版步骤操作。
> 如果是**浏览器网页版**，按网页版步骤操作。

---

### 桌面客户端

#### 第一步：退出重新登录

1. 点击应用内头像或菜单 → **Logout / 退出登录**
2. 完全退出应用（Quit，不只是关窗口）
3. 重新打开应用，重新登录 Claude 账号
4. 回到 Cowork，重新发一条消息测试

#### 第二步：清除应用本地数据

如果重登后仍报 403，说明本地缓存的 Token 已失效：

- **macOS**：在 Finder 按 `Cmd+Shift+G`，进入 `~/Library/Application Support/`，找到应用文件夹，删除其中的 `Cache` 或 `Session` 目录
- **Windows**：进入 `%APPDATA%\` 或 `%LOCALAPPDATA%\`，找到应用文件夹，删除 Cache 目录
- 删除后重新启动应用并登录

#### 第三步：重新授权 Cowork 连接

1. 进入 **Settings → Cowork**
2. 找到当前连接，点击 **Disconnect**
3. 等待 5 秒，点击 **Connect / Re-authorize**
4. 按提示重新完成 Claude 账号授权

#### 第四步：确认 Claude Plan 包含 Cowork 功能

- Claude Pro 和 Team 套餐支持 cowork
- Claude Free 套餐**不支持** cowork
- 进入 [claude.ai](https://claude.ai) → **Settings → Plan** 确认当前套餐

---

### 网页版

#### 第一步：退出重新登录

1. 在 OpenClaw 点击右上角头像 → **Logout**
2. 清除浏览器 Cookie 和缓存（Chrome：设置 → 隐私和安全 → 清除浏览数据）
3. 重新登录 Claude 账号

#### 第二步：重新授权 Cowork 连接

同桌面版第三步。

#### 第三步：换浏览器或无痕模式测试

如果无痕窗口能用，说明是浏览器扩展在拦截（广告屏蔽插件、VPN 插件最常见）。

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
| Claude Plan 桌面客户端 | 退出 → 完全关闭应用 → 重登 |
| Claude Plan 网页版 | 退出 → 清浏览器缓存 → 重登 |
| Claude Free 套餐 | 升级到 Pro/Team |
| API Key 登录 | 后台重新 Connect |
| 之前能用，突然不行 | 退出重登 + 重新授权 |
| 网页版无痕模式能用 | 检查浏览器扩展 |

---

## 还是不行？

收集以下信息发给支持团队：

- 错误完整截图（包含错误码和消息）
- 登录方式（Claude 账号 / API Key）
- 你的套餐类型（Free / Pro / Team）
- 上次正常使用的时间

官方文档：https://docs.openclaw.ai/
