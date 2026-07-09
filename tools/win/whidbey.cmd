:: Axeon Whidbey Environment Framework for Microsoft Windows DOS/NT
:: Copyright 2026 KitSixtyFour. For internal Axeon use only.

@echo off
:: Capture the true script path immediately before any argument shifting happens
set "WhdScript=%~f0"

:: Route straight to internal hooks if called by aliases
if "%1"=="show_help" goto show_help
if "%1"=="run_prep" goto run_prep
if "%1"=="run_akn" goto run_akn
if "%1"=="run_commit" goto run_commit

setlocal enabledelayedexpansion

for /f "tokens=*" %%i in ('ver') do set "winver=%%i"
set "winver=%winver:[=%"
set "winver=%winver:]=%"

cls
echo %winver%
echo Axeon Whidbey Development Environment Version 4.0
echo Copyright (c) Microsoft Corp. Portions (c) Axeon Network.
echo.

:: Initialize default environment properties
set "WhdPrivateBuild=no"
set "WhdIsDeltaEnabled=yes"
set "WhdBuildType="

:: Loop through command line arguments in any order
:arg_loop
if "%~1"==" " goto end_arg_loop
if "%~1"=="" goto end_arg_loop
set "arg=%~1"
if /i "!arg!"=="checked" set "WhdBuildType=chk"
if /i "!arg!"=="free" set "WhdBuildType=fre"
if /i "!arg!"=="private" set "WhdPrivateBuild=yes"
if /i "!arg!"=="nodelta" set "WhdIsDeltaEnabled=no"
shift /1
goto arg_loop
:end_arg_loop

:: If no build type parameter was passed, default it safely to checked
if "!WhdBuildType!"=="" set "WhdBuildType=chk"

:: Translate build type to readable status name
if "!WhdBuildType!"=="chk" (
    set "status=Checked"
) else (
    set "status=Retail"
)

:: Read current branch lab properties via Git
for /f "tokens=*" %%i in ('git rev-parse --abbrev-ref HEAD 2^>nul') do set "lab=%%i"
if "%lab%"=="" set "lab=PANTHER_%username%"

title Axeon Whidbey ~ Akn !status! from DevLab !lab! inside %cd%

call :load_config

set /p "start_sync=Would you like to sync Akane with AxeonMedia? (Y/N): "
if /i "!start_sync!"=="Y" (
    call :ensure_paths
    echo.
    echo Copying assets...
    xcopy "!AkaneSource!\!SourceMedia!\*" "!AxeonMedia!\kuro\img\" /y /e /i /q
    xcopy "!AkaneSource!\!SourceArticles!\*" "!AxeonMedia!\kuro\articles\" /y /e /i /q
    echo Workspace sync completed safely.
    echo.
)

:: Register Doskey Aliases using the protected path variable
doskey whelp="%WhdScript%" show_help
doskey prep="%WhdScript%" run_prep
doskey bninst=bundle install
doskey akn="%WhdScript%" run_akn $*
doskey track=git add .
doskey commit="%WhdScript%" run_commit $*
doskey pull=git pull
doskey push=git push

endlocal & set "status=%status%" & set "lab=%lab%" & set "WhdBuildType=%WhdBuildType%" & set "WhdPrivateBuild=%WhdPrivateBuild%" & set "WhdIsDeltaEnabled=%WhdIsDeltaEnabled%" & set "AkaneSource=%AkaneSource%" & set "AxeonMedia=%AxeonMedia%" & set "SourceArticles=%SourceArticles%" & set "SourceMedia=%SourceMedia%"
exit /b


:load_config
if exist "whidbey.ini" (
    set "cur_sec="
    for /f "usebackq tokens=*" %%L in ("whidbey.ini") do (
        set "line=%%L"
        set "line_start=!line:~0,1!"
        if "!line_start!"=="[" (
            set "cur_sec=!line!"
        ) else if not "!line_start!"=="#" (
            for /f "tokens=1,2 delims==" %%A in ("!line!") do (
                set "key=%%A"
                set "val=%%B"
                set "key=!key: =!"
                if "!cur_sec!"=="[AxeonAkane]" (
                    if "!key!"=="ArticlePath" set "SourceArticles=!val!"
                    if "!key!"=="ImgPath" set "SourceMedia=!val!"
                    if "!key!"=="SourcePath" set "AkaneSource=!val!"
                )
                if "!cur_sec!"=="[AxeonMedia]" (
                    if "!key!"=="SourcePath" set "AxeonMedia=!val!"
                )
            )
        )
    )
)
exit /b


:save_config
(
echo :: AXEONWHIDBEY4
echo [AxeonAkane]
echo ArticlePath=!SourceArticles!
echo ImgPath=!SourceMedia!
echo SourcePath=!AkaneSource!
echo.
echo [AxeonMedia]
echo SourcePath=!AxeonMedia!
) > "whidbey.ini"
exit /b


