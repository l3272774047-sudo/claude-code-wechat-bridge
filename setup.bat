@echo off
echo ============================================
echo   Claude Code WeChat Bridge - Setup (Win)
echo ============================================
echo.
echo This will install the wechat-bridge skill and dependencies.
echo.

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js is not installed. Please install Node.js 18+ from https://nodejs.org
    pause
    exit /b 1
)
echo [OK] Node.js found:
node --version

REM Check Claude Code
where claude >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [WARN] claude CLI not found in PATH. Make sure Claude Code is installed.
)

REM Determine skill destination
set "SKILL_DEST=%USERPROFILE%\.claude\skills\wechat-bridge"
if exist ".claude\skills\wechat-bridge\SKILL.md" (
    set "SKILL_DEST=.claude\skills\wechat-bridge"
    echo [INFO] Installing to project .claude/skills/
) else (
    echo [INFO] Installing to user .claude/skills/
)

REM Copy skill file
if not exist "%SKILL_DEST%" mkdir "%SKILL_DEST%"
copy /Y "skills\wechat-bridge\SKILL.md" "%SKILL_DEST%\SKILL.md"
echo [OK] Skill installed to %SKILL_DEST%

REM Verify npm packages
echo.
echo [INFO] Checking npm packages...
call npx weixin-acp --help >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo [OK] weixin-acp is available
) else (
    echo [WARN] weixin-acp may need to be installed (will auto-fetch on first run)
)

echo.
echo ============================================
echo   Setup complete!
echo.
echo   Quick start:
echo   1. Double-click scripts\switch-wechat-account.bat to login
echo   2. Double-click scripts\start-wechat-bridge.bat to start bridge
echo   3. Or in Claude Code, say: "启动桥连接"
echo ============================================
pause
