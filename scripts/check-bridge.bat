@echo off
echo === Bridge Process Check ===
tasklist 2>nul | findstr /i "weixin-acp claude-agent-acp"
echo.
echo If there are more than 2 lines of weixin-acp or claude-agent-acp, multiple bridges are running.
echo Only one line each is normal.
pause
