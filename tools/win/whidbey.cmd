@echo off
:: Route straight to help if called by the hlp alias
if "%1"=="show_help" goto show_help

setlocal enabledelayedexpansion

cls
echo Microsoft Windows with Axeon Whidbey Development Environment
echo Copyright (c) Microsoft Corp. Portions (c) Axeon Network.

:: read the build tag file, then set it.
if exist ".\resources\ruby\buildtag" (
    for /f "tokens=5 delims=." %%a in (.\resources\ruby\buildtag) do (
        set "raw_id=%%a"
    )
) else (
    set "raw_id=chk"
)

:: Clean up any accidental spaces around raw_id
set "raw_id=%raw_id: =%"

:: check if raw_id CONTAINS chk or fre anywhere inside it
echo %raw_id% | findstr /i "chk" >nul
if %errorlevel% equ 0 (
    set "status=Checked"
) else (
    echo %raw_id% | findstr /i "fre" >nul
    if %errorlevel% equ 0 (
        set "status=Retail"
    ) else (
        set "status=Debug?"
    )
)

:: we first get the lab via git rev-parse and then set it
for /f "tokens=*" %%i in ('git rev-parse --abbrev-ref HEAD 2^>nul') do set lab=%%i
:: if we dont have anything, we use the default panther lab manually
if "%lab%"=="" set lab=PANTHER_%username%

:: now we set the title
title Axeon Whidbey ~ Akn %status% from DevLab %lab% inside %cd%

:: aliases (Calling this script with 'show_help' routes to the help menu)
doskey hlp="%~f0" show_help
doskey akn=bundle exec jekyll server -l -o -H 127.0.0.50
doskey akw=bundle exec jekyll server -l -o --no-watch -H 127.0.0.50
doskey bni=bundle install
doskey aks=bundle exec jekyll server -H 127.0.0.50
doskey akb=bundle exec jekyll build
doskey acl=bundle exec jekyll clean
doskey trk=git add .
doskey cmt=git commit -m $*
doskey cme=git commit -m $* -m $*
doskey psh=git push
doskey pul=git pull

:: end localization safely WITHOUT destroying the doskeys
endlocal & set "status=%status%"& set "lab=%lab%"
exit /b

:show_help
echo.
echo Axeon Whidbey Version 2.0a for Microsoft(R) Windows(R)
echo Copyright 2026 KitSixtyFour. For internal Axeon use only
echo.
echo.
echo Commands:
echo           bni               - install missing gems via bundler
echo           akn               - run Akane normally
echo           akw               - run Akane WITHOUT regeneration
echo           aks               - run Akane WITHOUT LiveReload or OpenURL
echo           akb               - build the site without a server
echo           acl               - clean site leftovers (such as _site)
echo           trk               - track ALL files for git
echo           cmt "arg"         - commit current work. "arg" is the title of the
echo                               commit, do not skip the quotation marks or else it
echo                               WONT work!
echo           cme "arg" "arg2"  - same as cmt but "arg2" is an extended description
echo                               of the commit
echo           pul               - pull changes from github
echo           psh               - push work to github
echo           hlp               - print this message
exit /b