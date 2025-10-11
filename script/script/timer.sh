#!/usr/bin/env bash

# Timer and Stopwatch Script
# Usage: ./timer.sh [options]

HELP="
${BOLD}${CYAN}Timer and Stopwatch Script${FIN}
${DIM}Requires Nerd Font for optimal display${FIN}

${BOLD}USAGE:${FIN}
  ./timer.sh [MODE] [OPTIONS]

${BOLD}MODES:${FIN}
  ${ICON_TIMER} -c, --countdown [TIME]    Countdown timer (format: HH:MM:SS, MM:SS, or SS)
  ${ICON_STOPWATCH} -s, --stopwatch          Stopwatch mode
  ${ICON_QUIT} -h, --help               Show this help

${BOLD}OPTIONS:${FIN}
  ${ICON_ALARM} -a, --alarm              Enable alarm sound when countdown finishes
  ${ICON_STOP} -n, --no-clear           Don't clear screen during countdown
   -f, --figlet             Use figlet for large text display
   -q, --quiet              Quiet mode (no sound notifications)

${BOLD}CONTROLS:${FIN}
  ${ICON_PAUSE} p                        Pause/Resume
  ${ICON_QUIT} q                        Quit
  ${ICON_RESET} r                        Reset (stopwatch mode only)
  ${ICON_STOP} s                        Stop alarm

${BOLD}EXAMPLES:${FIN}
  ./timer.sh -c 05:30      ${DIM}# Countdown from 5 minutes 30 seconds${FIN}
  ./timer.sh -c 300        ${DIM}# Countdown from 300 seconds (5 minutes)${FIN}
  ./timer.sh -s            ${DIM}# Start stopwatch${FIN}
  ./timer.sh -c 01:30:00 -a -f  ${DIM}# Countdown 1.5 hours with alarm and figlet${FIN}

