#!/usr/bin/env bash
#
# demo-colors.sh - Demonstrate terminal color capabilities
#

set -euo pipefail

# Colors reset
RESET='\033[0m'

# Basic 16 colors
basic_colors=(
    "black" "red" "green" "yellow" "blue" "magenta" "cyan" "white"
    "bright-black" "bright-red" "bright-green" "bright-yellow"
    "bright-blue" "bright-magenta" "bright-cyan" "bright-white"
)

# ANSI color codes for basic 16 colors (0-7 normal, 8-15 bright)
ansi_codes=(30 31 32 33 34 35 36 37 90 91 92 93 94 95 96 97)

echo -en "${RESET}"
# Check for true color support
check_truecolor() {
    if [[ "${COLORTERM:-}" == "truecolor" ]] || [[ "${TERM:-}" == "xterm-kitty" ]]; then
        return 0
    fi
    return 1
}

# Section 1: Basic 16 colors
echo "Basic 16 ANSI Colors"

printf "%-16s : " "Normal"
for i in {0..7}; do
    echo -ne "\033[${ansi_codes[$i]}m  ██  \033[0m"
done
echo

printf "%-16s : " "Bright"
for i in {8..15}; do
    echo -ne "\033[${ansi_codes[$i]}m  ██  \033[0m"
done
echo
echo

# Section 2: Background colors
echo "Background Colors"

printf "%-16s : " "Normal BG"
for i in {0..7}; do
    echo -ne "\033[${ansi_codes[$i]};37m  ██  \033[0m"
done
echo

printf "%-16s : " "Bright BG"
for i in {8..15}; do
    echo -ne "\033[48;5;${i}m  ██  \033[0m"
done
echo
echo

# Section 3: Text attributes
echo "Text Attributes"

echo -e "  \033[1mBold\033[0m         : \033[1mThe quick brown fox jumps over the lazy dog\033[0m"
echo -e "  \033[2mFaint\033[0m        : \033[2mThe quick brown fox jumps over the lazy dog\033[0m"
echo -e "  \033[3mItalic\033[0m       : \033[3mThe quick brown fox jumps over the lazy dog\033[0m"
echo -e "  \033[4mUnderline\033[0m    : \033[4mThe quick brown fox jumps over the lazy dog\033[0m"
echo -e "  \033[5mBlink\033[0m        : \033[5mThe quick brown fox jumps over the lazy dog\033[0m"
echo -e "  \033[7mReverse\033[0m      : \033[7mThe quick brown fox jumps over the lazy dog\033[0m"
echo -e "  \033[9mStrike\033[0m       : \033[9mThe quick brown fox jumps over the lazy dog\033[0m"
echo

# Section 4: 256 color palette
echo "256 Color Palette"

echo "  Standard colors (0-15):"
printf "    "
for i in {0..15}; do
    printf "\033[48;5;${i}m    \033[0m"
    if (( (i + 1) % 16 == 0 )); then
        echo
    fi
done
echo

echo "  Color cube (16-231):"
for row in {0..5}; do
    printf "    "
    for col in {0..5}; do
        for depth in {0..5}; do
            color=$((16 + row * 36 + col * 6 + depth))
            printf "\033[48;5;${color}m  \033[0m"
        done
        printf " "
    done
    echo
done
echo

echo "  Grayscale (232-255):"
printf "    "
for i in {232..255}; do
    printf "\033[48;5;${i}m  \033[0m"
done
echo
echo

# Section 5: True color (if supported)
echo "True Color (24-bit)"

if check_truecolor; then
    echo "  ✓ True color support detected"
    echo
    echo "  RGB Red gradient:"
    printf "    "
    for i in {0..50}; do
        r=$((255 - i * 5))
        printf "\033[48;2;${r};0;0m  \033[0m"
    done
    echo

    echo "  RGB Green gradient:"
    printf "    "
    for i in {0..50}; do
        g=$((255 - i * 5))
        printf "\033[48;2;0;${g};0m  \033[0m"
    done
    echo

    echo "  RGB Blue gradient:"
    printf "    "
    for i in {0..50}; do
        b=$((255 - i * 5))
        printf "\033[48;2;0;0;${b}m  \033[0m"
    done
    echo

    echo "  Rainbow:"
    printf "    "
    for i in {0..100}; do
        hue=$((i * 360 / 100))
        # Simple HSV to RGB approximation
        r=$(( (255 * (360 - (hue % 60))) / 360 ))
        g=$(( (255 * (hue % 60)) / 60 ))
        b=$(( (255 * (60 - (hue % 60))) / 60 ))
        printf "\033[48;2;${r};${g};${b}m  \033[0m"
    done
    echo
else
    echo "  ✗ True color not detected"
    echo "    Set COLORTERM=truecolor to enable"
fi
echo

# Section 6: Combined styles
echo "Combined Styles"

echo -e "  \033[1;31mBold Red\033[0m"
echo -e "  \033[4;32mUnderline Green\033[0m"
echo -e "  \033[1;4;33mBold Underline Yellow\033[0m"
echo -e "  \033[7;34mReverse Blue\033[0m"
echo -e "  \033[1;7;35mBold Reverse Magenta\033[0m"
echo -e "  \033[3;9;36mItalic Strike Cyan\033[0m"
echo
echo -en "${RESET}"
