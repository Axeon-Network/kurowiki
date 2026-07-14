#!/bin/bash
# Axeon Whidbey Environment Framework for POSIX (Linux/macOS)
# Copyright 2026 KitSixtyFour. For internal Axeon use only.

# Capture the true script file location context immediately
export WhdScript="${BASH_SOURCE[0]}"
if [ -z "$WhdScript" ]; then
    WhdScript="$0"
fi

# Internal routing engine hooks
if [ "$1" = "show_help" ]; then
    _whd_show_help
    return 0
elif [ "$1" = "run_prep" ]; then
    _whd_run_prep
    return 0
fi

clear
# Get stripped operating system details gracefully
if [[ "$OSTYPE" == "darwin"* ]]; then
    winver="macOS $(sw_vers -productVersion 2>/dev/null)"
    copyown="Apple Inc"
else
    winver="Linux $(uname -r 2>/dev/null)"
    copyown="The Linux Authors & Others"
fi

echo "$winver"
echo "Axeon Whidbey Development Environment Version 4.0"
echo "Copyright (c) $copyown. Portions (c) Axeon Network."
echo ""

# Initialize default environment properties
export WhdPrivateBuild="no"
export WhdIsDeltaEnabled="yes"
export WhdBuildType=""

# Loop through command line arguments in any order
while [ "$#" -gt 0 ]; do
    case "$(echo "$1" | tr '[:upper:]' '[:lower:]')" in
        checked)
            export WhdBuildType="chk"
            ;;
        free)
            export WhdBuildType="fre"
            ;;
        private)
            export WhdPrivateBuild="yes"
            ;;
        nodelta)
            export WhdIsDeltaEnabled="no"
            ;;
    esac
    shift
done

# Default build configuration rules
if [ -z "$WhdBuildType" ]; then
    export WhdBuildType="chk"
fi

if [ "$WhdBuildType" = "chk" ]; then
    status="Checked"
else
    status="Retail"
fi

# Read current branch lab properties via Git
lab=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
if [ -z "$lab" ]; then
    lab="PANTHER_${USER:-dummy}"
fi

# Set the console title wrapper block dynamically
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo -n -e "\033]0;Axeon Whidbey ~ Akn $status from DevLab $lab inside $(pwd)\007"
else
    echo -n -e "\033]2;Axeon Whidbey ~ Akn $status from DevLab $lab inside $(pwd)\007"
fi

