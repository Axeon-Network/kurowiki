:: Axeon Whidbey Environment Framework for Microsoft Windows
:: Copyright 2026 KitSixtyFour. For internal Axeon use only.

@echo off
set "WhdScript=%~f0"

set "WhdVersion=5"
set "WhdVersionNoEx=%WhdVersion%.0"
set "WhdVersionFloat=%WhdVersionNoEx%1"
set "WhdVersionBuild=2202"
set "WhdVersionBuildEx=%WhdVersionBuild%.main.260919-1444"
set "WhdVersionMode=DeveloperInterim"
set "WhdDevPhs=Interim Developer Release "
set "WhdVersionComp=%WhdVersionFloat%.%WhdVersionBuildEx%"

set "WhdMagicKey=AXEONWHIDBEY%WhdVersion%"
set "WhdMagicNumber=2F02"

set "WhdConfigHeader=%WhdMagicKey%:::%WhdMagicNumber%"


rem We set them here because um, yeah...
set "WhdPrivateBuild=no"
set "WhdIsDeltaEnabled=yes"

if "%~1"=="" goto :show_usage

if not "%~1"=="" (
    if /i "%~1"=="help"         goto :show_help
    if /i "%~1"=="show_help"    goto :show_help
    if /i "%~1"=="sync"         goto :synch
    if /i "%~1"=="about"        goto :show_about
    if /i "%~1"=="show_about"   goto :show_about
    if /i "%~1"=="stop"         goto :run_stop
    if /i "%~1"=="run_stop"     goto :run_stop
    if /i "%~1"=="qtz"          goto :run_qtz
    if /i "%~1"=="run_qtz"      goto :run_qtz
    if /i "%~1"=="prep"         goto :run_prep
    if /i "%~1"=="run_prep"     goto :run_prep
    if /i "%~1"=="commit"       goto :run_commit
    if /i "%~1"=="run_commit"   goto :run_commit
    if /i "%~1"=="config"       goto :run_config
    if /i "%~1"=="run_config"   goto :run_config
    if /i "%~1"=="upgrade" (
        call :run_config config upgrade "%~2"
        exit /b %errorlevel%
    )

    :: easter eggs :3
    if /i "%~1"=="hello"        goto :hello
    if /i "%~1"=="motivate"     goto :motivation
    if /i "%~1"=="beep"         goto :beep
    if /i "%~1"=="woof"         goto :woof
    if /i "%~1"=="meow"         goto :meow
    if /i "%~1"=="a"            goto :aemoji
    if /i "%~1"=="aemoji"       goto :aemoji
    if /i "%~1"=="sample"       goto :sample
    if /i "%~1"=="search"       goto :search
    if /i "%~1"=="showerthought" goto :showerthought
    if /i "%~1"=="get" if /i "%~2"=="processor" goto :get_processor
    if /i "%~1"=="get"          goto :getnoarg
    if /i "%~1"=="fetch"        goto :run_fetch
)

:: We check for PowerShell
echo %CMDCMDLINE% | findstr /i "CMDCMDLINE" >nul 2>&1
if %errorlevel% equ 0 (
    timeout /t 1 /nobreak >2>nul
    echo.
    echo This version of Whidbey doesn't support Microsoft Windows PowerShell.
    echo To run Whidbey, you need to use the Windows Command Processor instead.
    echo.
    exit /b 1
)

setlocal enabledelayedexpansion

for /f "tokens=4 delims=] " %%i in ('ver') do set "rawver=%%i"
for /f "tokens=1,2,3 delims=." %%a in ("!rawver!") do set "winver=Microsoft Windows Version %%a.%%b (Build %%c)"

cls
echo !winver!
echo Axeon Whidbey Development Environment %WhdDevPhs%Version %WhdVersion% (Build %WhdVersionBuild%)
echo Copyright (c) Microsoft Corp. Portions (c) Axeon Network.
echo.

call :load_config "whidbey.ini"

:parse_args
if "%~1"=="" goto args_done
if /i "%~1"=="checked" (set "WhdBuildType=chk" & shift /1 & goto parse_args)
if /i "%~1"=="free"    (set "WhdBuildType=fre" & shift /1 & goto parse_args)
if /i "%~1"=="private" (set "WhdPrivateBuild=yes" & shift /1 & goto parse_args)
if /i "%~1"=="nodelta" (set "WhdIsDeltaEnabled=no" & shift /1 & goto parse_args)

echo The command you ran isn't a Whidbey command.
echo Run "whidbey help" for a list of available commands.
exit /b 1

:args_done

if "!WhdBuildType!"=="chk" (set "WhdStatus=Checked") else (set "WhdStatus=Retail")

set "WhdLab="
for /f "tokens=*" %%i in ('git rev-parse --abbrev-ref HEAD 2^>nul') do set "WhdLab=%%i"
if "!WhdLab!"=="" if defined WhdQuartzSource if exist "!WhdQuartzSource!" (
    for /f "tokens=*" %%i in ('git -C "!WhdQuartzSource!" rev-parse --abbrev-ref HEAD 2^>nul') do set "WhdLab=%%i"
)
if "!WhdLab!"=="" set "WhdLab=PANTHER_%username%"

