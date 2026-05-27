@echo off
echo ===== Switch WeChat Account =====
echo.
echo 1. Logging out current account...
call npx weixin-acp logout
echo.
echo 2. Starting QR code login...
echo Open the link shown below in your phone browser, or scan the QR code in terminal with WeChat.
echo.
call npx weixin-acp login
echo.
echo 3. Starting bridge after login...
call npx weixin-acp start -- claude-agent-acp
echo.
echo ===== Bridge Started =====
pause
