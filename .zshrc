# Starship initialization.
eval "$(starship init zsh)"

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
# The 'll' and 'la' aliases list visible files and all files respectively; 'ld'
# and 'lf' list all directories and all files respectively.
alias ll='lst "CLICOLOR_FORCE=1 ls -l" "object"'
alias la='lst "CLICOLOR_FORCE=1 ls -la" "object"'
alias ld='lst "CLICOLOR_FORCE=1 ls -la | grep --color=never ^d" "dir"'
alias lf='lst "CLICOLOR_FORCE=1 ls -la | grep --color=never ^-" "file"'

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

# Path variables.
export JAVA_HOME="/opt/homebrew/Cellar/openjdk/22/libexec/openjdk.jdk/Contents/Home"
export ERL_HOME="/usr/local/Cellar/erlang/27.2/lib/erlang"
export OPENBLAS_HOME="/opt/homebrew/opt/openblas/lib"
export REBAR3_HOME="/Users/duncan/.cache/rebar3"
export PATH="$JAVA_HOME/bin:$ERL_HOME/bin:$OPENBLAS_HOME:$REBAR3_HOME/bin:$PATH"

# Homebrew configuration.
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_AUTOREMOVE=1
export HOMEBREW_DISPLAY_INSTALL_TIMES=1
export HOMEBREW_NO_INSTALL_UPGRADE=1

# Slack API configuration.
export SLACK_API_TOKEN_BOT=""
export SLACK_USER=""
export SLACK_USER_ID=""

# Opam configuration.
[[ ! -r /Users/duncan/.opam/opam-init/init.zsh ]] || source /Users/duncan/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
