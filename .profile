#!/bin/bash

# Configure path exports.
export PATH="/usr/local/sbin:$PATH"

# Generic variable configuration.
export GREP_COLORS='fn=0;31'

# Returns the active branch of the GIT repository in the current directory.
function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Outputs the results of the specified on the terminal together with the 
# number of results/lines printed.
# $1: The command to execute.
# $2: The (singular) description what items are printed as a result.
function lst {
  local lst=$(eval "$1 | sed '/^total/d'")
  echo "$lst" | GREP_COLOR=32 egrep --color "$USER|$"
  local cnt=`echo "$lst" | wc -l`
  printf "\033[0;33m$cnt $2(s) listed\033[0m\n"
}

# Listing aliases. The user name of the owner effecting the listing alias is 
# highlighted in the displayed results. A count of the objects listed is also 
# provided.
# The 'll' and 'la' aliases list visible files and all files respectively; 'lld'
# and 'llf' list all directories and all files respectively.
alias ll='lst "CLICOLOR_FORCE=1 ls -l" "object"'
alias la='lst "CLICOLOR_FORCE=1 ls -la" "object"'
alias lld='lst "CLICOLOR_FORCE=1 ls -la | grep --color=never ^d" "dir"'
alias llf='lst "CLICOLOR_FORCE=1 ls -la | grep --color=never ^-" "file"'

# Override 'grep' to always enable color matching.
alias grep='grep --color=always'

# The 'cleanup' alias find and deletes macOS .DS_Store files recursively, 
# starting from the current directory.
alias cleanup='find . -type f -name "*.DS_Store" -delete'

# The 'brewup' alias effects a slew of actions to ensure that we are always 
# ready to brew.
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'

# Directory aliases to make traversal less painful.
alias home='cd ~'
alias dropbox='cd ~/Dropbox'
alias downloads='cd ~/Downloads'
alias library='cd ~/Library'

# Terminal colors and prompt customization.
export CLICOLOR=1
export LSCOLORS=bxfxCxDxBxegedabagaced
export PS1="\[\033[0;32m\]\u\[\033[0m\]@\[\033[0;36m\]\h:\[\033[0;33m\]\W\$(parse_git_branch)\[\033[0m\]$ "