title Axeon Whidbey ~ Akn !WhdStatus! from DevLab !WhdLab! inside %cd%

call :prompt_input "Would you like to sync Quartz with AxeonMedia? (Y/N): " start_sync
if /i "!start_sync!"=="Y" (
    call :ensure_paths
    if exist "!WhdQuartzSource!\!WhdSourceMedia!\" xcopy "!WhdQuartzSource!\!WhdSourceMedia!\*" "!WhdAxeonMedia!\kuro\img\" /y /e /i /q >nul 2>&1
    if exist "!WhdQuartzSource!\!WhdSourceArticles!\" xcopy "!WhdQuartzSource!\!WhdSourceArticles!\*" "!WhdAxeonMedia!\kuro\articles\" /y /e /i /q >nul 2>&1
    echo Axeon Quartz and Axeon Media have been synched successfully.
    echo.
)

doskey prep="%WhdScript%" prep
doskey bninst=bundle install
doskey qtz="%WhdScript%" qtz $*
doskey track=git add .
doskey commit="%WhdScript%" commit $*
doskey pull=git pull
doskey push=git push
doskey whidbey="%WhdScript%" $*

for /f "tokens=1-7 delims=|" %%A in ("!WhdStatus!|!WhdLab!|!WhdBuildType!|!WhdQuartzSource!|!WhdAxeonMedia!|!WhdSourceArticles!|!WhdSourceMedia!") do (
    endlocal
    set "WhdStatus=%%A"
    set "WhdLab=%%B"
    set "WhdBuildType=%%C"
    set "WhdQuartzSource=%%D"
    set "WhdAxeonMedia=%%E"
    set "WhdSourceArticles=%%F"
    set "WhdSourceMedia=%%G"
)
exit /b 0


:load_config
set "cfg_target=%~1"
if "%cfg_target%"=="" set "cfg_target=whidbey.ini"

if not exist "%cfg_target%" (
    echo Whidbey could not find a configuration file in this directory. Some settings might be lost or reset.
    echo.
    exit /b 1
)

findstr /C:"%WhdConfigHeader%" "%cfg_target%" >nul 2>&1
if !errorlevel! neq 0 (
    echo Whidbey has found the configuration file '%cfg_target%', but it cannot be loaded because does not match Whidbey's magic keys.
    echo Upgrade the file by running 'whidbey upgrade %cfg_target%', then try to load it again.
    echo.
    exit /b 1
)

set "cur_sec="
for /f "usebackq tokens=*" %%L in ("%cfg_target%") do (
    set "line=%%L"
    set "line_start=!line:~0,1!"
    if "!line_start!"=="[" (
        set "cur_sec=!line!"
    ) else if not "!line_start!"=="#" (
        for /f "tokens=1,2 delims==" %%A in ("!line!") do (
            set "key=%%A"
            set "val=%%B"
            set "key=!key: =!"
            if "!cur_sec!"=="[AxeonQuartz]" (
                if "!key!"=="ArticlePath" set "WhdSourceArticles=!val!"
                if "!key!"=="ImgPath"     set "WhdSourceMedia=!val!"
                if "!key!"=="SourcePath"  set "WhdQuartzSource=!val!"
            )
            if "!cur_sec!"=="[AxeonMedia]" (
                if "!key!"=="SourcePath"  set "WhdAxeonMedia=!val!"
            )
            if "!cur_sec!"=="[BuildSettings]" (
                if "!key!"=="BuildMode"      set "WhdBuildType=!val!"
                if "!key!"=="IsPrivateBuildEnabled"   set "WhdPrivateBuild=!val!"
                if "!key!"=="IsDeltaEnabled" set "WhdIsDeltaEnabled=!val!"
            )
        )
    )
)
echo Whidbey has loaded the configuration file '%cfg_target%' successfully.
echo.
exit /b 0

:save_config
set "cfg_target=%~1"
if "%cfg_target%"=="" set "cfg_target=whidbey.ini"
(
    if !WhdVersionPrivate!==yes ( echo Axeon Whidbey Version !WhdVersionFloat! !WhdVersionBuildPri! Build ) else ( echo Axeon Whidbey Version !WhdVersionFloat! Build !WhdVersionBuild! )
    echo %WhdConfigHeader%
    echo.
    echo [AxeonQuartz]
    echo ArticlePath=!WhdSourceArticles!
    echo ImgPath=!WhdSourceMedia!
    echo SourcePath=!WhdQuartzSource!
    echo.
    echo [AxeonMedia]
    echo SourcePath=!WhdAxeonMedia!
    echo.
    echo [BuildSettings]
    echo BuildMode=!WhdBuildType!
    echo IsPrivateBuildEnabled=!WhdPrivateBuild!
    echo IsDeltaEnabled=!WhdIsDeltaEnabled!
    echo.
) > "%cfg_target%"
exit /b 0

:upgrade_config
set "target_cfg=%~1"
set "upg_articles="
set "upg_media="
set "upg_Quartz="
set "upg_axeon="
set "upg_buildtype=chk"
set "upg_privatebuild=no"
set "upg_isdeltaenabled=yes"