${BOLD}NOTE:${FIN} ${DIM}Install a Nerd Font (https://nerdfonts.com) for best visual experience${FIN}
"

# Default values
MODE=""
TIME_INPUT=""
USE_FIGLET=false
CLEAR_SCREEN=true
ENABLE_ALARM=false
QUIET_MODE=false

# Colors
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
BLUE="\033[0;34m"
MAGENTA="\033[0;35m"
WHITE="\033[0;37m"
BOLD="\033[1m"
DIM="\033[2m"
FIN="\033[0m"

# Nerd Font Icons
ICON_TIMER=""     # Timer icon
ICON_STOPWATCH="" # Stopwatch icon
ICON_ALARM=""     # Alarm clock icon
ICON_PAUSE=""     # Pause icon
ICON_PLAY=""      # Play icon
ICON_STOP=""      # Stop icon
ICON_RESET=""     # Reset icon
ICON_QUIT=""      # Quit icon
ICON_TIME=""      # Clock icon
ICON_WARNING=""   # Warning icon
ICON_SUCCESS=""   # Success icon
ICON_ROCKET=""    # Rocket icon
ICON_FIRE=""      # Fire icon
ICON_HOURGLASS="" # Hourglass icon

# Global variables for pause functionality
PAUSED=false
PAUSE_START=0
TOTAL_PAUSE=0

# Signal handling
trap 'cleanup_and_exit' INT TERM
trap 'handle_resize' WINCH

cleanup_and_exit() {
  tput cnorm # Show cursor
  stty echo  # Enable echo
  tput clear
  echo -e "\n${GREEN}${ICON_SUCCESS} Timer stopped. Goodbye!${FIN}"
  exit 0
}

handle_resize() {
  # Handle terminal resize
  if $CLEAR_SCREEN; then
    clear
  fi
}

# Parse time input and convert to seconds
parse_time() {
  local input="$1"
  local hours=0
  local minutes=0
  local seconds=0

  # Check if input contains colons
  if [[ "$input" =~ ^[0-9]+$ ]]; then
    # Just seconds
    seconds=$input
  elif [[ "$input" =~ ^[0-9]+:[0-9]+$ ]]; then
    # MM:SS format
    IFS=':' read -r minutes seconds <<<"$input"
  elif [[ "$input" =~ ^[0-9]+:[0-9]+:[0-9]+$ ]]; then
    # HH:MM:SS format
    IFS=':' read -r hours minutes seconds <<<"$input"
  else
    echo -e "${RED}${ICON_WARNING} Error: Invalid time format. Use HH:MM:SS, MM:SS, or SS${FIN}"
    exit 1
  fi

  # Validate ranges
  if ((seconds >= 60 || minutes >= 60 || hours > 23)); then
    echo -e "${RED}${ICON_WARNING} Error: Invalid time values (seconds/minutes < 60, hours <= 23)${FIN}"
    exit 1
  fi

  echo $((hours * 3600 + minutes * 60 + seconds))
}

# Format seconds to HH:MM:SS
format_time() {
  local total_seconds=$1
  local hours=$((total_seconds / 3600))
  local minutes=$(((total_seconds % 3600) / 60))
  local seconds=$((total_seconds % 60))

  printf "%02d:%02d:%02d" $hours $minutes $seconds
}

# Play notification sound
play_notification() {
  if $QUIET_MODE; then
    return
  fi

  # Try different ways to make sound
  if command -v paplay &>/dev/null; then
    paplay /opt/sound/alarm.wav
    echo -e "\a"
  elif command -v speaker-test &>/dev/null; then
    timeout 0.5 speaker-test -t sine -f 800 -l 1 &>/dev/null
  elif command -v beep &>/dev/null; then
    beep -f 800 -l 500 2>/dev/null
  else
    # Fallback to terminal bell
    echo -e "\a"
  fi
}

# Display time with optional figlet
display_time() {
  local time_str="$1"
  local label="$2"
  local color="$3"
  local icon="$4"

  if $CLEAR_SCREEN; then
    clear
  fi

  if $USE_FIGLET && command -v figlet &>/dev/null; then
    echo -e "${color}${BOLD}${icon} $label${FIN}"
    echo
    echo "$time_str" | figlet -c -w $(tput cols)
    echo
  else
    # Center the display
    local cols=$(tput cols)
    local full_label="${icon} $label"
    local label_len=${#full_label}
    local time_len=${#time_str}
    local padding=$(((cols - time_len) / 2))
    local label_padding=$(((cols - label_len + 2) / 2)) # +2 for icon spacing

    printf "%*s\n" $((label_padding + label_len)) "$full_label"
    echo
    printf "${color}${BOLD}%*s${FIN}\n" $((padding + time_len)) "$time_str"
    echo
  fi

  # Show controls with icons
  echo -e "${CYAN}${ICON_TIME} Controls:${FIN}"
  echo -e "  ${WHITE}${ICON_PAUSE} [p]${FIN} Pause/Resume"
  echo -e "  ${WHITE}${ICON_QUIT} [q]${FIN} Quit"
  if [[ "$MODE" == "stopwatch" ]]; then
    echo -e "  ${WHITE}${ICON_RESET} [r]${FIN} Reset"
  fi

  if $PAUSED; then
    echo -e "\n${YELLOW}${ICON_PAUSE} PAUSED ${DIM}- Press 'p' to resume${FIN}"
  fi
}

# Handle user input
handle_input() {
  read -t 0.1 -n 1 -s key 2>/dev/null
  case "$key" in
  'q' | 'Q')
    cleanup_and_exit
    ;;
  'p' | 'P')
    if $PAUSED; then
      # Resume
      PAUSED=false
      local pause_duration=$(($(date +%s) - PAUSE_START))
      TOTAL_PAUSE=$((TOTAL_PAUSE + pause_duration))
    else
      # Pause
      PAUSED=true
      PAUSE_START=$(date +%s)
    fi
    ;;
  'r' | 'R')
    if [[ "$MODE" == "stopwatch" ]]; then
      return 1 # Signal to reset
    fi
    ;;
  's' | 'S')
    return 2 # Signal to stop alarm
    ;;
  esac
  return 0
}