# Load existing configurations helper definition
_whd_load_config() {
    if [ -f "whidbey.ini" ]; then
        local cur_sec=""
        while IFS= read -r line || [ -n "$line" ]; do
            # Strip carriage returns and whitespace
            line=$(echo "$line" | tr -d '\r' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
            
            # Skip empty lines and comment blocks
            [[ -z "$line" || "$line" == "#"* || "$line" == ";"* || "$line" == "::"* ]] && continue
            
            if [[ "$line" == "["*"]" ]]; then
                cur_sec="$line"
            elif [[ "$line" == *"="* ]]; then
                local key="${line%%=*}"
                local val="${line#*=}"
                key=$(echo "$key" | tr -d ' ')
                
                if [ "$cur_sec" = "[AxeonAkane]" ]; then
                    [ "$key" = "ArticlePath" ] && export SourceArticles="$val"
                    [ "$key" = "ImgPath" ] && export SourceMedia="$val"
                    [ "$key" = "SourcePath" ] && export AkaneSource="$val"
                elif [ "$cur_sec" = "[AxeonMedia]" ]; then
                    [ "$key" = "SourcePath" ] && export AxeonMedia="$val"
                fi
            fi
        done < "whidbey.ini"
    fi
}

_whd_save_config() {
    cat << EOF > "whidbey.ini"
AXEONWHIDBEY4
[AxeonAkane]
ArticlePath=$SourceArticles
ImgPath=$SourceMedia
SourcePath=$AkaneSource

[AxeonMedia]
SourcePath=$AxeonMedia
EOF
}

_whd_ensure_paths() {
    local paths_ok="Y"
    [ -z "$AxeonMedia" ] && paths_ok="N"
    [ -z "$AkaneSource" ] && paths_ok="N"
    [ -z "$SourceArticles" ] && paths_ok="N"
    [ -z "$SourceMedia" ] && paths_ok="N"

    if [ "$paths_ok" = "Y" ]; then
        echo ""
        echo "Whidbey has found the following configuration saved on your computer:"
        echo "  AxeonMedia     = $AxeonMedia"
        echo "  AkaneSource    = $AkaneSource"
        echo "  SourceArticles = $SourceArticles"
        echo "  SourceMedia    = $SourceMedia"
        echo ""
        read -p "Is this configuration correct? (Y/N): " chk_reply
        if [[ "$chk_reply" =~ ^[Yy]$ ]]; then
            return 0
        fi
    fi

    echo ""
    read -p "Where is the AxeonMedia repository located (relative or absolute path)? " AxeonMedia
    export AxeonMedia
    
    read -p "Is the current directory ($(pwd)) a valid Axeon Akane source packet? (Y/N): " is_curr
    if [[ "$is_curr" =~ ^[Yy]$ ]]; then
        export AkaneSource="$(pwd)"
    else
        read -p "Where is the Axeon Akane source code located (relative or absolute path)? " AkaneSource
        export AkaneSource
    fi
    
    read -p "On the Axeon Akane source code, in what path are the article files located? " SourceArticles
    export SourceArticles
    read -p "On the Axeon Akane source code, in what path are the article images located? " SourceMedia
    export SourceMedia

    _whd_save_config
}

_whd_run_prep() {
    _whd_load_config
    _whd_ensure_paths

    echo ""
    echo "Synchronizing workspace entities..."
    mkdir -p "$AxeonMedia/kuro/img/" "$AxeonMedia/kuro/articles/"
    cp -R "$AkaneSource/$SourceMedia/"* "$AxeonMedia/kuro/img/" 2>/dev/null
    cp -R "$AkaneSource/$SourceArticles/"* "$AxeonMedia/kuro/articles/" 2>/dev/null

    # Akane Repository Pipeline Pushes
    pushd "$AkaneSource" > /dev/null
    git add .
    read -p "What would you like to name your commit for Akane? " AknCommitName
    read -p "Would you like to add a description to your commit? (Y/N): " akn_desc_yn
    if [[ "$akn_desc_yn" =~ ^[Yy]$ ]]; then
        read -p "Enter the commit description: " AknCommitDesc
        git commit -m "$AknCommitName" -m "$AknCommitDesc"
    else
        git commit -m "$AknCommitName"
    fi
    git push
    popd > /dev/null

    # AxeonMedia Repository Pipeline Pushes
    pushd "$AxeonMedia" > /dev/null
    git add .
    read -p "What would you like to name your commit for AxeonMedia? " MdaCommitName
    read -p "Would you like to add a description to your commit? (Y/N): " mda_desc_yn
    if [[ "$mda_desc_yn" =~ ^[Yy]$ ]]; then
        read -p "Enter the commit description: " MdaCommitDesc
        git commit -m "$MdaCommitName" -m "$MdaCommitDesc"
    else
        git commit -m "$MdaCommitName"
    fi
    git push
    popd > /dev/null

    unset AknCommitName AknCommitDesc MdaCommitName MdaCommitDesc
    echo ""
    echo "Done."
}

_whd_show_help() {
    echo ""
    echo "Axeon Whidbey Version 4.0 for Linux/macOS"
    echo "Copyright 2026 KitSixtyFour. For internal Axeon use only"
    echo ""
    echo ""
    echo "Commands:"
    echo "          bninst               - install missing gems via bundler"
    echo "          akn                  - run Akane normally"
    echo "          akn -nW              - run Akane WITHOUT regeneration"
    echo "          akn -nA              - run Akane WITHOUT LiveReload or OpenURL"
    echo "          akn -nS              - build the site without a server"
    echo "          akn -cl              - clean site leftovers (such as _site)"
    echo "          prep                 - transfer updated files and push commits to git"
    echo "          track                - track ALL files for git"
    echo "          commit \"arg\"         - commit current work."
    echo "          commit \"arg\" \"arg2\"  - same as commit but \"arg2\" is an extended description"
    echo "          pull                 - pull changes from github"
    echo "          push                 - push work to github"
    echo "          whelp                - print this message"
    echo ""
}

# Run config validation tasks
_whd_load_config

read -p "Would you like to sync Akane with AxeonMedia? (Y/N): " start_sync
if [[ "$start_sync" =~ ^[Yy]$ ]]; then
    _whd_ensure_paths
    echo ""
    echo "Copying assets..."
    mkdir -p "$AxeonMedia/kuro/img/" "$AxeonMedia/kuro/articles/"
    cp -R "$AkaneSource/$SourceMedia/"* "$AxeonMedia/kuro/img/" 2>/dev/null
    cp -R "$AkaneSource/$SourceArticles/"* "$AxeonMedia/kuro/articles/" 2>/dev/null
    echo ""
fi

# Global Session Shell Command Maps
whelp() { _whd_show_help; }
prep() { _whd_run_prep; }
bninst() { bundle install; }
track() { git add .; }
pull() { git pull; }
push() { git push; }

commit() {
    if [ -z "$2" ]; then
        git commit -m "$1"
    else
        git commit -m "$1" -m "$2"
    fi
}

akn() {
    if [ "$1" = "-nW" ]; then
        bundle exec jekyll server -l -o --no-watch -H 127.0.0.50
    elif [ "$1" = "-nA" ]; then
        bundle exec jekyll server -H 127.0.0.50
    elif [ "$1" = "-nS" ]; then
        bundle exec jekyll build
    elif [ "$1" = "-cl" ]; then
        bundle exec jekyll clean
    else
        bundle exec jekyll server -l -o -H 127.0.0.50 "$@"
    fi
}