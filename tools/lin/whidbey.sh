#!/bin/bash

BUILDTAG_FILE="resources/ruby/buildtag"

if [ -f "$BUILDTAG_FILE" ]; then
    raw_id=$(cut -d'.' -f4 "$BUILDTAG_FILE")
else
    raw_id="chk"
fi


if [[ "$raw_id" =~ [Cc][Hh][Kk] ]]; then
    status="Chk"
elif [[ "$raw_id" =~ [Ff][Rr][Ee] ]]; then
    status="Fre"
else
    status="Dmm"
fi

lab=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

if [ -z "$lab" ]; then
    lab="PANTHER_${USER}"
fi


echo -ne "\033]0;Whidbey - Delta${status} of ${lab} in ${PWD}\007"


alias dlt='bundle exec jekyll server -l -o --port 4500'
alias dnw='bundle exec jekyll server -l -o --no-watch --port 4500'
alias bni='bundle install'
alias hlp='bash ./tools/lin/whidbey_hlp.sh'
alias dsv='bundle exec jekyll server --port 4500'
alias dbl='bundle exec jekyll build'
alias dcl='bundle exec jekyll clean'
alias dtr='git add .'
alias dps='git push'
alias dpl='git pull'

dcm() { git commit -m "$1"; }
dce() { git commit -m "$1" -m "$2"; }

# todo: make this actually properly workable -avery