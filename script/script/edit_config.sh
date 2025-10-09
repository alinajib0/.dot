#!/bin/bash

# Simple config editor using associative arrays
declare -A CONFIG_PATHS=(
  ["alacritty"]="$HOME/.dot/alacritty/.config/alacritty/alacritty.toml"
  ["btop"]="$HOME/.dot/btop/.config/btop/btop.conf"
  ["nvim"]="$HOME/.config/nvim/init.lua"
  ["nvim_keymap"]="$HOME/.config/nvim/lua/keymaps.lua"
  ["nvim_plugins"]="$HOME/.config/nvim/lua/plugins/"
  ["nvim_autocmd"]="$HOME/.config/nvim/lua/autocmd.lua"
  ["fastfetch"]="$HOME/.dot/fastfetch/.config/fastfetch/config.jsonc"
  ["eza"]="$HOME/.dot/eza/.config/eza/theme.yml"
  ["glow"]="$HOME/.dot/glow/.config/glow/glow.yml"
  ["git"]="$HOME/.dot/gitconfig/.gitconfig"
  ["dunst"]="$HOME/.dot/dunst/.config/dunst/dunstrc"
  ["fish"]="$HOME/.dot/fish/.config/fish/config.fish"
  ["mpv"]="$HOME/.dot/mpv/.config/mpv/mpv.conf"
  ["mpv_keymap"]="$HOME/.dot/mpv/.config/mpv/input.conf"
  ["mpv_script"]="$HOME/.dot/mpv/.config/mpv/script-opts/"
  ["picom"]="$HOME/.dot/picom/.config/picom/picom.conf"
  ["zathura"]="$HOME/.dot/zathura/.config/zathura/zathurarc"
  ["tmux"]="$HOME/.dot/tmux/.config/tmux/tmux.conf"
  ["sxhkd"]="$HOME/.dot/sxhkd/.config/sxhkd/sxhkdrc"
  ["autostart"]="$HOME/.dot/script/script/autostart.sh"
  ["slstatus"]="$HOME/.dot/src/src/slstatus/config.h"
  ["dwmblocks"]="$HOME/.dot/src/src/dwmblocks/config.h"
  ["dmenu_config"]="$HOME/.dot/src/src/dmenu/config.h"
  ["dmenu_patches"]="$HOME/.dot/src/src/dmenu/patches.h"
  ["dwm_config"]="$HOME/.dot/src/src/dwm/config.h"
  ["dwm_patches"]="$HOME/.dot/src/src/dwm/patches.h"
  [".dot_.gitignore"]="$HOME/.dot/.gitignore"

  # for scripts
  [":apple"]=""
)

declare -A RELOAD_COMMANDS=(

  ["fish"]="source ~/.config/fish/config.fish"
  ["sxhkd"]="pkill -USR1 -x sxhkd"
  ["slstatus"]="pkill slstatus && slstatus & disown"
  ["dwmblocks"]="pkill dwmblocks && dwmblocks & disown"
  ["dwm_config"]="pkill dwm"
  ["dwm_patches"]="pkill dwm"

  # for script
  [":apple"]="notify-send 'text apple'"
)

# Show menu and get selection
selection=$(printf "%s\n" "${!CONFIG_PATHS[@]}" | rofi -dmenu -p "Edit config:")

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
