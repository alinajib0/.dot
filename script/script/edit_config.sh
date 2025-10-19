#!/bin/bash

# Simple config editor using associative arrays
declare -A CONFIG_PATHS=(
  ["alacritty"]="$HOME/.dot/alacritty/.config/alacritty/"
  ["btop"]="$HOME/.dot/btop/.config/btop/"
  ["nvim"]="$HOME/.config/nvim/"
  ["nvim_keymap"]="$HOME/.config/nvim/lua/keymaps.lua"
  ["fastfetch"]="$HOME/.dot/fastfetch/.config/fastfetch/config.jsonc"
  ["eza"]="$HOME/.dot/eza/.config/eza/theme.yml"
  ["glow"]="$HOME/.dot/glow/.config/glow/glow.yml"
  ["git"]="$HOME/.dot/gitconfig/.gitconfig"
  ["dunst"]="$HOME/.dot/dunst/.config/dunst/dunstrc"
  ["fish_config"]="$HOME/.dot/fish/.config/fish/config.fish"
  ["fish"]="$HOME/.dot/fish/.config/fish/"
  ["mpv"]="$HOME/.dot/mpv/.config/mpv/"
  ["mpv_keymap"]="$HOME/.dot/mpv/.config/mpv/input.conf"
  ["mpv_script"]="$HOME/.dot/mpv/.config/mpv/script-opts/"
  ["picom"]="$HOME/.dot/picom/.config/picom/picom.conf"
  ["zathura"]="$HOME/.dot/zathura/.config/zathura/zathurarc"
  ["tmux"]="$HOME/.dot/tmux/.config/tmux/tmux.conf"
  ["sxhkd"]="$HOME/.dot/sxhkd/.config/sxhkd/sxhkdrc"
  ["autostart"]="$HOME/.dot/script/script/autostart.sh"
  ["scripts"]="$HOME/.dot/script/script/"
  ["slstatus"]="$HOME/.dot/src/src/slstatus/config.h"
  ["dwmblocks"]="$HOME/.dot/src/src/dwmblocks/config.h"
  ["dmenu_config"]="$HOME/.dot/src/src/dmenu/config.h"
  ["dmenu_patches"]="$HOME/.dot/src/src/dmenu/patches.h"
  ["dwm_config"]="$HOME/.dot/src/src/dwm/config.h"
  ["dwm_patches"]="$HOME/.dot/src/src/dwm/patches.h"
  [".dot_.gitignore"]="$HOME/.dot/.gitignore"
  [".dot"]="$HOME/.dot"
  [".config"]="$HOME/.config"

  # for scripts
  [":apple"]=""
)

declare -A RELOAD_COMMANDS=(

  ["fish"]="source ~/.config/fish/config.fish"
  ["sxhkd"]="pkill -USR1 -x sxhkd"
  ["slstatus"]="cd $HOME/src/slstatus/ && sudo make install clear && pkill slstatus && slstatus & disown"
  ["dwmblocks"]="cd $HOME/src/dwmblocks/ && sudo make install clear && kill -10 $(
    │ pidof dwmblocks
  )"
  ["dwm_config"]="cd $HOME/src/dwm/ && sudo make install clear && pkill dwm"
  ["dwm_patches"]="cd $HOME/src/dwm/ && sudo make install clear && pkill dwm"
  ["dmenu_config"]="cd $HOME/src/dwm/ && sudo make install clear"
  ["dmenu_patches"]="cd $HOME/src/dwm/ && sudo make install clear"

  # for script
  [":apple"]="notify-send 'text apple'"
)

# Show menu and get selection
selection=$(printf "%s\n" "${!CONFIG_PATHS[@]}" | fzf)

if [[ -n "$selection" ]]; then
  config_path="${CONFIG_PATHS[$selection]}"
  reload_command="${RELOAD_COMMANDS[$selection]}"

  # Edit with nvim if it exists
  if [[ -n "$config_path" ]]; then
    notify-send "Edit: $config_path"
    $TERMINAL -e nvim "$config_path"
  fi

  # Run reload command if it exists
  if [[ -n "$reload_command" ]]; then
    notify-send "Running: $reload_command"
    eval "$reload_command"
  fi

fi
