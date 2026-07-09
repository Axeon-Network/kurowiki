#!/bin/bash

# To use, make sure you run "source ./tools/lin/whidbey.sh" (without quotations) in your terminal!

clear

echo "Axeon Whidbey 2.0a"
echo "Copyright (c) Axeon Network."
echo ""

if [ -f "./res/ruby/buildtag" ]; then
    raw_id=$(cut -d'.' -f4 ./res/ruby/buildtag)
else
    raw_id="chk"
fi

if echo "$raw_id" | grep -qi "chk"; then
    status="Checked"
elif echo "$raw_id" | grep -qi "fre"; then
    status="Retail"
else
    status="STATUS_DUMMY"
fi

lab=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
if [ -z "$lab" ]; then
    lab="PANTHER_${USER}"
fi

echo -ne "\033]0;Axeon Whidbey ~ Akn ${status} from DevLab ${lab} inside ${PWD}\007"


hlp() {
    echo ""
    echo "Axeon Whidbey Version 2.0a for Linux"
    echo "Copyright 2026 KitSixtyFour. For internal Axeon use only"
    echo ""
    echo ""
    echo "Commands:"
    echo "          bni               - install missing gems via bundler"
    echo "          akn               - run Akane normally"
    echo "          akw               - run Akane WITHOUT regeneration"
    echo "          aks               - run Akane WITHOUT LiveReload or OpenURL"
    echo "          akb               - build the site without a server"
    echo "          acl               - clean site leftovers (such as _site)"
    echo "          trk               - track ALL files for git"
    echo "          cmt \"arg\"         - commit current work. \"arg\" is the title of the"
    echo "                              commit, do not skip the quotation marks or else it"
    echo "                              WONT work!"
    echo "          cme \"arg\" \"arg2\"  - same as cmt but \"arg2\" is an extended description"
    echo "                              of the commit"
    echo "          pul               - pull changes from github"
    echo "          psh               - push work to github"
    echo "          hlp               - print this message"
}

cmt() {
    git commit -m "$*"
}

cme() {
    git commit -m "$1" -m "$2"
}

alias akn="bundle exec jekyll server -l -o -H 127.0.0.50"
alias akw="bundle exec jekyll server -l -o --no-watch -H 127.0.0.50"
alias bni="bundle install"
alias aks="bundle exec jekyll server -H 127.0.0.50"
alias akb="bundle exec jekyll build"
alias acl="bundle exec jekyll clean"
alias trk="git add ."
alias psh="git push"
alias pul="git pull"
