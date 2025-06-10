# Luke's config for the Zoomer Shell
# credit: https://github.com/LukeSmithxyz/voidrice/blob/master/.config/zsh/.zshrc

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt inc_append_history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

_fix_cursor() {
   echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor)

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' '^ulfcd\n'

bindkey -s '^a' '^ubc -lq\n'

bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# Load syntax highlighting; should be last.
source $HOME/applications/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

if [ -f /media/veracrypt1/.api ]; then
	. /media/veracrypt1/.api
fi

export EDITOR=vim

# I want to be able to run these commands anywhere
PATH="$PATH:/home/kab/docs/my_scripts/"
PATH="$PATH:/home/kab/applications/lilypond-2.24.4/bin/"
PATH="$PATH:/home/kab/applications/emsdk:/home/kab/applications/emsdk/node/20.18.0_64bit/bin:/home/kab/applications/emsdk/upstream/emscripten"

# makes held keys debounce faster
xset r rate 300 40

# prevent oops moments
alias cpass='\pass -c'
alias iknowwhatiamdoingpass='\pass'
alias pass='echo use iknowwhatiamdoingpass or cpass'

export SUDO_ASKPASS=/usr/bin/ssh-askpass

alias shutdown='\systemctl poweroff'
alias reboot='\systemctl reboot'
set -o vi

export WINEPREFIX=~/.wine-new
export WGETRC=~/.config/.wgetrc
alias wget='\wget --hsts-file=~/.local/state/.wget-hsts'
export LESSHISTFILE=~/.local/state/lesshst



if [ -e ~/Downloads ]; then
    rm -r ~/Downloads
fi

[ -f "/home/kab/.ghcup/env" ] && . "/home/kab/.ghcup/env" # ghcup-env
. "/home/kab/.deno/env"

export wiki="${HOME}/docs/indepthwiki/wiki"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
