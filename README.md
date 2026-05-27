# Claude Code WeChat Bridge

> 让 Claude Code 接入微信，随时随地在微信里与 Claude 对话。

通过 [weixin-acp](https://www.npmjs.com/package/weixin-acp)（WeChat ↔ ACP 协议适配器）+ [claude-agent-acp](https://www.npmjs.com/package/claude-agent-acp)（ACP ↔ Claude Code 桥），将微信消息实时转发给 Claude Code，并自动回复。

## 效果

```
你 (微信)  →  "帮我分析一下这段代码"
                 ↓
       [微信机器人] → [weixin-acp] → [claude-agent-acp] → [Claude Code]
                 ↓
你 (微信)  ←  Claude 的分析结果
```

就像在微信里多了一个随时在线的 Claude 助手。

## 前置要求

- **Node.js** >= 18
- **Claude Code** 已安装（`npm install -g @anthropic-ai/claude-code`）
- 一部安装了微信的手机（用于扫码登录）

## 快速开始

### 1. 克隆 & 安装

```bash
git clone https://github.com/你的用户名/claude-code-wechat-bridge.git
cd claude-code-wechat-bridge
```

**Windows:**
```batch
setup.bat
```

**Mac/Linux:**
```bash
chmod +x setup.sh && ./setup.sh
```

setup 脚本会自动完成：
- 检查 Node.js 环境
- 将 wechat-bridge 技能安装到 Claude Code 的 skills 目录
- 验证 weixin-acp 是否可用

### 2. 首次登录（扫码）

第一次使用需要扫码登录微信：

**Windows:** 双击 `scripts\switch-wechat-account.bat`
**Mac/Linux:** 运行 `./scripts/switch-wechat-account.sh`

终端会出现二维码，用**微信扫一扫**扫码即可登录。

> **注意：** 这不是你的个人微信号，而是你的微信机器人/小号。建议使用专用微信号。

### 3. 启动桥接

**方式一：在 Claude Code 中说一句话**

```
启动桥连接
```

Claude Code 会自动在后台启动桥接进程。

**方式二：手动启动**

**Windows:** 双击 `scripts\start-wechat-bridge.bat`
**Mac/Linux:** 运行 `./scripts/start-wechat-bridge.sh`

看到 `[weixin] 启动 bot` 和 `[acp] connection initialized` 就表示成功了。

### 4. 开始对话

打开微信，找到你登录的机器人账号，直接发消息，Claude 就会回复你。

## 文件结构

```
claude-code-wechat-bridge/
├── README.md                       # 本文件
├── LICENSE                         # MIT
├── setup.bat / setup.sh            # 一键安装脚本
├── skills/
│   └── wechat-bridge/
│       └── SKILL.md                # Claude Code 技能定义
└── scripts/
    ├── start-wechat-bridge.bat/sh   # 启动桥接
    ├── switch-wechat-account.bat/sh # 切换/登录微信账号
    └── check-bridge.bat/sh          # 检查桥接运行状态
```

## 技能触发词

在 Claude Code 对话中说以下任意一个即可触发桥接：

| 触发词 | 效果 |
|--------|------|
| `启动桥连接` | 启动微信桥接 |
| `微信桥接` | 启动微信桥接 |
| `连接微信` | 启动微信桥接 |
| `微信对话` | 启动微信桥接 |
| `开启微信桥` | 启动微信桥接 |
| `启动微信桥` | 启动微信桥接 |

## 常见问题

### Q: 怎么确认桥接在运行？

运行检查脚本：

**Windows:** 双击 `scripts\check-bridge.bat`
**Mac/Linux:** 运行 `./scripts/check-bridge.sh`

正常应该看到 1 个 `weixin-acp` 进程和 1 个 `claude-agent-acp` 进程。

### Q: 桥接断了怎么办？

直接在 Claude Code 中再说一次"启动桥连接"，或手动重新运行启动脚本。

### Q: 想换一个微信号怎么办？

运行 `switch-wechat-account` 脚本，会依次执行：登出 → 扫码登录 → 重新启动桥接。

### Q: 会出现多条桥吗？

如果反复启动桥接但没有先停掉旧的，可能会出现多条桥，导致重复回复。运行 `check-bridge` 脚本检查，如果有多条进程，手动结束多余的即可。

### Q: 支持群聊吗？

视 weixin-acp 的功能而定。当前默认支持私聊，群聊行为取决于底层 SDK。

## 原理说明

```
┌──────────┐    ┌──────────────┐    ┌───────────────────┐    ┌─────────────┐
│  微信 App  │ ←→ │  weixin-acp  │ ←→ │  claude-agent-acp │ ←→ │  Claude Code │
│  (手机)   │    │  (ACP 适配器) │    │   (ACP Agent)      │    │  (终端/AI)   │
└──────────┘    └──────────────┘    └───────────────────┘    └─────────────┘
     ↑                   ↑                   ↑                    ↑
  ilink API        微信消息 ↔ ACP      ACP ↔ Claude API      Claude 推理
```

1. **weixin-acp** 通过微信 ilink API 接收/发送消息，并把消息转换为 ACP（Agent Client Protocol）协议
2. **claude-agent-acp** 接收 ACP 消息，转发给 Claude 进行推理
3. Claude 的回复沿原路返回：Claude → claude-agent-acp → weixin-acp → 微信

整个过程以 **npx 即时运行**，无需全局安装，不污染系统环境。

## 依赖

| 包名 | 版本 | 用途 |
|------|------|------|
| [weixin-acp](https://www.npmjs.com/package/weixin-acp) | ^0.6.0 | WeChat ↔ ACP 适配器 |
| [claude-agent-acp](https://www.npmjs.com/package/claude-agent-acp) | latest | ACP ↔ Claude Code Agent |
| [@agentclientprotocol/sdk](https://www.npmjs.com/package/@agentclientprotocol/sdk) | latest | ACP 协议 SDK |

所有依赖通过 `npx` 自动获取，无需手动安装。

## 许可

MIT License — 详见 [LICENSE](LICENSE)

## 致谢

- [weixin-acp](https://www.npmjs.com/package/weixin-acp) — WeChat ACP 适配器
- [claude-agent-acp](https://www.npmjs.com/package/claude-agent-acp) — Claude ACP Agent
- [Agent Client Protocol](https://github.com/zed-industries/acp) — 开放的 Agent 通信协议
