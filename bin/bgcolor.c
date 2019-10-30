#include <stdio.h>
#include <stdint.h>

uint32_t HsvToRgb(uint8_t h, uint8_t s, uint8_t v) {
	uint8_t r, g, b;
	uint8_t region, remainder, p, q, t;

	if (s == 0) {
		r = v;
		g = v;
		b = v;
		return r*0x10000 + g*0x100 + b;
	}

	region = h / 43;
	remainder = (h - (region * 43)) * 6;

	p = (v * (255 - s)) >> 8;
	q = (v * (255 - ((s * remainder) >> 8))) >> 8;
	t = (v * (255 - ((s * (255 - remainder)) >> 8))) >> 8;

	switch (region) {
	case 0:
		r = v; g = t; b = p;
		break;
	case 1:
		r = q; g = v; b = p;
		break;
	case 2:
		r = p; g = v; b = t;
		break;
	case 3:
		r = p; g = q; b = v;
		break;
	case 4:
		r = t; g = p; b = v;
		break;
	default:
		r = v; g = p; b = q;
		break;
	}

	return (r<<16) + (g<<8) + b;
}

void RgbToStr(uint32_t rgb, char rgbs[], int len) {
	int b = (rgb & 0x0000FF);
	int g = (rgb & 0x00FF00)>>8;
	int r = (rgb & 0xFF0000)>>16;

	snprintf(rgbs, len, "rgb:%02x/%02x/%02x", r, g, b);
}

int main(void) {
	FILE* f = fopen("/dev/urandom", "r");
	const uint8_t bright_range = 0x20;  // range for brightness
	const uint8_t bright_min = 0x20;
	uint8_t h, s, v;
	char buf[14];
	fread(&h, 1, 1, f);
	fread(&s, 1, 1, f);
	fread(&v, 1, 1, f); v %= bright_range; v += bright_min;
	fclose(f);
	RgbToStr(HsvToRgb(h, s, v), buf, sizeof(buf));
	printf("%s", buf);
	return 0;
}