:ensure_paths
set "paths_ok=Y"
if "!AxeonMedia!"=="" set "paths_ok=N"
if "!AkaneSource!"=="" set "paths_ok=N"
if "!SourceArticles!"=="" set "paths_ok=N"
if "!SourceMedia!"=="" set "paths_ok=N"

if "!paths_ok!"=="Y" (
    echo.
    echo Whidbey has found the following configuration saved on your computer:
    echo   AxeonMedia = !AxeonMedia!
    echo   AkaneSource = !AkaneSource!
    echo   SourceArticles = !SourceArticles!
    echo   SourceMedia = !SourceMedia!
    echo.
    set /p "chk_reply=Is this configuration correct? (Y/N): "
    if /i "!chk_reply!"=="Y" exit /b
)

echo.
set /p "AxeonMedia=Where is the AxeonMedia repository located (relative or absolute path)? "
set /p "is_curr=Is the current directory (%cd%) a valid Axeon Akane source packet? (Y/N): "
if /i "!is_curr!"=="Y" (
    set "AkaneSource=%cd%"
) else (
    set /p "AkaneSource=Where is the Axeon Akane source code located (relative or absolute path)? "
)
set /p "SourceArticles=On the Axeon Akane source code, in what path are the article files located (relative or absolute path)? "
set /p "SourceMedia=On the Axeon Akane source code, in what path are the article images located? "

call :save_config
exit /b


:run_prep
setlocal enabledelayedexpansion
call :load_config
call :ensure_paths

echo.
xcopy "!AkaneSource!\!SourceMedia!\*" "!AxeonMedia!\kuro\img\" /y /e /i
xcopy "!AkaneSource!\!SourceArticles!\*" "!AxeonMedia!\kuro\articles\" /y /e /i

pushd "!AkaneSource!"
git add .
set /p "AknCommitName=What would you like to name your commit for Akane? "
set /p "akn_desc_yn=Would you like to add a description to your commit? (Y/N): "
if /i "!akn_desc_yn!"=="Y" (
    set /p "AknCommitDesc=Enter the commit description: "
    git commit -m "!AknCommitName!" -m "!AknCommitDesc!"
) else (
    git commit -m "!AknCommitName!"
)
git push
popd

pushd "!AxeonMedia!"
git add .
set /p "MdaCommitName=What would you like to name your commit for AxeonMedia? "
set /p "mda_desc_yn=Would you like to add a description to your commit? (Y/N): "
if /i "!mda_desc_yn!"=="Y" (
    set /p "MdaCommitDesc=Enter the commit description: "
    git commit -m "!MdaCommitName!" -m "!MdaCommitDesc!"
) else (
    git commit -m "!MdaCommitName!"
)
git push
popd

:: clean it just in case
set "AknCommitName="
set "AknCommitDesc="
set "MdaCommitName="
set "MdaCommitDesc="

echo.
echo Done.
endlocal
exit /b


:run_akn
setlocal enabledelayedexpansion
set "flag=%~2"
if /i "!flag!"=="-nW" (
    bundle exec jekyll server -l -o --no-watch -H 127.0.0.50
) else if /i "!flag!"=="-nA" (
    bundle exec jekyll server -H 127.0.0.50
) else if /i "!flag!"=="-nS" (
    bundle exec jekyll build
) else if /i "!flag!"=="-cl" (
    bundle exec jekyll clean
) else (
    set "raw_args=%*"
    set "forward_args=!raw_args:*run_akn=!"
    bundle exec jekyll server -l -o -H 127.0.0.50 !forward_args!
)
endlocal
exit /b


:run_commit
if "%~3"=="" (
    git commit -m %2
) else (
    git commit -m %2 -m %3
)
exit /b


:show_help
echo.
echo Axeon Whidbey Version 4.0 for Microsoft(R) Windows(R)
echo Copyright 2026 KitSixtyFour. For internal Axeon use only
echo.
echo.
echo Commands:
echo           bninst               - install missing gems via bundler
echo           akn                  - run Akane normally
echo           akn -nW              - run Akane WITHOUT regeneration
echo           akn -nA              - run Akane WITHOUT LiveReload or OpenURL
echo           akn -nS              - build the site without a server
echo           akn -cl              - clean site leftovers (such as _site)
echo           prep                 - transfer updated files and push commits to git
echo           track                - track ALL files for git
echo           commit "arg"         - commit current work.
echo           commit "arg" "arg2"  - same as commit but "arg2" is an extended description
echo           pull                 - pull changes from github
echo           push                 - push work to github
echo           whelp                - print this message
exit /b