set "cur_sec="
for /f "usebackq tokens=*" %%L in ("%target_cfg%") do (
    set "line=%%L"
    set "line_start=!line:~0,1!"
    if "!line_start!"=="[" (
        set "cur_sec=!line!"
    ) else if not "!line_start!"=="#" (
        for /f "tokens=1,2 delims==" %%A in ("!line!") do (
            set "key=%%A"
            set "val=%%B"
            set "key=!key: =!"
            if "!cur_sec!"=="[AxeonQuartz]" (
                if "!key!"=="ArticlePath" set "upg_articles=!val!"
                if "!key!"=="ImgPath"     set "upg_media=!val!"
                if "!key!"=="SourcePath"  set "upg_Quartz=!val!"
            )
            if "!cur_sec!"=="[AxeonMedia]" (
                if "!key!"=="SourcePath"  set "upg_axeon=!val!"
            )
            if "!cur_sec!"=="[WhdEnvironment]" (
                if "!key!"=="BuildType"      set "upg_buildtype=!val!"
                if "!key!"=="PrivateBuild"   set "upg_privatebuild=!val!"
                if "!key!"=="IsDeltaEnabled" set "upg_isdeltaenabled=!val!"
            )
        )
    )
)

(
    if !WhdVersionPrivate!==yes ( echo Axeon Whidbey Version !WhdVersionFloat! !WhdVersionBuildPri! Build ) else ( echo Axeon Whidbey Version !WhdVersionFloat! Build !WhdVersionBuild! )
    echo %WhdConfigHeader%
    echo.
    echo [AxeonQuartz]
    echo ArticlePath=!upg_articles!
    echo ImgPath=!upg_media!
    echo SourcePath=!upg_Quartz!
    echo.
    echo [AxeonMedia]
    echo SourcePath=!upg_axeon!
    echo.
    echo [WhdEnvironment]
    echo BuildType=!upg_buildtype!
    echo PrivateBuild=!upg_privatebuild!
    echo IsDeltaEnabled=!upg_isdeltaenabled!
    echo.
) > "%target_cfg%"
echo The configuration file has been upgraded.
exit /b 0

:ensure_paths
set "paths_ok=Y"
if "!WhdAxeonMedia!"=="" set "paths_ok=N"
if "!WhdQuartzSource!"=="" set "paths_ok=N"
if "!WhdSourceArticles!"=="" set "paths_ok=N"
if "!WhdSourceMedia!"=="" set "paths_ok=N"

if "!paths_ok!"=="Y" (
    echo.
    echo Current config:
    echo     AxeonMedia Packet:    !WhdAxeonMedia!
    echo     Axeon Quartz Packet:   !WhdQuartzSource!
    echo     Article Path:         !WhdSourceArticles!
    echo     Multimedia Path:      !WhdSourceMedia!
    echo     Build Mode:           !WhdBuildType!
    echo     Private Build?:       !WhdPrivateBuild!
    echo     Can Has Delta?:       !WhdIsDeltaEnabled!
    echo.
    call :prompt_input "Is this configuration correct? (Y/N): " chk_reply
    if /i "!chk_reply!"=="Y" exit /b 0
)

echo.
call :prompt_input "Where is the AxeonMedia repository located?: " WhdAxeonMedia
call :prompt_input "Is the current directory a valid Axeon Quartz source code packet? (Y/N): " is_curr
if /i "!is_curr!"=="Y" (set "WhdQuartzSource=%cd%") else (call :prompt_input "Where is the root of the Axeon Quartz packet located?: " WhdQuartzSource)
call :prompt_input "Inside the Quartz packet, where are the articles located?: " WhdSourceArticles
call :prompt_input "Inside the Quartz packet, where are the images located?: " WhdSourceMedia
call :prompt_input "Choose the Quartz build type (chk/fre): " WhdBuildType
call :prompt_input "Do you want to build Quartz as a private build? (yes/no): " WhdPrivateBuild
call :prompt_input "Do you want to enable build revisions? (yes/no): " WhdIsDeltaEnabled
call :save_config
exit /b 0

:prompt_input
set "%~2="
set /p "%~2=%~1"
if "!%~2!"=="" (
    echo Terminated.
    exit /b 1
)
exit /b 0

:run_config
setlocal enabledelayedexpansion
set "subcmd=%~2"
set "cfg_file=%~3"

if "!subcmd!"=="" (
    echo You need to append an argument to this command:
    echo     new:                make a new configuration file.
    echo     upgrade ^<file^>:    upgrade a config file.
    echo     modify [file]:      modify a config file, or the
    echo                         currently loaded config.
    echo     save:               save loaded config to Whidbey.ini.
    echo     load ^<file^>:       load a Whidbey configuration.
    endlocal & exit /b 1
)

