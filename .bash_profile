# Tell grep to highlight matches
export GREP_OPTIONS="--color=auto"
alias ll="ls -l"
alias j="jump"

# Setting PATH for Python 3.3
# The orginal version is saved in .bash_profile.pysave
PATH="/usr/local/bin:/Library/Frameworks/Python.framework/Versions/3.3/bin:${PATH}"
export PATH
export PATH="$PATH:/usr/local/mysql/bin"
export PATH="$PATH:/usr/local/bin"

# Keep log of all vi commands.
alias vi='vim -w ~/.vimlog '

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

# Git shortcuts.
alias gs="git status"
alias gcp="git cherry-pick"
alias gc="git checkout"
alias gd="git diff"
alias gl="git log"
alias gg="git grep"
alias ga="git add"
alias gb='git checkout $(git branch | fzf)'

# pugs utilities
export PATH=/usr/local/pugs:$PATH

ff () {
    find . -name "$1*"
}

# Enable 256-bit colors in iTerm.
export TERM='xterm-256color'

# fd - cd to selected directory
# from: https://github.com/junegunn/fzf/wiki/examples
alias f='vi $(git ls-files | fzf)'
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# Add directory marks.
export MARKPATH=$HOME/.marks
function jump {
  cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
  mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
  rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
}
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark

_complete_invoke() {
    local candidates

    # COMP_WORDS contains the entire command string up til now (including
    # program name).
    # We hand it to Invoke so it can figure out the current context: spit back
    # core options, task names, the current task's options, or some combo.
    candidates=`invoke --complete -- ${COMP_WORDS[*]}`

    # `compgen -W` takes list of valid options & a partial word & spits back
    # possible matches. Necessary for any partial word completions (vs
    # completions performed when no partial words are present).
    #
    # $2 is the current word or token being tabbed on, either empty string or a
    # partial word, and thus wants to be compgen'd to arrive at some subset of
    # our candidate list which actually matches.
    #
    # COMPREPLY is the list of valid completions handed back to `complete`.
    COMPREPLY=( $(compgen -W "${candidates}" -- $2) )
}


# Tell shell builtin to use the above for completing 'inv'/'invoke':
# * -F: use given function name to generate completions.
# * -o default: when function generates no results, use filenames.
# * positional args: program names to complete for.
complete -F _complete_invoke -o default invoke inv
