# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoreboth:ignoredups:erasedups
export HISTIGNORE="&:[bf]g:exit" 
export EDITOR=vim
export TMOUT=0
export JIRA_USERNAME="wopr"
export JIRA_PASSWORD="w0prb0t"
TERM=screen
shopt -s histappend
shopt -s cdspell
shopt -s cmdhist
shopt -s dotglob

c_red='[31m'
c_green='[32m'
c_sgr0='[00m'

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

alias minify_js="/usr/bin/java -jar /export/home/netbanx/tools/yuicompressor-2.4.7/build/yuicompressor-2.4.7.jar --type js"
alias minify_css="/usr/bin/java -jar /export/home/netbanx/tools/yuicompressor-2.4.7/build/yuicompressor-2.4.7.jar --type css"
alias mxd="mux start dev"
alias mxo="mux open dev"
alias more="less"

function r_set_ssh_auth() {   
  if [[ -n $TMUX ]]; then
    NEW_SSH_AUTH_SOCK=`tmux showenv|grep ^SSH_AUTH_SOCK|cut -d = -f 2`
    if [[ -n $NEW_SSH_AUTH_SOCK ]] && [[ -S $NEW_SSH_AUTH_SOCK ]]; then 
      SSH_AUTH_SOCK=$NEW_SSH_AUTH_SOCK  
    fi
  fi
  echo '>'
}

parse_git_branch ()
{
        if git rev-parse --git-dir >/dev/null 2>&1
        then
                gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
                if git diff --quiet 2>/dev/null >&2 
                then
                        gitver=${c_green}$gitver${c_sgr0}
                else
                        gitver=${c_red}$gitver${c_sgr0}
                fi
        else
                return 0
        fi
        echo $gitver
}

set_ssh_auth ()
{
    export SSH_AUTH_SOCK=`ls -t /tmp/ssh-*/agent.* | head -n1`
    echo '>'
}

# user@host jobs command git-branch-status cwd
PS1='\n[\u@\h J\j C\! \t $(parse_git_branch)]\n$PWD $(r_set_ssh_auth) '

# User specific aliases and functions

. /export/home/netbanx/base/etc/bash.bashrc

export PATH=$PATH:~/bin

x_orig_screen=`which screen`
if [[ ! $x_orig_screen =~ "alias" ]] ; then
    export orig_screen=$x_orig_screen
fi

function _ssh_auth_save {
    if [ "$1" != "-ls" ] ; then
        if [ ! -L `basename $SSH_AUTH_SOCK` ] ; then
            user=`whoami`
            client=`echo $SSH_CLIENT | cut -d' ' -f1`
            screen_ssh_agent="/tmp/${user}-from-${client}-screen-ssh-agent.sock"

            [ -L $screen_ssh_agent ] && rm $screen_ssh_agent
            ln -s "$SSH_AUTH_SOCK" "$screen_ssh_agent"
            export SSH_AUTH_SOCK=$screen_ssh_agent
        fi
    fi
    $orig_screen "$@"
}
alias screen='_ssh_auth_save'

function tmux() {
    local tmux=$(type -fp tmux)
    case "$1" in
        update_tmux|update-environment|update-env|env-update)
            local v
            while read v; do
                if [[ $v == -* ]]; then
                    unset ${v/#-/}
                else
                    # Add quotes around the argument
                    v=${v/=/=\"}
                    v=${v/%/\"}
                    eval export $v
                fi
            done < <(tmux show-environment)
            ;;
        *)
            $tmux "$@"
            ;;
    esac
}

VLESS=$(find /usr/share/vim -name 'less.sh')
if [ ! -z $VLESS ]; then
  alias less=$VLESS
fi

# User specific aliases and functions
alias fus='prove --state=failed,save'
alias fusro='nbxtra -r ; prove --state=failed,save'
alias fusrodah='nbxtra -r ; date ; time make test ; nbxtra -r ; prove --state=failed,save'
alias ~~='cd ~/git/netbanx'
alias logs='cd /export/home/netbanx/logs'
alias findbranch='git branch | grep'
jumpbranch(){
    findbranch $1 | xargs git checkout
}
alias jumpbranch=jumpbranch
