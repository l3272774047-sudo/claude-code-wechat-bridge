#!/bin/bash
echo "=== Bridge Process Check ==="
ps aux | grep -i "weixin-acp\|claude-agent-acp" | grep -v grep
echo ""
echo "If there are multiple lines, multiple bridges are running."
echo "One or two lines (weixin-acp + claude-agent-acp) is normal."