# Countdown timer function
countdown_timer() {
  local total_seconds=$(parse_time "$TIME_INPUT")
  local start_time=$(date +%s)

  echo -e "${GREEN}${ICON_ROCKET} Starting countdown: $(format_time $total_seconds)${FIN}"
  sleep 1

  tput civis # Hide cursor
  stty -echo # Disable echo

  while ((total_seconds > 0)); do
    local current_time=$(date +%s)
    local elapsed=$((current_time - start_time - TOTAL_PAUSE))

    if ! $PAUSED; then
      total_seconds=$(($(parse_time "$TIME_INPUT") - elapsed))
    fi

    if ((total_seconds <= 0)); then
      break
    fi

    # Color coding and icon selection based on remaining time
    local color="$WHITE"
    local icon="$ICON_TIMER"
    if ((total_seconds <= 10)); then
      color="$RED"
      icon="$ICON_FIRE"
    elif ((total_seconds <= 60)); then
      color="$RED"
      icon="$ICON_WARNING"
    elif ((total_seconds <= 300)); then
      color="$YELLOW"
      icon="$ICON_HOURGLASS"
    fi

    display_time "$(format_time $total_seconds)" "COUNTDOWN TIMER" "$color" "$icon"

    handle_input

    if ! $PAUSED; then
      sleep 1
    else
      sleep 0.1
    fi
  done

  # Timer finished
  display_time "00:00:00" "TIME'S UP!" "$RED" "$ICON_ALARM"
  echo -e "\n${GREEN}${BOLD}${ICON_SUCCESS} COUNTDOWN FINISHED! ${ICON_SUCCESS}${FIN}"

  if $ENABLE_ALARM; then
    echo -e "${YELLOW}${ICON_STOP} Press 's' to stop alarm${FIN}"
    while true; do
      play_notification
      read -t 1 -n 1 -s key
      if [[ "$key" == "s" || "$key" == "S" ]]; then
        break
      fi
    done
  else
    play_notification
    echo -e "${CYAN}${ICON_QUIT} Press any key to exit...${FIN}"
    read -n 1 -s
  fi
}

# Stopwatch function
stopwatch_timer() {
  local start_time=$(date +%s)
  local elapsed=0

  echo -e "${GREEN}${ICON_PLAY} Starting stopwatch...${FIN}"
  sleep 1

  tput civis # Hide cursor
  stty -echo # Disable echo

  while true; do
    local current_time=$(date +%s)

    if ! $PAUSED; then
      elapsed=$((current_time - start_time - TOTAL_PAUSE))
    fi

    # Color changes based on elapsed time for visual interest
    local color="$GREEN"
    local icon="$ICON_STOPWATCH"
    if ((elapsed > 3600)); then
      # Over an hour - use blue
      color="$BLUE"
      icon="$ICON_TIME"
    elif ((elapsed > 1800)); then
      # Over 30 minutes - use magenta
      color="$MAGENTA"
    elif ((elapsed > 300)); then
      # Over 5 minutes - use cyan
      color="$CYAN"
    fi

    display_time "$(format_time $elapsed)" "STOPWATCH" "$color" "$icon"

    handle_input
    local input_result=$?

    if ((input_result == 1)); then
      # Reset requested
      start_time=$(date +%s)
      TOTAL_PAUSE=0
      elapsed=0
      echo -e "\n${YELLOW}${ICON_RESET} Stopwatch reset!${FIN}"
      sleep 1
    fi

    if ! $PAUSED; then
      sleep 1
    else
      sleep 0.1
    fi
  done
}

# Main function
main() {
  # Check dependencies
  if $USE_FIGLET && ! command -v figlet &>/dev/null; then
    echo -e "${YELLOW}${ICON_WARNING} Warning: figlet not found. Falling back to normal display.${FIN}"
    USE_FIGLET=false
  fi

  case "$MODE" in
  "countdown")
    if [[ -z "$TIME_INPUT" ]]; then
      echo -e "${RED}${ICON_WARNING} Error: Countdown time required${FIN}"
      echo "Example: ./timer.sh -c 05:30"
      exit 1
    fi
    countdown_timer
    ;;
  "stopwatch")
    stopwatch_timer
    ;;
  *)
    echo -e "$HELP"
    exit 1
    ;;
  esac

  cleanup_and_exit
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
  -c | --countdown)
    MODE="countdown"
    if [[ -n "$2" && ! "$2" =~ ^- ]]; then
      TIME_INPUT="$2"
      shift 2
    else
      echo -e "${RED}${ICON_WARNING} Error: Countdown time required${FIN}"
      exit 1
    fi
    ;;
  -s | --stopwatch)
    MODE="stopwatch"
    shift
    ;;
  -a | --alarm)
    ENABLE_ALARM=true
    shift
    ;;
  -n | --no-clear)
    CLEAR_SCREEN=false
    shift
    ;;
  -f | --figlet)
    USE_FIGLET=true
    shift
    ;;
  -q | --quiet)
    QUIET_MODE=true
    shift
    ;;
  -h | --help)
    echo -e "$HELP"
    exit 0
    ;;
  *)
    echo -e "${RED}${ICON_WARNING} Unknown option: $1${FIN}"
    echo "Use -h or --help for usage information"
    exit 1
    ;;
  esac
done

# Run main function
main
