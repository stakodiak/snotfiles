# check if any aliases exist
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# print dir when moving there
cd() { builtin cd "$@" && ls -lthrG; }

set -o vi

# color terminal output
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export GREP_OPTIONS="--color=always"

# Setting PATH for Python 3.3
PATH="/usr/local/bin:/Library/Frameworks/Python.framework/Versions/3.3/bin:${PATH}"
export PATH
export PATH="$PATH:/usr/local/mysql/bin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:~/.npm-packages/bin"
export PATH="$PATH:/Users/alexander/Library/Python/2.7/bin"
export PATH="$PATH:/Users/alexander/Library/Python/3.6/bin"
# log all vi keystrokes
alias vi='vim -w ~/.vimlog '

# for being sneaky
alias pvi='/usr/local/bin/vim -c "set viminfo="'

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
export HISTFILE=~/.bash_eternal_history

# Git shortcuts.
alias gs="git status"
alias gcp="git cherry-pick"
alias gc="git checkout"
alias gd="git diff"
alias gl="git log"
alias gg="git grep"
alias ga="git add"
alias gb='git checkout $(git branch | fzf)'

# clean up this garbage command
alias ll="ls -lG"

# pugs utilities
export PATH=/usr/local/pugs:$PATH

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
  pvi -c "set tw=72" ~/tmp/brandonblogger/`date +'%m-%d'`.txt
}

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

# enable `z`
. /usr/local/etc/profile.d/z.sh
python="python3"
alias python="python3"