if /i "!subcmd!"=="new" (
    set "WhdAxeonMedia=" & set "WhdQuartzSource=" & set "WhdSourceArticles=" & set "WhdSourceMedia="
    set "WhdBuildType=chk" & set "WhdPrivateBuild=no" & set "WhdIsDeltaEnabled=yes"
    call :ensure_paths
    call :save_config "whidbey.ini"
    call :load_config "whidbey.ini"
    echo Configuration created and loaded.
) else if /i "!subcmd!"=="load" (
    if "!cfg_file!"=="" (
        echo Please specify a configuration file to load.
        endlocal & exit /b 1
    )
    if not exist "!cfg_file!" (
        echo !cfg_file! does not exist.
        endlocal & exit /b 1
    )
    findstr /I /C:"AXEONWHIDBEY" /C:"[AxeonQuartz]" "!cfg_file!" >nul 2>&1
    if !errorlevel! neq 0 (
        echo This is not a Whidbey configuration file.
        endlocal & exit /b 1
    )
    call :load_config "!cfg_file!"
    echo Loaded configuration from !cfg_file!.
) else if /i "!subcmd!"=="upgrade" (
    if "!cfg_file!"=="" (
        echo Please specify a configuration file to upgrade.
        endlocal & exit /b 1
    )
    if not exist "!cfg_file!" (
        echo !cfg_file! does not exist.
        endlocal & exit /b 1
    )
    findstr /I /C:"AXEONWHIDBEY" /C:"[AxeonQuartz]" "!cfg_file!" >nul 2>&1
    if !errorlevel! neq 0 (
        echo This is not a Whidbey configuration file.
        endlocal & exit /b 1
    )

    findstr /C:"!WhdConfigHeader!" "!cfg_file!" >nul 2>&1
    if !errorlevel! equ 0 (
        echo This configuration file does not need to be upgraded.
    ) else (
        call :upgrade_config "!cfg_file!"
        call :load_config "!cfg_file!"
    )
) else if /i "!subcmd!"=="modify" (
    if not "!cfg_file!"=="" (
        if not exist "!cfg_file!" (
            echo !cfg_file! does not exist.
            endlocal & exit /b 1
        )
        findstr /I /C:"AXEONWHIDBEY" /C:"[AxeonQuartz]" "!cfg_file!" >nul 2>&1
        if !errorlevel! neq 0 (
            echo This is not a Whidbey configuration file.
            endlocal & exit /b 1
        )
        call :load_config "!cfg_file!"
        call :ensure_paths
        call :save_config "!cfg_file!"
        call :load_config "!cfg_file!"
    ) else (
        if exist "whidbey.ini" (
            findstr /I /C:"AXEONWHIDBEY" /C:"[AxeonQuartz]" "whidbey.ini" >nul 2>&1
            if !errorlevel! neq 0 (
                echo This is not a Whidbey configuration file.
                endlocal & exit /b 1
            )
        )
        call :load_config "whidbey.ini" 2>nul
        call :ensure_paths
        call :save_config "whidbey.ini"
    )
) else if /i "!subcmd!"=="save" (
    if "!WhdAxeonMedia!"=="" (
        echo Configuration values are blank; There is no configuration to save.
        echo If you want to, you can generate a new configuration by running 'whidbey config new'.
        endlocal & exit /b 1
    )
    call :save_config "whidbey.ini"
    echo A new configuration file has been created successfully.
) else (
    echo Unknown configuration subcommand: !subcmd!
)

for /f "tokens=1-7 delims=|" %%A in ("X!WhdQuartzSource!|X!WhdAxeonMedia!|X!WhdSourceArticles!|X!WhdSourceMedia!|X!WhdBuildType!|X!WhdPrivateBuild!|X!WhdIsDeltaEnabled!") do (
    endlocal
    set "WhdQuartzSource=%%A"
    set "WhdAxeonMedia=%%B"
    set "WhdSourceArticles=%%C"
    set "WhdSourceMedia=%%D"
    set "WhdBuildType=%%E"
    set "WhdPrivateBuild=%%F"
    set "WhdIsDeltaEnabled=%%G"
)
set "WhdQuartzSource=%WhdQuartzSource:~1%"
set "WhdAxeonMedia=%WhdAxeonMedia:~1%"
set "WhdSourceArticles=%WhdSourceArticles:~1%"
set "WhdSourceMedia=%WhdSourceMedia:~1%"
set "WhdBuildType=%WhdBuildType:~1%"
set "WhdPrivateBuild=%WhdPrivateBuild:~1%"
set "WhdIsDeltaEnabled=%WhdIsDeltaEnabled:~1%"
exit /b 0

:synch
setlocal enabledelayedexpansion
call :ensure_paths

if not exist "!WhdQuartzSource!\" (
    echo The directory does not exist: "!WhdQuartzSource!"
    endlocal & exit /b 1
)
if not exist "!WhdAxeonMedia!\" (
    echo The directory does not exist: "!WhdAxeonMedia!"
    endlocal & exit /b 1
)

set "synced=0"

if exist "!WhdQuartzSource!\!WhdSourceMedia!\" (
    if not exist "!WhdAxeonMedia!\kuro\img\" mkdir "!WhdAxeonMedia!\kuro\img\" >nul 2>&1
    xcopy "!WhdQuartzSource!\!WhdSourceMedia!\*" "!WhdAxeonMedia!\kuro\img\" /y /e /i /q >nul 2>&1
    set /a synced+=1
) else (
    echo The directory "!WhdQuartzSource!\!WhdSourceMedia!" was not found.
)

