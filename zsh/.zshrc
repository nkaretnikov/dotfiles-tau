# Vi mode.
bindkey -v

# Avoid a 0.4 second delay when hitting 'Esc'.
export KEYTIMEOUT=1

# Show the current directory.
export PS1="%B[%n@%m:%~]%#%b "

# Show the current vi mode.
# http://www.zsh.org/mla/users/2006/msg01185.html
function zle-line-init zle-keymap-select {
  RPS1="${${KEYMAP/vicmd/}/(main|viins)/-- INSERT --}"
  RPS2=$RPS1
  RPS3=$RPS1
  RPS4=$RPS1
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

export EDITOR=vim
export C_INCLUDE_PATH=/home/nikita/.nix-profile/include
export LIBRARY_PATH=/home/nikita/.nix-profile/lib

alias git-current='git branch | grep \* && git rev-parse HEAD'
alias hstags='hasktags -c -L -S -R -a'
