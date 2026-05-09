#!/bin/bash

BUILDTAG_FILE="resources/ruby/buildtag"

if [ -f "$BUILDTAG_FILE" ]; then
    # Reads the file, takes the 4th field using '.' as a delimiter
    raw_id=$(cut -d'.' -f4 "$BUILDTAG_FILE")
else
    raw_id="chk"
fi

# 2. Check the current build status
# Use case-insensitive matching [[ =~ ]]
if [[ "$raw_id" =~ [Cc][Hh][Kk] ]]; then
    status="Chk"
elif [[ "$raw_id" =~ [Ff][Rr][Ee] ]]; then
    status="Fre"
else
    status="Dmm"
fi

# 3. Get the lab via git
lab=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

# Fallback to default if lab is empty
if [ -z "$lab" ]; then
    lab="PANTHER_${USER}"
fi

# 4. Set the terminal title (works for most modern Linux terminals)
echo -ne "\033]0;Whidbey - Delta${status} of ${lab} in ${PWD}\007"

# 5. Aliases
# Note: These only work in the current session if you run: source ./filename.sh
alias dlt='bundle exec jekyll server -l -o --port 4500'
alias dnw='bundle exec jekyll server -l -o --no-watch --port 4500'
alias bni='bundle install'
alias hlp='bash ./tools/lin/whidbey_hlp.sh'
alias dsv='bundle exec jekyll server --port 4500'
alias dbl='bundle exec jekyll build'
alias dcl='bundle exec jekyll clean'
alias dtr='git add .'
alias dph='git push'
alias dpl='git pull'

# Git commit aliases with arguments
dcm() { git commit -m "$1"; }
dce() { git commit -m "$1" -m "$2"; }
