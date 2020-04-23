# ~/dotfiles-mac/bashrc

# Environment variable exports

# Improved less functionality
# https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --no-init --window=-8'

# Set nvim/vim as the default editor if either are installed
if [ -x "$(command -v nvim)" ]; then
  export EDITOR=nvim
else
  export EDITOR=vi
fi

# end PATH exports

# Prompt configuration {{{
# Git prompt script needs to be manually updated every so often from https://github.com/git/git/tree/contrib/completion
GITPROMPT="$HOME/dotfiles/bash_completion/git-prompt.sh"
if [ -f  "$GITPROMPT" ]; then
  source "$GITPROMPT"
  export GIT_PS1_SHOWDIRTYSTATE=1
  # NORMALBLACK="\[\033[0;30m\]"
  # NORMALRED="\[\033[0;31m\]"
  # NORMALGREEN="\[\033[0;32m\]"
  # NORMALYELLOW="\[\033[0;33m\]"
  NORMALBLUE="\[\033[0;34m\]"
  # NORMALMAGENTA="\[\033[0;35m\]"
  # NORMALCYAN="\[\033[0;36m\]"
  # NORMALWHITE="\[\033[0;37m\]"

  # BRIGHTBLACK="\[\033[1;30m\]"
  BRIGHTRED="\[\033[1;31m\]"
  # BRIGHTGREEN="\[\033[1;32m\]"
  # BRIGHTYELLOW="\[\033[1;33m\]"
  BRIGHTBLUE="\[\033[1;34m\]"
  # BRIGHTMAGENTA="\[\033[1;35m\]"
  # BRIGHTCYAN="\[\033[1;36m\]"
  # BRIGHTWHITE="\[\033[1;37m\]"

  RESETCOLOR="\[\033[0m\]"
  export PS1="$NORMALBLUE\u $BRIGHTBLUE\W$BRIGHTRED\$(__git_ps1)$RESETCOLOR \$ "
fi
#}}}

# end env exports

# Aliases

# Improved ls functionality {{{
# https://www.topbug.net/blog/2016/11/28/a-better-ls-command/
eval "$(dircolors)"
# For linux
alias ls='ls --group-directories-first -F -h --color=always -v'

# For locally defined aliases that don't need to be included in this config
# ALIASFILE= "$HOME/.bash_aliases"
if [ -f ~/.bash_aliases ]; then
   source ~/.bash_aliases
 else
   echo "# Local aliases that dont belong in the dotfiles can be defined here" > ~/.bash_aliases
   echo "A local aliases file has been created at ~/.bash_aliases."
   echo "Define any aliases you only need on this computer in there."
fi
# }}}

# end Aliases

# Highlighted man page output in linux and macos {{{
eval "$(dircolors)"
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man $@
}
#}}}

# Git completion for branch names, subcommands, and more
GITCOMPLETION="$HOME/dotfiles/bash_completion/git-completion.bash"
if [ -f "$GITCOMPLETION" ]; then
  source "$GITCOMPLETION"
fi

# Required for NVM
# https://github.com/nvm-sh/nvm#manual-install
if [ ! -x "$(command -v nvm)" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ex: set foldmethod=marker:
