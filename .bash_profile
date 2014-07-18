[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

. "$HOME/Documents/arcanist/arcanist/resources/shell/bash-completion"
. "$HOME/.dotfiles/secrets"

export GOROOT="/usr/local/Cellar/go/1.2/libexec"
export GOPATH="$HOME/go:$HOME/Documents/branded/go"
export PATH="usr/local/bin:/usr/local/sbin:~/bin:$PATH"
export PATH="$PATH:/Users/treylawrence/Documents/arcanist/arcanist/bin:${GOROOT//://bin:}:${GOPATH//://bin:}/bin"
export EDITOR="mvim -v"
export VISUAL="mvim -v"

shopt -s histappend
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoredups:erasedups
export PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"

export OPSCODE_USERNAME=treylawrence

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

eval "$(hub alias -s)"

alias ll="ls -alhFG"
alias fucking="sudo"
alias ip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d\  -f2"
alias src="source ~/.bash_profile"
alias profile="vim ~/.bash_profile"
alias vimrc="vim ~/.vimrc"
alias grep="grep --color=auto -nIs"
alias ps="ps axu"
alias hist='history  | grep'
alias vim="mvim -v"
alias omgwtf="killall {vfe,sfe,echub,fswatch}{,_test}"
alias yolo="git fetch && git rebase origin/master && arc land"
alias startpostgres='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias tunnel_jenkins='ssh -N -T -i ~/.ssh/jellojenkins.pem -L 5900:localhost:5900 ubuntu@jenkins.jellolabs.com &'
alias vnc_jenkins='/Applications/Chicken.app/Contents/MacOS/Chicken localhost:5900'
alias branded="goose -path db/branded"
alias echub="goose -path db/echub"

alias gcm="git commit -m"
alias gca="git commit --amend"
alias gco="git checkout"
alias ga="git add"
alias glol="git log --all --color --graph --pretty=format:'%Cred%h%Creset%x09%C(yellow)%d%Creset %s %C(cyan)(%cr) %C(blue)[%an]%Creset' --abbrev-commit"
alias gb="git branch"
alias gd="git diff -w"
alias gf="git fetch -p && git fetch -t"
alias gr="git rebase"
alias gbr="git browse"
alias gcp="git cherry-pick"

. "$HOME/.dotfiles/.alias_completion.sh"

function tmparc() {
    GOPATH_bak=$GOPATH
    echo "Setting to $GOPATH from $GOPATH_bak"
    export GOPATH="/tmp/branded/go:$GOPATH"
    echo "rsyncing ~/Documents/branded to /tmp/"
    rsync -a --delete ~/Documents/branded /tmp/
    pushd /tmp/branded
    arc "$@" || arc "$@" && popd; export GOPATH=$GOPATH_bak; echo "Reset go path"
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
  status=`git status --porcelain`
  if [ `echo "$status" | wc -l` -lt $max_changes ]; then
    f=0  # Counter for the number of files
    for line in $status; do
      file=$(echo $line | sed "s/^...//g")
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
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
parse_git_branch () {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/*\(.*\)/\1$(parse_git_dirty)/"
}

export PS1="\[\e[0;36m\]\u@\h\[\e[m\] \[\e[0;34m\]\w\[\e[m\] \[\e[0;33m\]\$(parse_git_branch)\[\e[m\]\$ "
