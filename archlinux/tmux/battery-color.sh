#!/bin/bash
# ~/.tmux/battery.sh - Colored battery indicator with gradient blocks

# Get battery percentage
get_battery_percentage() {
   local percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 2>/dev/null |
      grep -E "percentage|state" |
      awk '/percentage/ {print $2}' |
      sed 's/%//')

   # Fallback for systems without upower
   if [ -z "$percentage" ]; then
      percentage=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "0")
   fi

   echo $percentage
}

# Get charging status
get_charging_status() {
   local status=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 2>/dev/null |
      grep "state" | awk '{print $2}')

   # Fallback for systems without upower
   if [ -z "$status" ]; then
      status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo "Unknown")
   fi

   echo $status
}

# Main function
main() {
   local percentage=$(get_battery_percentage)
   local status=$(get_charging_status)

   # Handle case where battery info might not be available
   if [ -z "$percentage" ] || [ "$percentage" = "0" ]; then
      echo "[No Battery]"
      return 0
   fi

   # Calculate filled blocks (10 blocks total)
   local filled=$((percentage / 10))
   # Ensure at least 1 block if battery > 0%
   if [ $filled -eq 0 ] && [ $percentage -gt 0 ]; then
      filled=1
   fi
   local empty=$((10 - filled))

   # Build the visual representation with gradient colors
   local bar=""

   # Define color codes (ANSI escape sequences)
   local RED='\033[38;5;196m'
   local ORANGE='\033[38;5;208m'
   local YELLOW='\033[38;5;226m'
   local LIGHT_GREEN='\033[38;5;46m'
   local GREEN='\033[38;5;34m'
   local RESET='\033[0m'

   # Create gradient blocks with colors
   # for i in $(seq 1 10); do
   #    if [ $i -le $filled ]; then
   #       # Assign color based on position (2 blocks per color)
   #       case $(((i - 1) / 2)) in
   #       0) bar="${bar}${RED}◼${RESET}" ;;         # Blocks 1-2: Red
   #       1) bar="${bar}${ORANGE}◼${RESET}" ;;      # Blocks 3-4: Orange
   #       2) bar="${bar}${YELLOW}◼${RESET}" ;;      # Blocks 5-6: Yellow
   #       3) bar="${bar}${LIGHT_GREEN}◼${RESET}" ;; # Blocks 7-8: Light Green
   #       4) bar="${bar}${GREEN}◼${RESET}" ;;       # Blocks 9-10: Green
   #       *) bar="${bar}${GREEN}◼${RESET}" ;;
   #       esac
   #    else
   #       bar="${bar}◻"
   #    fi
   # done

   # bar="${bar}]"
   # Inside your for loop, replace the color assignment logic:
   for i in $(seq 1 10); do
      if [ $i -le $filled ]; then
         # Assign a TMUX color code based on position
         if [ $i -le 2 ]; then
            bar="${bar}#[fg=red]◼"
         elif [ $i -le 4 ]; then
            bar="${bar}#[fg=colour208]◼" # Orange (208 is a common code)
         elif [ $i -le 6 ]; then
            bar="${bar}#[fg=yellow]◼"
         elif [ $i -le 8 ]; then
            bar="${bar}#[fg=green]◼"
         else
            bar="${bar}#[fg=brightgreen]◼"
         fi
      else
         bar="${bar}◻"
      fi
   done
   # Reset color at the end
   bar="${bar}#[default]"

   # Add charging indicator if charging
   if [ "$status" = "charging" ] || [ "$status" = "CHARGING" ]; then
      bar="${bar} ⚡"
   fi

   # Add percentage
   bar="${bar} ${percentage}%"

   # For TMUX, we need to escape the colors properly
   # Using printf to ensure proper formatting
   printf "%s" "$bar |"
}

# Run main function
main
