#!/usr/bin/env python3
import sys
import math

def print_color(r, g, b, text=" "):
    """Prints text with the specified RGB background color."""
    sys.stdout.write(f"\x1b[48;2;{r};{g};{b}m{text}\x1b[0m")

def test_truecolor():
    """Displays various gradients to test 24-bit color support."""
    
    # Get terminal width, default to 80
    try:
        import shutil
        width = shutil.get_terminal_size((80, 20)).columns
    except ImportError:
        width = 80

    print("\n--- Truecolor (24-bit) Gradient Test ---\n")

    # 1. Rainbow Gradient
    print("1. Rainbow Gradient:")
    for i in range(width):
        r = int(math.sin(0.1 * i + 0) * 127 + 128)
        g = int(math.sin(0.1 * i + 2) * 127 + 128)
        b = int(math.sin(0.1 * i + 4) * 127 + 128)
        print_color(r, g, b)
    print("\n")

    # 2. Red-Green-Blue Gradients
    print("2. Red, Green, Blue Components:")
    for i in range(width):
        val = int(255 * (i / width))
        print_color(val, 0, 0)
    print()
    for i in range(width):
        val = int(255 * (i / width))
        print_color(0, val, 0)
    print()
    for i in range(width):
        val = int(255 * (i / width))
        print_color(0, 0, val)
    print("\n")

    # 3. Grayscale
    print("3. Grayscale:")
    for i in range(width):
        val = int(255 * (i / width))
        print_color(val, val, val)
    print("\n")

    print("If you see smooth transitions, Truecolor is working.")
    print("If you see blocks of the same color or weird symbols, it might not be supported.\n")

if __name__ == "__main__":
    test_truecolor()
