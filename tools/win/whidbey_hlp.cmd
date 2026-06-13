@echo off
echo.
echo Axeon Whidbey Version 2.0a for Microsoft(R) Windows(R)
echo Copyright 2026 KitSixtyFour. For internal Axeon use only
echo.
echo This script creates command aliases to make the debugging life easier.
echo Basically, this shortens lots of commands to three letters sometimes prefixed
echo with "ak" or "a".
echo.
echo.
echo Aliases:
echo         bni               - install missing gems via bundler
echo         akn               - run Deltari normally
echo         akw               - run Deltari WITHOUT regeneration
echo         aks               - run Deltari WITHOUT LiveReload or OpenURL
echo         akb               - build the site without a server
echo         acl               - clean site leftovers (such as _site)
echo         atr               - track ALL files for git
echo         acm "arg"         - commit current work. "arg" is the title of the 
echo                             commit, do not skip the quotation marks or else it
echo                             WONT work!
echo         ace "arg" "arg2"  - same as dcm but "arg2" is an extended description
echo                             of the commit
echo         apl               - pull changes from github
echo         aps               - push work to github
echo         hlp               - print this message
