@echo off
setlocal

echo ============================================
echo   NOVA ADMIN UI - Publish to GitHub
echo ============================================
echo.
echo Repo destino: https://github.com/kolioty/p
echo.
set /p GH_TOKEN=Pega tu GitHub token (ghp_...) y presiona Enter:

if "%GH_TOKEN%"=="" (
    echo No pegaste ningun token. Cancelado.
    goto :end
)

cd /d "%~dp0"

if not exist ".git" (
    git init
    git checkout -b main
)

git add -A
git -c user.email="bot@nova-admin.local" -c user.name="nova-admin-bot" commit -m "Publish nova-admin-ui bundle (MPL-2.0, custom Midnight theme)"

git remote remove origin >nul 2>&1
git remote add origin "https://kolioty:%GH_TOKEN%@github.com/kolioty/p.git"

git push -u origin main

echo.
echo Quitando el token de la configuracion local del repo...
git remote set-url origin "https://github.com/kolioty/p.git"

set GH_TOKEN=

echo.
echo ============================================
echo Listo. Si el push funciono, tu archivo esta en:
echo https://raw.githubusercontent.com/kolioty/p/main/nova-admin-ui.lua
echo.
echo Ahora ve a https://github.com/settings/tokens y borra el token que usaste.
echo ============================================

:end
pause