if exist "!WhdQuartzSource!\!WhdSourceArticles!\" (
    if not exist "!WhdAxeonMedia!\kuro\articles\" mkdir "!WhdAxeonMedia!\kuro\articles\" >nul 2>&1
    xcopy "!WhdQuartzSource!\!WhdSourceArticles!\*" "!WhdAxeonMedia!\kuro\articles\" /y /e /i /q >nul 2>&1
    set /a synced+=1
) else (
    echo The directory "!WhdQuartzSource!\!WhdSourceArticles!" was not found.
)

if !synced! gtr 0 (
    echo Axeon Quartz and Axeon Media have been synched successfully.
) else (
    echo One or more directories are blank or do not exist; Axeon Quartz and Axeon Media have not been synched successfully.
)

endlocal
exit /b 0

:show_about
setlocal disabledelayedexpansion
for /f "tokens=*" %%i in ('ver') do set "osver=%%i"
set "osver=%osver:[=%"
set "osver=%osver:]=%"
set "osver=%osver:Microsoft Windows Version =%"
if /i "%OS%"=="Windows_NT" (
    set "OsName=Microsoft Windows NT"
    set "CompanyName=Microsoft Corporation"
)

set "archtemp=%PROCESSOR_ARCHITEW6432%"
if "%archtemp%"=="" set "archtemp=%PROCESSOR_ARCHITECTURE%"

if /i "%archtemp%"=="IA64" (
    set "arch=for the Intel Itanium processor"
) else if /i "%archtemp%"=="AMD64" (
    set "arch=AMD64"
    set "archline2="
) else if /i "%archtemp%"=="x86" (
    set "arch=x86"
    set "archline2="
) else (
    set "arch=%archtemp%"
    set "archline2="
)

echo Axeon Whidbey Development Environment and Framework
echo Version %WhdVersionFloat% %WhdDevPhs%(Build %WhdVersionBuildEx% %WhdVersionMode%)
echo.
echo Running under %OsName% Version %osver% %arch%
echo Copyright (C) %CompanyName%. All Rights Reserved.
echo.
echo.
echo The Whidbey Environment is meant for internal use only.
echo Copyright (C) 2026 Axeon Network. Developed by KitSixtyFour
echo.
echo Check us out over at https://axeon-network.github.io if you want more goodies!
endlocal
exit /b 0

:run_stop
echo Unloading Whidbey environment...
doskey whelp= & doskey prep= & doskey bninst= & doskey qtz=
doskey track= & doskey commit= & doskey pull= & doskey push= & doskey whidbey=
set "status=" & set "WhdLab=" & set "WhdBuildType=" & set "WhdQuartzSource=" & set "WhdAxeonMedia=" & set "WhdSourceArticles=" & set "WhdSourceMedia="
set cmdline=%cmdcmdline%
set cmdline=%cmdline:"=%
title %cmdline%
echo Complete. Have a great day^! :3
exit /b 0

:run_prep
setlocal enabledelayedexpansion
call :load_config "whidbey.ini"
call :ensure_paths
xcopy "!WhdQuartzSource!\!WhdSourceMedia!\*" "!WhdAxeonMedia!\kuro\img\" /y /e /i /q >nul 2>&1
xcopy "!WhdQuartzSource!\!WhdSourceArticles!\*" "!WhdAxeonMedia!\kuro\articles\" /y /e /i /q >nul 2>&1

pushd "!WhdQuartzSource!"
git add .
call :prompt_input "What do you want to name Quartz's commit?: " AknCommitName
call :prompt_input "Do you want to add a description? (Y/N): " qtz_desc_yn
if /i "!qtz_desc_yn!"=="Y" (
    call :prompt_input "Description: " AknCommitDesc
    git commit -m "!AknCommitName!" -m "!AknCommitDesc!"
) else (
    git commit -m "!AknCommitName!"
)
git push
popd

pushd "!WhdAxeonMedia!"
git add .
call :prompt_input "What do you want to name AxeonMedia's commit?: " MdaCommitName
call :prompt_input "Do you want to add a description? (Y/N): " mda_desc_yn
if /i "!mda_desc_yn!"=="Y" (
    call :prompt_input "Description: " MdaCommitDesc
    git commit -m "!MdaCommitName!" -m "!MdaCommitDesc!"
) else (
    git commit -m "!MdaCommitName!"
)
git push
popd
endlocal
exit /b 0

:run_qtz
setlocal enabledelayedexpansion
shift /1
if /i "%~1"=="-nW" (
    bundle exec jekyll server -l -o --no-watch -H 127.0.0.50
) else if /i "%~1"=="-nLO" (
    bundle exec jekyll server -H 127.0.0.50
) else if /i "%~1"=="-nS" (
    bundle exec jekyll build
) else if /i "%~1"=="-cl" (
    bundle exec jekyll clean
) else if /i "%~1"=="-nL" (
    bundle exec jekyll server -o -H 127.0.0.50
) else if /i "%~1"=="-nO" (
    bundle exec jekyll server -l -H 127.0.0.50
) else if /i "%~1"=="-nH" (
    bundle exec jekyll server -l -o
) else if /i "%~1"=="-nA" (
    bundle exec jekyll server
) else if /i "%~1"=="-?" (
    call :stupidqtzinfobanner
) else (
    bundle exec jekyll server -l -o -H 127.0.0.50 %*
)
endlocal
exit /b 0

