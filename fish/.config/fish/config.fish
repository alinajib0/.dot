# caps lock as esc in tty
# if test -z "$DISPLAY" && string match -qr '^/dev/tty[0-9]+$' (tty)
#   doas loadkeys ~/.config/loadkeys/loadkeysrc
# end

# startx in tty1 after login
# if test -z "$DISPLAY" -a (tty) = "/dev/tty1"
#   exec startx
# end

# change fish greeting
function fish_greeting
  fastfetch
end

# init in start
zoxide init fish | source

# vars
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx HOME /home/najib
set -gx SHELL fish
set -gx TERMINAL alacritty
set -gx BROWSER librewolf
set -gx FILE_BROWSER nnn
set -gx PAGER less
set -gx NVIM_APPNAME "nvim"
set -gx MAIN_PROJECT "chefio"
set -gx PATH "$HOME/.cargo/bin/:$PATH"
set -gx ATAC_KEY_BINDINGS ~/.config/atac/keys.toml

# aliases

# xbps
alias i='sudo pacman -S'
alias u='i; sudo pacman -Syu'
alias q='pacman -Qs'
alias r='sudo pacman -R'
alias lspk='pacman -Ql'

# listing 
alias l 'eza --color=auto -l --icons=always'
alias ll 'eza --color=auto -la --icons=always'
alias ls 'eza --color=auto --icons=always'
alias la 'eza --color=auto -a --icons=always'
alias lt 'eza --color=auto -T --icons=always'
alias lta 'eza --color=auto -aT --icons=always'

# replacements
alias cd __zoxide_z
alias cdi __zoxide_zi
alias cat bat

# shortcuts
alias v nvim
alias vi nvim
alias vim nvim
alias lg lazygit
alias e exit
alias a tgpt
alias f nnn

# pomodoro
alias s "timer -f -c 25:00"
alias b "timer -f -c 05:00"
alias p "s && b && s && b && s && b && s"

# customs

# fzf customs
alias czf 'cat (fzf --preview="bat {}")'
alias nzf 'nvim (fzf --preview="bat {}")'
alias cdf 'cd (fzf --preview="bat {}")'

# random customs
alias j 'setxkbmap -layout us,ara -variant ,digits -option altwin:swap_alt_win -option grp:alt_caps_toggle caps:escape'
alias xclipc 'xclip -selection clipboard'
alias lsn "cat ~/.config/nnn/.selection | tr '\\0' '\\n'"
alias nvchad 'NVIM_APPNAME="nvim_nvchad" nvim'
alias ktmux "tmux kill-server"
alias start "tmuxifier s"

# nnn config

# plugins
set -gx NNN_PLUG 'c:-!bat --paging always "$nnn"*;l:-!git log;d:-!git diff;s:!git status -s;g:!lazygit;m:gitroot;v:!convert "$nnn" png:- | xclip -sel clipboard -t image/png*;h:!du -sh "$nnn";j:autojump;L:fzplug;e:suedit;k:pskill;t:preview-tui;p:preview-tabbed'
set -gx NNN_FIFO "/tmp/nnn.fifo"
set -gx NNN_TRASH 1
set -gx NNN_COLORS 5236
set -gx NNN_FCOLORS 0404040000000600010F0F02

# fzf color
set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS \
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
