. "$HOME/.dotfiles/secrets"
. "$HOME/work/spell/env/source"

export EDITOR="mvim -v"
export VISUAL="mvim -v"
export PAGER=less

shopt -s histappend
export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL=ignoredups:erasedups
export PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"

# python
export PATH=/usr/local/opt/python/libexec/bin:$PATH

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/trey/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/Users/trey/Downloads/google-cloud-sdk/path.bash.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/trey/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/trey/Downloads/google-cloud-sdk/completion.bash.inc'; fi

eg(){
  MAN_KEEP_FORMATTING=1 man "$@" 2>/dev/null \
    | gsed --quiet --expression='/^E\(\x08.\)X\(\x08.\)\?A\(\x08.\)\?M\(\x08.\)\?P\(\x08.\)\?L\(\x08.\)\?E/{:a;p;n;/^[^ ]/q;ba}' \
    | ${MANPAGER:-${PAGER:-pager -s}}
}

alias ll="ls -alhFG"
alias fucking="sudo"
alias ip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d\  -f2"
alias src="source ~/.bash_profile"
alias profile="vim ~/.bash_profile"
alias vimrc="vim ~/.vimrc"
alias grep="grep --color=auto -nIs"
alias ps="ps axu"
alias hist='history  | grep'
alias vim="mvim -m"

alias gcm="git commit -m"
alias gca="git commit --amend"
alias gco="git checkout"
alias ga="git add"
alias glol="git log --all --color --graph --pretty=format:'%Cred%h%Creset%x09%C(yellow)%d%Creset %s %C(cyan)(%cr) %C(blue)[%an]%Creset' --abbrev-commit"
alias gb="git branch"
alias gd="git diff -w"
alias gf="git fetch -p && git fetch -t"
alias gr="git rebase"
alias gbr="hub browse"
alias gcp="git cherry-pick"
alias gdc="git diff --name-only"
alias to-review="open https://github.com/spellrun/spell/pulls/review-requested/TreyLawrence"
alias my-prs="open https://github.com/spellrun/spell/pulls/TreyLawrence"

. "$HOME/.dotfiles/.alias_completion.sh"

function changes() {
  gdc "$1" | xargs mvim
}

# Processes your git status output, exporting bash variables
# for the filepaths of each modified file.
# To ensure colored output, please run: $ git config --global color.status always
# Written by Nathan D. Broadbent (www.madebynathan.com)
# -----------------------------------------------------------
gs() {
  pfix="g" # Set your preferred shortcut letter here
  max_changes=500  # Max changes before reverting to standard 'git status' (can be very slow otherwise)
  IFS=$'\n'
  # Only export variables for less than $max_changes
  status=`git status -s`
  if [ `echo "$status" | wc -l` -lt $max_changes ]; then
    f=0  # Counter for the number of files
    for line in $status; do
      file=$(echo $line | sed 's/.* //g')
      let f++
      files[$f]=$file         # Array for formatting the output
      export $pfix$f=$file   # Exporting variable for use.
    done

    status=`git status`    # Fetch full status

    # Search and replace each line, showing the exported variable name next to files.
    for line in $status; do
      i=1
      while [ $i -le $f ]; do
        search=${files[$i]}
        replace="\033[2;37m[\033[1m\$$pfix$i\033[2;37m]\033[0m $search "
        #echo $replace
        # (fixes a case when a file contains another file as a substring)
        line=${line/$search/$replace }   # Substitution for files with a space suffix.
        line=${line/%$search/$replace}    # Substitution for files with a newline suffix.
        let i++
      done
      echo -e $line                        # Print the final transformed line.
    done
  else
    # If there are too many changed files, this 'gs' function will slow down.
    # In this case, fall back to plain 'git status'
    git status
  fi
  # Reset IFS separator to default.
  unset IFS
}
parse_git_dirty () {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}
parse_git_branch () {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/*\(.*\)/\1$(parse_git_dirty)/"
}

export PS1="\[\e[0;36m\]\u@\h\[\e[m\] \[\e[0;34m\]\w\[\e[m\] \[\e[0;33m\]\$(parse_git_branch)\[\e[m\]\$ "