:run_commit
if "%~3"=="" (
    git commit -m "%~2"
) else (
    git commit -m "%~2" -m "%~3"
)
exit /b 0

:show_usage
echo You need to append an argument to start Whidbey correctly.
echo.
echo Usage:   whidbey.cmd ^<arguments^>
echo.
echo          checked:   Runs Quartz or Cuber in debug/Checked mode
echo             free:   Runs Quartz or Cuber in retail mode
echo          nodelta:   Disables the build delta mode, which increments
echo                     a build's revision number, instead of the build
echo                     number itself
echo          private:   Enables the private build mode. Used for internal
echo                     builds only.
exit /b 1

:show_help
echo.
echo Axeon Whidbey currently supports 12 commands and 25 arguments.
echo.
echo  Command [Arguments]:                  Description:
echo   bninst                                install missing gems via bundler
echo   qtz [-nW  -nLO  -nS  -cl  -nA         run the Axeon Quartz server
echo           -nL  -nO  -nH  -?]            * "-nW" disables regeneration.
echo                                         * "-nLO" disables the -l/-o args.
echo                                         * "-nS" runs Quartz without a server,
echo                                           equal to 'bundle exec jekyll build'.
echo                                         * "-nO" disables -o/OpenUrl.
echo                                         * "-nL" disables -l/LiveReload.
echo                                         * "-nH" repoints the server address
echo                                           back to '127.0.0.1'.
echo                                         * "-nA" disables every argument.
echo                                         * "-cl" cleans the working directory,
echo                                           equal to 'bundle exec jekyll clean'.
echo                                         * "-?" prints argument information.
echo   prep                                  sync and push packet to git.
echo   track                                 tracks any current packet changes
echo                                         * alias of 'git add .'.
echo   pull                                  pulls any changes from the web packet
echo                                         * alias of 'git pull'.
echo   push                                  pushes the local packet to the web
echo                                         * alias of 'git push'.
echo   commit "msg" "desc"                    commits current packet to git.
echo   whidbey config [new  modify  save      manage a loaded whidbey config:
echo                     upgrade  load]       * "new" makes a new config file and
echo                                            saves it to 'Whidbey.INI'.
echo                                          * "modify" changes the current config.
echo                                          * "save" saves the current config to
echo                                            'Whidbey.INI'.
echo                                          * "upgrade" upgrades a config file to
echo                                            match Whidbey's magic keys.
echo                                          * "load" loads a config file. 
echo   whidbey fetch [version  status  dir    query and fetch information:
echo                  processor  os  date     * most of them are self-explanatory...
echo                  qtzver  delta  private    use "--noduo" for processor if you
echo                  stick  paths  lab         want the real thing.
echo                         config]          * append "please" to stick if u want
echo                                            some fun :3c
echo   whidbey search                         search the web (not)
echo   whidbey about                          show the about dialogue 
echo   whidbey stop                           unload any whidbey-related things and
echo                                          cleans the console
echo.
exit /b 0

:stupidqtzinfobanner
echo This command supports nine arguments (including the one you just ran):
echo.
echo Argument      Description                                Jekyll Cmd Equivalents
echo   -nW           Disables site regeneration.                --no-watch
echo   -nLO          Disables LiveReload and OpenURL.           N/A  (removes -l/-o)
echo   -nS           Runs Quartz without a server.               build
echo   -cl           Cleans the Jekyll workspace.               clean
echo   -nL           Disables LiveReload only.                  N/A  (removes -l)
echo   -nO           Disables OpenURL only.                     N/A  (removes -o)
echo   -nH           Disables the custom server address.        N/A  (removes -H)
echo   -nA           Runs Quartz with the default                server  (removes all args)
echo                 Jekyll server settings.
echo   -?            Prints this message.                       N/A (its a help command dude)
exit /b 0

:hello
echo Hello there^! :3
exit /b 0

:motivation
echo Nice work^! Keep going dude^! :D
exit /b 0

:beep
echo Boop^!
exit /b 0

:woof
echo Woof^!
exit /b 0

:meow
echo Meow^!
exit /b 0

:aemoji
echo A? A!
exit /b 0

:sample
echo Project Arctic 2002 and Nexus32, coming [[REDACTED]]!
exit /b 0

:search
setlocal enabledelayedexpansion
set /a "err_idx=!RANDOM! %% 12"

