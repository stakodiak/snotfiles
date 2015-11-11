export CLICOLOR=1
# Tell grep to highlight matches
export GREP_OPTIONS="--color=auto"
alias ll="ls -l"
alias e="echo"

# Setting PATH for Python 3.3
# The orginal version is saved in .bash_profile.pysave
PATH="/usr/local/bin:/Library/Frameworks/Python.framework/Versions/3.3/bin:${PATH}"
export PATH

# MacPorts Installer addition on 2013-06-27_at_13:45:46: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

export PATH="$PATH:/usr/local/mysql/bin"

# Keep log of all vi commands.
alias emacs="vi"
alias vi='vim -w ~/.vimlog "$@"'

# Keep track of bash history forever.
shopt -s histappend
export PROMPT_COMMAND="history -a"
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "

# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
echo "`date`" "(`tty`)"
alias kP='killall Python'

# Git shortcuts.
alias gs="git status"
alias gcp="git cherry-pick"
alias gc="git checkout"
alias gd="git diff"
alias gl="git log"
alias gg="git grep"
alias ga="git add"

# Django doesn't work with pylint as-is.
alias djp="pylint --generated-members=objects"

# Don't delete everything.
alias rm="rm -i"

# Shortcuts for navigating around repository.
alias cdn="cd ~/newsela"
alias cdnn="cd ~/newsela/newsela"

# pugs utilities
export PATH=/usr/local/pugs:$PATH

ff () {
    find . -name "$1*"
}

# Shortcut for executing Python at the command line.
alias p="python -c"
 

# Enable 256-bit colors in iTerm.
export TERM='xterm-256color'
