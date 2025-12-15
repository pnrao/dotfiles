#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/random.h>
#include <unistd.h>

uint32_t HsvToRgb(uint8_t h, uint8_t s, uint8_t v) {
	uint8_t r, g, b;
	uint8_t region, remainder, p, q, t;

	if (s == 0) {
		r = v;
		g = v;
		b = v;
		return r * 0x10000 + g * 0x100 + b;
	}

	region = h / 43;
	remainder = (h - (region * 43)) * 6;

	p = (v * (255 - s)) >> 8;
	q = (v * (255 - ((s * remainder) >> 8))) >> 8;
	t = (v * (255 - ((s * (255 - remainder)) >> 8))) >> 8;

	switch (region) {
	case 0:
		r = v;
		g = t;
		b = p;
		break;
	case 1:
		r = q;
		g = v;
		b = p;
		break;
	case 2:
		r = p;
		g = v;
		b = t;
		break;
	case 3:
		r = p;
		g = q;
		b = v;
		break;
	case 4:
		r = t;
		g = p;
		b = v;
		break;
	default:
		r = v;
		g = p;
		b = q;
		break;
	}

	return (r << 16) + (g << 8) + b;
}

void RgbToStr(uint32_t rgb, char rgbs[], int len) {
	int b = (rgb & 0x0000FF);
	int g = (rgb & 0x00FF00) >> 8;
	int r = (rgb & 0xFF0000) >> 16;

	snprintf(rgbs, len, "rgb:%02x/%02x/%02x", r, g, b);
}

int main(int argc, char *const argv[]) {
	bool verbose = false;
	bool force = false;
	int opt;

	const uint8_t bright_range = 0x20; // range for brightness
	const uint8_t bright_min = 0x20;
	uint8_t hsv[3];
	ssize_t err __attribute__((unused)) =
	    getrandom(hsv, sizeof(hsv), GRND_NONBLOCK);

	hsv[2] %= bright_range;
	hsv[2] += bright_min;
	uint32_t rgb = HsvToRgb(hsv[0], hsv[1], hsv[2]);

	while ((opt = getopt(argc, argv, "vf")) != -1) {
		switch (opt) {
		case 'v':
			verbose = true;
			break;
		case 'f':
			force = true;
			break;
		}
	}

	const char *term = getenv("COLORTERM");
	const char *term_prog = getenv("TERM_PROGRAM");
	if (force ||
	    (term && (strcmp(term, "truecolor") == 0 || strcmp(term, "24bit")) &&
	     (term_prog == NULL || strcmp(term_prog, "vscode") != 0))) {
		printf("\x1b]11;#%06x\x1b\\", rgb);
	}

	if (verbose) {
		// for terminals that don't support ANSI code to set background
		char buf[14];
		RgbToStr(rgb, buf, sizeof(buf));
		printf("%s", buf);
	}
	return 0;
}