set "err_0=Error 0xCD: We can't find what you're looking for on the internet, please try looking for it on physical media instead."
set "err_1=Error 0x40: Your processor is either too slow or too damn fast to parse this. Please try on an Intel Core A Duo H467 instead."
set "err_2=Error 0xAA: Our servers have been infected by the Win32.AEmoji malware. Please try again later."
set "err_3=Error 0x50: Can't decide if you're looking for books or ducks that know the answer. Please clear up your mind."
set "err_4=Error 0x64: We can't process this request at this time. Please try again in a Nintendo 64."
set "err_5=Error 0x06: Our servers are under maintenance mode. However, the server admins might be too busy barking or meowing instead of fixing the problem. Please try again sometime on September 17, 2027."
set "err_6=Error 0x70: The answer to this query has been redacted by the United States of America's Federal Bureau of Investigation. Please try searching for something else."
set "err_7=Error 0x10: We tried to deliver the results to you, but your ISP was too hungry and it ate instead. Sorry about that."
set "err_8=Error 0x03: Our servers are having a hard time processing your request since they are still running on Windows Server 2003. Please give them some time."
set "err_9=Error 0xBF: Whidbey cannot deliver this request since it reminded them of their ex. Please try another query."
set "err_10=Error 0xDF: Woof!"
set "err_11=Error 0xDE: Meow!"
set "err_12=Error 0x82: Whidbey cannot process this request because you have not listened to Thriller enough times. Please get 51,400,000 copies of the album, load them to iTunes 10.7.0.21, and then try again later."
set "err_13=Error 0x12: We cannot process this request because... um... i dont even know man"
set "err_14=Error 0x20: Your computer cannot process the answer to this query. Please try again on a computer powered by the Intel Itanium processor."
if %PROCESSOR_ARCHITECTURE%==IA64 set "err_14=Error 0x20: Your computer is powered by an Intel Itanium processor."

echo !err_%err_idx%!
endlocal
exit /b 0

:get_processor
setlocal enabledelayedexpansion
echo Whidbey is querying your computer's information...
timeout /t 5 >nul 2>&1
set /a "cpu_idx=!RANDOM! %% 32"

set "cpu_0=Intel(R) Core(TM)A Solo CPU E640 @ 2.00GHz"
set "cpu_1=Intel(R) Core(TM)A Solo CPU E840 @ 2.00GHz"
set "cpu_2=Intel(R) Core(TM)A Solo CPU N920 @ 2.00GHz"
set "cpu_3=Intel(R) Core(TM)A Solo CPU W650 @ 2.00GHz"
set "cpu_4=Intel(R) Core(TM)A Solo CPU S250 @ 2.00GHz"
set "cpu_5=Intel(R) Core(TM)A Solo CPU I357 @ 2.00GHz"
set "cpu_6=Intel(R) Core(TM)A Solo CPU H467 @ 2.00GHz"
set "cpu_7=Intel(R) Core(TM)A Solo CPU B577 @ 2.00GHz"
set "cpu_8=Intel(R) Core(TM)A Duo CPU E640 @ 2.00GHz"
set "cpu_9=Intel(R) Core(TM)A Duo CPU E840 @ 2.00GHz"
set "cpu_10=Intel(R) Core(TM)A Duo CPU N920 @ 2.00GHz"
set "cpu_11=Intel(R) Core(TM)A Duo CPU W650 @ 2.00GHz"
set "cpu_12=Intel(R) Core(TM)A Duo CPU S250 @ 2.00GHz"
set "cpu_13=Intel(R) Core(TM)A Duo CPU I357 @ 2.00GHz"
set "cpu_14=Intel(R) Core(TM)A Duo CPU H467 @ 2.00GHz"
set "cpu_15=Intel(R) Core(TM)A Duo CPU B577 @ 2.00GHz"
set "cpu_16=Intel(R) Core(TM)A Quad CPU E640 @ 2.50GHz"
set "cpu_17=Intel(R) Core(TM)A Quad CPU E840 @ 2.50GHz"
set "cpu_18=Intel(R) Core(TM)A Quad CPU N920 @ 2.50GHz"
set "cpu_19=Intel(R) Core(TM)A Quad CPU W650 @ 2.50GHz"
set "cpu_20=Intel(R) Core(TM)A Quad CPU S250 @ 2.50GHz"
set "cpu_21=Intel(R) Core(TM)A Quad CPU I357 @ 2.50GHz"
set "cpu_22=Intel(R) Core(TM)A Quad CPU H467 @ 2.50GHz"
set "cpu_23=Intel(R) Core(TM)A Quad CPU B577 @ 2.50GHz"
set "cpu_24=Intel(R) Core(TM)A Extreme CPU E630 @ 2.60GHz"
set "cpu_25=Intel(R) Core(TM)A Extreme CPU E840 @ 2.60GHz"
set "cpu_26=Intel(R) Core(TM)A Extreme CPU N920 @ 2.60GHz"
set "cpu_27=Intel(R) Core(TM)A Extreme CPU W650 @ 2.60GHz"
set "cpu_28=Intel(R) Core(TM)A Extreme CPU S250 @ 2.60GHz"
set "cpu_29=Intel(R) Core(TM)A Extreme CPU I357 @ 2.60GHz"
set "cpu_30=Intel(R) Core(TM)A Extreme CPU H467 @ 2.60GHz"
set "cpu_31=Intel(R) Core(TM)A Extreme CPU B577 @ 2.60GHz"

echo Running on an !cpu_%cpu_idx%!.
endlocal
exit /b 0

:showerthought
setlocal enabledelayedexpansion
set /a "st_idx=!RANDOM! %% 21"

