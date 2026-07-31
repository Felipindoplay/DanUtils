@echo off
title Upload para o GitHub - DanUtils
color 0B

echo =========================================================
echo       ENVIO DOS ARQUIVOS PARA O GITHUB (DANUTILS)
echo =========================================================
echo.

:: 1. Verifica se o Git está instalado no PC
where git >nul 2>nul
if %errorlevel% neq 0 (
    color 0C
    echo [ERRO] O Git nao foi encontrado no seu computador!
    echo Baixe e instale em: https://git-scm.com/downloads
    goto :FIM
)

echo [1/5] Inicializando o repositorio Git na pasta...
git init
echo.

echo [2/5] Renomeando a branch principal para 'main'...
git branch -M main
echo.

echo [3/5] Adicionando todos os arquivos da pasta...
git add .
echo.

echo [4/5] Criando o commit inicial...
git commit -m "feat: Envio inicial do projeto DanUtils (Catppuccin Mocha)"
echo.

echo [5/5] Conectando ao seu repositorio no GitHub...
git remote remove origin >nul 2>nul
git remote add origin https://github.com/Felipindoplay/DanUtils.git
echo.

echo =========================================================
echo TODOS OS ARQUIVOS FORAM PREPARADOS!
echo Pressione qualquer tecla para enviar (PUSH) ao GitHub...
echo =========================================================
pause >nul

echo.
echo Enviando arquivos para a nuvem...
git push -u origin main --force

:FIM
echo.
echo =========================================================
echo Processo finalizado! Se houver erro de login/permissao
echo acima, verifique sua conta do GitHub no Windows.
echo =========================================================
pause