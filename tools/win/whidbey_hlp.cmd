@echo off
echo.
echo Axeon Whidbey Version 1.0j for Microsoft(R) Windows(R)
echo Copyright 2026 KitSixtyFour. For internal Axeon use only
echo.
echo This script creates command aliases to make the debugging life easier.
echo Basically, this shortens lots of commands to three letters sometimes prefixed
echo with "d".
echo.
echo.
echo Aliases:
echo         bni               - install missing gems via bundler
echo         dlt               - run Deltari normally
echo         dnw               - run Deltari WITHOUT regeneration
echo         dsv               - run Deltari WITHOUT LiveReload or OpenURL
echo         dbl               - build the site without a server
echo         dcl               - clean site leftovers (such as _site)
echo         dtr               - track ALL files for git
echo         dcm "arg"         - commit current work. "arg" is the title of the 
echo                             commit, do not skip the quotation marks or else it
echo                             WONT work!
echo         dce "arg" "arg2"  - same as dcm but "arg2" is an extended description
echo                             of the commit
echo         dpl               - pull changes from github
echo         dps               - push work to github
echo         hlp               - print this message
