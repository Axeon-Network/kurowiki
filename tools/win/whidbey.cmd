@echo off

:: read the build tag file, then set it.
if exist resources\ruby\buildtag (
    for /f "tokens=4 delims=." %%a in (resources\ruby\buildtag) do (
        set raw_id=%%a
    )
) else (
    set raw_id=chk
)

:: check the current build status, then set it
echo %raw_id% | findstr /i "chk" >nul
if %errorlevel% equ 0 (
    set status=Chk
) else (
    echo %raw_id% | findstr /i "fre" >nul
    if %errorlevel% equ 0 (
        set status=Fre
    ) else (
        set status=Dmm
    )
)

:: we first get the lab via git rev-parse and then set it
for /f "tokens=*" %%i in ('git rev-parse --abbrev-ref HEAD 2^>nul') do set lab=%%i
:: if we dont have anything, we use the default panther lab manually
if "%lab%"=="" set lab=PANTHER_%username%

:: now we set the title
title Whidbey - Delta%status% of %lab% in %cd%

:: aliases
doskey dlt=bundle exec jekyll server -l -o --port 4500
doskey dnw=bundle exec jekyll server -l -o --no-watch --port 4500
doskey bni=bundle install
doskey hlp=call tools\whidbey_hlp.cmd
doskey dsv=bundle exec jekyll server --port 4500
doskey dbl=bundle exec jekyll build
doskey dcl=bundle exec jekyll clean
doskey dtr=git add .
doskey dcm=git commit -m $*
doskey dce=git commit -m $* -m $*
doskey dph=git push
doskey dpl=git pull