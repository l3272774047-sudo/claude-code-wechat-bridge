#!/bin/bash
echo "===== Switch WeChat Account ====="
echo ""
echo "1. Logging out current account..."
npx weixin-acp logout
echo ""
echo "2. Starting QR code login..."
echo "Open the link shown below in your phone browser, or scan the QR code in terminal with WeChat."
echo ""
npx weixin-acp login
echo ""
echo "3. Starting bridge after login..."
npx weixin-acp start -- claude-agent-acp
echo ""
echo "===== Bridge Started ====="
