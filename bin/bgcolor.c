#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/random.h>
#include <unistd.h>

struct rgb {
	uint8_t r, g, b;
};

static struct rgb hsv_to_rgb(uint8_t h, uint8_t s, uint8_t v)
{
	if (s == 0)
		return (struct rgb){v, v, v};

	uint8_t region = h / 43;
	uint8_t remainder = (h - region * 43) * 6;
	uint8_t p = (v * (255 - s)) >> 8;
	uint8_t q = (v * (255 - ((s * remainder) >> 8))) >> 8;
	uint8_t t = (v * (255 - ((s * (255 - remainder)) >> 8))) >> 8;

	switch (region) {
	case 0:
		return (struct rgb){v, t, p};
	case 1:
		return (struct rgb){q, v, p};
	case 2:
		return (struct rgb){p, v, t};
	case 3:
		return (struct rgb){p, q, v};
	case 4:
		return (struct rgb){t, p, v};
	default:
		return (struct rgb){v, p, q};
	}
}

static bool env_is(const char *name, const char *value)
{
	const char *s = getenv(name);
	return s && strcmp(s, value) == 0;
}

static bool supports_osc11(void)
{
	return (env_is("COLORTERM", "truecolor") ||
		env_is("COLORTERM", "24bit")) &&
	       !env_is("TERM_PROGRAM", "vscode");
}

int main(int argc, char *const argv[])
{
	bool verbose = false;
	bool force = false;
	int opt;

	while ((opt = getopt(argc, argv, "vf")) != -1) {
		switch (opt) {
		case 'v':
			verbose = true;
			break;
		case 'f':
			force = true;
			break;
		default:
			return 1;
		}
	}

	const uint8_t bright_min = 0x20;
	const uint8_t bright_range = 0x20; // range for brightness
	uint8_t hsv[3] = {0};
	if (getrandom(hsv, sizeof(hsv), GRND_NONBLOCK) != sizeof(hsv))
		return 1;

	struct rgb c =
		hsv_to_rgb(hsv[0], hsv[1], bright_min + hsv[2] % bright_range);

	if (force || supports_osc11())
		printf("\x1b]11;#%02x%02x%02x\x1b\\", c.r, c.g, c.b);

	// for terminals that don't support ANSI code to set background
	// (e.g. urxvt -bg), no trailing newline: callers that splice the
	// output into a command line don't all strip it
	if (verbose)
		printf("rgb:%02x/%02x/%02x", c.r, c.g, c.b);

	return 0;
}
