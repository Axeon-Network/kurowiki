@echo off

:: read the build tag file, then set it.
if exist .\resources\ruby\buildtag (
    for /f "tokens=4 delims=." %%a in (.\resources\ruby\buildtag) do (
        set raw_id=%%a
    )
) else (
    set raw_id=chk
)

:: check the current build status, then set it
echo %raw_id% | findstr /i "chk" >nul
if %errorlevel% equ 0 (
    set status=Checked
) else (
    echo %raw_id% | findstr /i "fre" >nul
    if %errorlevel% equ 0 (
        set status=Free
    ) else (
        set status=STATUS_DUMMY
    )
)

:: we first get the lab via git rev-parse and then set it
for /f "tokens=*" %%i in ('git rev-parse --abbrev-ref HEAD 2^>nul') do set lab=%%i
:: if we dont have anything, we use the default panther lab manually
if "%lab%"=="" set lab=PANTHER_%username%

:: now we set the title
title Whidbey - %status% Akane from %lab% in %cd%

:: aliases
doskey akn=bundle exec jekyll server -l -o --port 4500
doskey akw=bundle exec jekyll server -l -o --no-watch --port 4500
doskey bni=bundle install
doskey hlp=call tools\win\whidbey_hlp.cmd
doskey aks=bundle exec jekyll server --port 4500
doskey akb=bundle exec jekyll build
doskey acl=bundle exec jekyll clean
doskey atr=git add .
doskey acm=git commit -m $*
doskey ace=git commit -m $* -m $*
doskey aps=git push
doskey apl=git pull