set "st_0=People hate Sundays because of Mondays."
set "st_1=Friday is close to Monday, but Monday is far from Friday."
set "st_2=Does Lightning McQueen get life insurance or car insurance?"
set "st_3=You learn to read before you read to learn."
set "st_4=Why does the the brain ignore the second 'the'?"
set "st_5=What does the fox say?"
set "st_6=If Todd uses the same model as Robin Hood, is Robin Hood actually just Todd?"
set "st_7=No mirror is brand new."
set "st_8=The bigger the bedroom is, the smaller the bedroom is."
set "st_9=If love is blind, why is there love at first sight?"
set "st_10=The platform Discord is known for having drama in it, so it lives up to its name."
set "st_11=If there is a Windows Vista, why isn't there a Windows Tacto?"
set "st_12=If Life is a Highway, how long would the road be?"
set "st_13=Has Google actually reached a googol of indexed pages?"
set "st_14=How are cars born in the Cars universe?"
set "st_15=Since Mario & Luigi: Bowser's Inside Story takes place after Partners in Time, are the B.I.S. Mario and Luigi the baby versions or the grown-up versions?"
set "st_16=If you replace 'W' with 'T' in Where, What, and When, you answer the question."
set "st_17=If you're waiting for a waiter at a restaurant, doesn't that make you the waiter?"
set "st_18=Firefighters use water, but watercraft firefighters use water from under the water."
set "st_19=Your stomach thinks all potato chips are crushed immediately."
set "st_20=If electricity comes from electrons, does morality come from morons?"

echo !st_%st_idx%!
endlocal
exit /b 0

:run_fetch
setlocal enabledelayedexpansion
set "target=%~2"
set "flag=%~3"

if /i "!target!"=="stick" if /i "!flag!"=="please" (
    endlocal & goto :fetchstickpls
)
if /i "!target!"=="stick" (
    endlocal & goto :fetchstick
)

if /i "!target!"=="status" (
    echo !WhdStatus!
) else if /i "!target!"=="version" (
    echo Axeon Whidbey Version !WhdVersionComp!
) else if /i "!target!"=="dir" (
    echo !cd!
) else if /i "!target!"=="lab" (
    echo !WhdLab!
) else if /i "!target!"=="processor" (
    if /i "!flag!"=="--noduo" (
        set "real_cpu="
        for /f "tokens=2 delims==" %%A in ('wmic cpu get name /value 2^>nul') do set "real_cpu=%%A"

        if "!real_cpu!"=="" (
            for /f "tokens=2,*" %%A in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0" /v ProcessorNameString 2^>nul ^| findstr /i "ProcessorNameString"') do (
            set "real_cpu=%%B"
            )
        )

        if not "!real_cpu!"=="" (
            echo Running on an !real_cpu!.
        ) else (
            echo An error has occurred. Whidbey cannot fetch your computer's processor via WMIC or the Windows Registry. This may be an internal Whidbey or Windows bug.
        )
    ) else (
        endlocal & goto :get_processor
    )
) else if /i "!target!"=="os" (
    for /f "tokens=*" %%i in ('ver') do set "osver=%%i"
    echo !osver!
) else if /i "!target!"=="qtzver" (
    if "!WhdQuartzSource!"=="" (
        echo An error has occurred. Is the Quartz source packet path set correctly?
    ) else if not exist "!WhdQuartzSource!\_includes\misc\version.html" (
        echo An error has occurred. Cannot access the Panther header file.
    ) else (
        set "qtzver="
        for /f "tokens=2 delims==" %%A in ('findstr /i "AKN_VERSION" "!WhdQuartzSource!\_includes\misc\version.html" 2^>nul') do (
            set "qtzver=%%A"
            set "qtzver=!qtzver:"=!"
            set "qtzver=!qtzver:%%=!"
            set "qtzver=!qtzver:}=!"
            set "qtzver=!qtzver: =!"
        )
        if not "!qtzver!"=="" (
            echo Axeon Quartz Version !qtzver!
        ) else (
            echo An error has occurred. The string AKN_VERSION could not be fetched from the Panther header file.
            echo Is this a valid Quartz packet?
        )
    )
) else if /i "!target!"=="delta" (
    echo Build revs. are enabled?: !WhdIsDeltaEnabled!
) else if /i "!target!"=="private" (
    echo Is this a private build?: !WhdPrivateBuild!
) else if /i "!target!"=="date" (
    echo !date! !time!
) else if /i "!target!"=="paths" (
    echo !WhdAxeonMedia!
    echo !WhdQuartzSource!
    echo !WhdQuartzSource!\!WhdSourceArticles!
    echo !WhdQuartzSource!\!WhdSourceMedia!
) else if /i "!target!"=="config" ( 
    type whidbey.ini
) else if "!target!"=="" (
    echo What do you want me to fetch?
) else (
    echo I'm not sure how can I fetch '!target!', is it something valuable?
)

endlocal
exit /b 0

:fetchstick
echo I'm not a dog to fetch a stupid stick^!
exit /b 0

:fetchstickpls
echo Woof woof^! *nom*
exit /b 0

:getnoarg
echo What do you want me to get? Your 'processor'?
exit /b 0

:Boop
echo Boop^!
exit /b 0