#!/bin/bash
echo "============================================"
echo "  Claude Code WeChat Bridge - Setup (Mac/Linux)"
echo "============================================"
echo ""

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "[ERROR] Node.js is not installed. Please install Node.js 18+ from https://nodejs.org"
    exit 1
fi
echo "[OK] Node.js found: $(node --version)"

# Check Claude Code
if ! command -v claude &> /dev/null; then
    echo "[WARN] claude CLI not found in PATH. Make sure Claude Code is installed."
else
    echo "[OK] Claude Code found"
fi

# Determine skill destination
if [ -f ".claude/skills/wechat-bridge/SKILL.md" ]; then
    SKILL_DEST=".claude/skills/wechat-bridge"
    echo "[INFO] Installing to project .claude/skills/"
else
    SKILL_DEST="$HOME/.claude/skills/wechat-bridge"
    echo "[INFO] Installing to user .claude/skills/"
fi

# Copy skill file
mkdir -p "$SKILL_DEST"
cp -f "skills/wechat-bridge/SKILL.md" "$SKILL_DEST/SKILL.md"
echo "[OK] Skill installed to $SKILL_DEST"

# Make scripts executable
chmod +x scripts/*.sh
echo "[OK] Scripts are now executable"

# Verify npm packages
echo ""
echo "[INFO] Checking npm packages..."
if npx weixin-acp --help &>/dev/null; then
    echo "[OK] weixin-acp is available"
else
    echo "[WARN] weixin-acp may need to be installed (will auto-fetch on first run)"
fi

echo ""
echo "============================================"
echo "  Setup complete!"
echo ""
echo "  Quick start:"
echo "  1. Run: ./scripts/switch-wechat-account.sh to login"
echo "  2. Run: ./scripts/start-wechat-bridge.sh to start bridge"
echo "  3. Or in Claude Code, say: 启动桥连接"
echo "============================================"
