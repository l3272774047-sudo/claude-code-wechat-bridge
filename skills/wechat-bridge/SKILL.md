---
name: wechat-bridge
description: "启动微信-Claude Code 桥接，让用户可以通过微信与 Claude 对话。触发词：启动桥连接、微信桥接、连接微信、微信对话。"
license: MIT
metadata: {}
---

# WeChat Bridge for Claude Code

在后台启动 `npx weixin-acp claude-code`，将微信消息桥接到 Claude Code。

## 触发条件

当用户说以下内容时激活此 skill：
- "启动桥连接"
- "微信桥接"
- "连接微信"
- "微信对话"
- "开启微信桥"
- "启动微信桥"

## 执行步骤

1. 在后台启动桥接进程（使用 `run_in_background`，timeout 设为 600000ms）：

```bash
npx weixin-acp claude-code
```

2. 等待约 5 秒后检查输出，确认桥接是否成功启动（关键日志：`[weixin] 启动 bot` 和 `[acp] connection initialized`）。

3. 向用户报告状态：Bot 是否启动、微信账号、是否已有新会话。
