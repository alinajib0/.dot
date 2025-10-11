# @fish-lsp-disable 2002
# caps lock as esc in tty
if test -z "$DISPLAY" && string match -qr '^/dev/tty[0-9]+$' (tty)
  sudo loadkeys ~/.config/loadkeys/loadkeysrc
end

# startx in tty1 after login
# if test -z "$DISPLAY" -a (tty) = "/dev/tty1"
#   exec startx
# end

# change fish greeting
function fish_greeting
    echo WELCOME
end

# init in start
zoxide init fish | source

# for bat-extrs
batman --export-env >/dev/null

# for add wikiman key for fish (ctl + f)
source /usr/share/wikiman/widgets/widget.fish

# fish ablite
fzf --fish | source

# source $HOME/.local/bin/env.fish
# set -gx PATH "/home/najib/.config/herd-lite/bin" $PATH
# set -gx PHP_INI_SCAN_DIR "/home/najib/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# vars
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx HOME /home/najib
set -gx SHELL fish
set -gx TERM alacritty
set -gx TERMINAL alacritty
set -gx BROWSER librewolf
set -gx FILE_BROWSER nnn
set -gx PAGER less
set -gx NVIM_APPNAME nvim
set -gx MAIN_PROJECT test
set -gx PATH "$HOME/.cargo/bin/:$PATH"
set -gx ATAC_KEY_BINDINGS ~/.config/atac/keys.toml
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p"

# aliases

# pacman
alias i 'sudo pacman -S'
alias u 'sudo pacman -Syu'
alias q 'pacman -Ss'
alias r 'sudo pacman -Rns'
alias lspk 'pacman -Qe'

# listing 
alias l 'eza -g --git --color=auto -l --icons=always --group-directories-first'
alias ll 'eza -g --git --color=auto -la --icons=always --group-directories-first'
alias ls 'eza -g --git --color=auto --icons=always --group-directories-first'
alias la 'eza -g --git --color=auto -a --icons=always --group-directories-first'
alias lt 'eza -g --git --color=auto -T --icons=always --group-directories-first'
alias lta 'eza -g --git --color=auto -aT --icons=always --group-directories-first'
alias llt 'eza -g --git --color=auto -lT --icons=always --group-directories-first'
alias llta 'eza -g --git --color=auto -laT --icons=always --group-directories-first'

# replacements
alias cd __zoxide_z
alias cdi __zoxide_zi
alias cat bat
alias man batman

# shortcuts
alias v nvim
alias vi nvim
alias vim nvim
alias lg lazygit
alias e exit
alias a llm
alias bsr ddgr
alias sr 'BROWSER="w3m" "ddgr"'
alias x tmux
alias mv "mv -i"
alias rm "rm -Iv"
alias df "df -h"
alias du "du -h -d 1"
alias k killall

# pomodoro
alias s "timer -c 15:00"
alias b "timer -c 05:00"
alias P "s && b && s && b && s && b && s"

# harsh habit tracker
alias ta "harsh ask"
alias tl "harsh log"
alias ts "harsh log stats"
alias te "nvim $HOME/.config/harsh/habits"
alias tel "nvim $HOME/.config/harsh/log"

# notes
alias n "nvim $HOME/notes"

# customs

# random customs
alias lazyvim 'NVIM_APPNAME="lazyvim" nvim'
alias nvchad 'NVIM_APPNAME="nvchad" nvim'
alias j 'setxkbmap -layout us,ara -variant ,digits -option altwin:swap_alt_win -option grp:alt_caps_toggle caps:escape'
alias xclipc 'xclip -selection clipboard'
alias lsn "cat ~/.config/nnn/.selection | tr '\\0' '\\n'"
alias ktmux "tmux kill-server"
alias d 'yt-dlp -f 18'
alias y youtube-tui
alias c clear
alias grep batgrep
alias lsbc "lsblk | bat -l conf -p"
alias freec "free -h | bat -l cpuinfo -p"
alias bathelp 'bat --plain --language=help'

alias cf "nvim $HOME/.config/fish/config.fish && source $HOME/.config/fish/config.fish"
alias ct "nvim $HOME/.config/tmux/tmux.conf && source $HOME/.config/tmux/tmux.conf"
alias ck "nvim $HOME/.config/sxhkd/sxhkdrc && pkill -USR1 -x sxhkd"
alias cv "nvim $HOME/.config/nvim/"

function p
    ps aux | grep $argv
end
function h
    $argv --help 2>&1 | bathelp
end

# nnn config

# plugins
set -gx NNN_PLUG 'M:nmount;c:-!bat --paging always "$nnn"*;l:-!git log;d:-!git diff;s:!git status -s;g:!lazygit;m:gitroot;v:!convert "$nnn" png:- | xclip -sel clipboard -t image/png*;h:!du -sh "$nnn";j:autojump;L:fzplug;e:suedit;k:pskill;t:preview-tui;p:preview-tabbed'
set -gx NNN_TRASH 1
set -gx NNN_COLORS 5236
set -gx NNN_FCOLORS 0404040000000600010F0F02
set -x NNN_FIFO /tmp/nnn.fifo
set -x NNN_TERMINAL kitty

# fzf color

set -g FZF_CTRL_T_COMMAND "command find -L \$dir -type f 2> /dev/null | sed '1d; s#^\./##'"

set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS \
  --style minimal \
  --color 16 \
  --layout=reverse \
  --height -8 \
  --preview='bat -p --color=always {}' \

  --tmux bottom,40%
\
\
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#283457 \
  --color=bg:#16161e \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"

# fish color
set -l foreground c0caf5
set -l selection 283457
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7
# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_option $pink
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment
# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection
set --global --export HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
set --global --export HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar";
set --global --export HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew";
fish_add_path --global --move --path "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin";
if test -n "$MANPATH[1]"; set --global --export MANPATH '' $MANPATH; end;
if not contains "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH; set --global --export INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH; end;
