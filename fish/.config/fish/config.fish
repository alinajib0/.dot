if test -z "$DISPLAY" && string match -qr '^/dev/tty[0-9]+$' (tty)
  doas loadkeys ~/.config/loadkeys/loadkeysrc
end

if test -z "$DISPLAY" -a (tty) = "/dev/tty1"
  exec startx
end

function fish_greeting
	fastfetch
end

# opencode
fish_add_path /home/najib/.opencode/bin

# tmuxifier
fish_add_path ~/.config/tmux/plugins/tmuxifier/bin

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx HOME /home/najib
set -gx SHELL fish
set -gx TERMINAL alacritty
set -gx BROWSER librewolf
set -gx FILE_BROWSER nnn
set -gx PAGER less
set -gx NVIM_APPNAME "nvim"

alias i 'doas pacman -S'
alias u 'doas pacman -Syu'
alias q 'pacman -Ss'
alias r 'doas pacman -Rns'
alias lspk 'pacman -Qe'

alias cat bat
alias cd __zoxide_z
alias cdi __zoxide_zi
alias e exit

alias l 'eza --color=auto -l --icons=always'
alias ll 'eza --color=auto -la --icons=always'
alias ls 'eza --color=auto --icons=always'
alias la 'eza --color=auto -a --icons=always'
alias lt 'eza --color=auto -T --icons=always'
alias lta 'eza --color=auto -aT --icons=always'

alias czf 'fzf --preview="bat {}"'
alias nzf 'nvim $(fzf --preview="bat {}")'
alias cdf 'cd $(fzf --preview="bat {}")'
alias j 'setxkbmap -layout us,ara -variant ,digits -option altwin:swap_alt_win -option grp:alt_caps_toggle caps:escape'
alias xclipc 'xclip -selection clipboard'
alias nvchad 'NVIM_APPNAME="nvim_nvchad" nvim'

alias v nvim
alias vi nvim
alias vim nvim
alias lg lazygit

fish_config theme choose "Rosé Pine Moon"

zoxide init fish | source

eval (tmuxifier init - fish)

# eza dracula 
set -gx EXA_COLORS "\
uu=36:\
gu=37:\
sn=32:\
sb=32:\
da=34:\
ur=34:\
uw=35:\
ux=36:\
ue=36:\
gr=34:\
gw=35:\
gx=36:\
tr=34:\
tw=35:\
fi=37"

# dracula fzf
set -Ux FZF_DEFAULT_OPTS "--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

# set -gx NNN_PLUG='n:nuke;j:autojump;o:fzopen;p:preview-tui;t:preview-tabbed;i:imgview;f:fzcd;m:nmount;x:xdgdefault;p:finder;'
set -gx NNN_PLUG 'j:autojump;f:fzopen;l:fzplug;c:gitroot;s:!git status -s;g:!lazygit;m:nmount;S:suedit;k:pskill;x:xdgdefault;t:preview-tui;p:preview-tabbed'

# set -gx NNN_OPENER "/home/alinajib/.config/nnn/plugins/nuke" # Default opener for GUI files
set -gx NNN_COLORS 5236

# NNN dracula
set -gx NNN_FCOLORS 0404040000000600010F0F02
set -gx NNN_FIFO "/tmp/nnn.fifo"
set -gx NNN_FCOLORS 0404040000000600010F0F02
# set -gx NNN_BMS "h:~;d:~/Download;p:~/photo;c:~/.config;"
set -gx NNN_TRASH 1
set -gx NNN_MCLICK ls # for midle click

alias lsn "cat ~/.config/nnn/.selection | tr '\\0' '\\n'"

