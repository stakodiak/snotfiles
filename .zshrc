export PYENV_VERSION=3.7.0  # Set your preferred Python version.
export PYENV_ROOT=~/.pyenv
export PIPX_BIN_DIR=~/.local/bin
export -U PATH path         # -U eliminates duplicates
path=(
    $PIPX_BIN_DIR
    $PYENV_ROOT/{bin,shims}
    /Users/mcalex/Library/Python/3.9/bin
    $path
)
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/alexander/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ll="ls -lrtG"
# check if any aliases exist
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# print dir when moving there
cd() { builtin cd "$@" && ls -lthrG; }

set -o vi
alias vi='vim -w ~/.vimlog '

# for being sneaky
alias pvi='/usr/local/bin/vim -c "set viminfo="'
alias pm='/usr/local/bin/vim -c "set viminfo=" ~/.passwords'

# track bash history forever
# TODO zsh history forever
# shopt -s histappend
# export PROMPT_COMMAND="history -a"
# export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "#$(date "+%s") $(pwd) $(history 1)" >> ~/.bash-event-history; fi'
# export HISTFILESIZE=
# export HISTSIZE=
# export HISTTIMEFORMAT="[%F %T] "

# Change the file location because certain bash sessions truncate
# .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt SHARE_HISTORY


# bring back reverse search
bindkey -e

export LC_CTYPE=C
export LANG=C

# Git shortcuts.
alias gs="git status"
alias gcp="git cherry-pick"
alias gc="git checkout"
alias gd="git diff"
alias gl="git log"
alias gg="git grep"
alias ga="git add"
alias gb='git checkout $(git branch | fzf)'


# shortcut for finding files by prefix
ff () {
    find . -name "$1*"
}

# find repo file with fuzzy search, then edit it
alias f='vi $(git ls-files | fzf)'

# `fd` - cd to selected directory
# from: https://github.com/junegunn/fzf/wiki/examples
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# enable iTerm shell integration
#/ test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# open editor for daily notes
today() {
  date "+%H:%M" >> ~/notes/`date +'%m-%d'`.txt;
  /usr/bin/vim -c "set viminfo=|set tw=73 | set statusline+=%{wordcount().words}\ words | set laststatus=2" + ~/notes/`date +'%m-%d'`.txt
}
yesterday() {
  /usr/bin/vim -c "set viminfo=|set tw=73 | set statusline+=%{wordcount().words}\ words | set laststatus=2" ~/notes/`date -r $(date +%s - 86400) +'%m-%d'`.txt
}

# Homebrew has lost this privilege
HOMEBREW_NO_AUTO_UPDATE=1

# simplify a typical workflow for counting list items
count() {
  sort | uniq -c | sort -n k1
}

# work for 25 minutes
work() {
  (

   osascript -e 'display notification "Please work for 25 minutes." with title "Time to begin" ';
   sleep 1500;
   osascript -e 'display notification "Break has started" with title "A bell will sound in five minutes." sound name "bell"';
   sleep 300;
   osascript -e 'display notification "Finished break" with title "Run `work`command again to continue." sound name "bell"';
  )&! > /dev/null 2>&1 disown
}

# limit `man` output to 80 characters
# (https://stackoverflow.com/questions/30173224/change-width-of-man-command-ouput)
alias man='MANWIDTH=$((COLUMNS > 80 ? 80 : COLUMNS)) man'

# relax with a weather report
arkansas() {
  curl "https://forecast.weather.gov/product.php?site=LZK&issuedby=LZK&product=RWS&format=CI&version=1&glossary=0" 2>>/dev/null | selector pre | re '\n' ' ' | re '.*2019' | re '  ' '\n\n' | re '((.){62} )' '\1\n' | trim
}

# add chrome alias for headless use
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

# fshow - git commit browser
# from https://github.com/junegunn/dotfiles/blob/master/bashrc
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --header "Press CTRL-S to toggle sort" \
      --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                 xargs -I % sh -c 'git show --color=always %'" \
      --bind "enter:execute:echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
              xargs -I % sh -c 'vim fugitive://\$(git rev-parse --show-toplevel)/.git//% < /dev/tty'"
}



# yes i pugs
export PATH=/usr/local/pugs:$PATH

mrs() { curl 2>>/dev/null https://mrs.computer/$* }
ph() { curl 2>>/dev/null https://peahound.com/search?q=$* }

alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport'

source ~/.iterm2_shell_integration.zsh

