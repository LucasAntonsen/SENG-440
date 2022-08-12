#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>


#define FX_T int32_t
#define UFX_T uint32_t
#define FX_SIZE_T uint8_t
#define FX_SIZE (uint8_t)32
#define FX_FRACT_BITS (uint8_t)15
#define FX_WHOLE_BITS (uint8_t)16

#define FX_MAX_BIN_CHARS FX_SIZE+2 
#define FX_MAX_DEC_CHARS 12*2 
#define FX_SIGN 0x80000000
#define FX_WHOLE 0x7FFF8000
#define FX_FRACT 0x7FFF



void bin_fx_to_str(char *s, UFX_T x);
void fx_to_str(char *s, UFX_T x, FX_SIZE_T scale);
UFX_T str_to_fx(char *s, char *delim, FX_SIZE_T scale);
inline UFX_T fract_dec_to_bin(UFX_T x, UFX_T threshold);
inline UFX_T get_threshold(char *s, FX_SIZE_T digits);
inline FX_SIZE_T dlen(UFX_T x);
inline FX_SIZE_T blen(UFX_T x);
inline void printb(UFX_T x);



UFX_T str_to_fx(char *s, char *delim, FX_SIZE_T scale) {
	FX_SIZE_T sign = 0;
	FX_T num = 0;
	FX_SIZE_T digits = 0;
	UFX_T threshold = 0;
	
	char *p;
	char *tok = strtok(s, delim);	
	num = (FX_T) strtol(tok, &p, 10);	
	if (num < 0) {
		sign = 1;
		num -= 1;
		num = ~num;	
	}
	num = ((UFX_T) num << scale);

	tok = strtok(NULL, delim);
	if (tok != NULL) {
		digits = strnlen(tok, FX_MAX_DEC_CHARS); 
		threshold = get_threshold(tok, digits);
		num |= fract_dec_to_bin((UFX_T) strtoul(tok, &p, 10), threshold);
	}
	return (sign) ? FX_SIGN | num : num;
}

void bin_fx_to_str(char *s, UFX_T x) {
	FX_SIZE_T max_chars = FX_MAX_BIN_CHARS - 1;		
	UFX_T stack = 0;
	FX_SIZE_T i = 0;

	for (; i < FX_SIZE; ++i) {
		stack <<= 1;	
		stack |= (x & 1);
		x >>= 1;
	}

	i = 0;

	if (stack & 1) {
		s[0] = '-';	
		i = 1;
		++max_chars;
	}

	s[FX_WHOLE_BITS + i + 1] = '.';
	
	for (; i < max_chars; ++i) {
		if ('.' == s[i]) continue; 
		s[i] = '0' + (stack & 1);
		stack >>= 1;
	}		
	s[FX_MAX_BIN_CHARS] = '\0';	
}

void fx_to_str(char *s, UFX_T x, FX_SIZE_T scale) {
	UFX_T num = (x & FX_WHOLE) >> scale;

	((x & FX_SIGN) > 0) ? sprintf(s, "-%u", num) : sprintf(s, "%u", num);
		
	num = x & FX_FRACT;
	num >>= (scale - blen(num));
	if (num > 0) {
		sprintf(s + dlen(num) + 1, ".%u", num);
	}
}

inline UFX_T fract_dec_to_bin(UFX_T x, UFX_T threshold) {
	UFX_T fract_bin = 0;
	FX_SIZE_T i = 0;
		
	for (; i < FX_FRACT_BITS; ++i) {
		fract_bin <<= 1;	
		if ((x <<= 1) > threshold) {
			fract_bin |= 1;
			x -= threshold;
		}
	}
	return fract_bin;
}

inline UFX_T get_threshold(char *s, FX_SIZE_T digits) {
	UFX_T threshold = 10;
	FX_SIZE_T i = 1;
	for (; i < digits; ++i) {
		threshold *= 10;
	}
	return threshold;	
}

inline FX_SIZE_T blen(UFX_T x) {
	FX_SIZE_T bits = 0;
	for (; x > 0; x >>= 1) {
		++bits;
	}
	return bits;
}

inline FX_SIZE_T dlen(UFX_T x) {
	FX_SIZE_T digits = 0; 
	for (; x > 0; x /= 10) {
		++digits;
	}
	return digits;
}

inline void printb(UFX_T x) {
	UFX_T stack = 0;
	FX_SIZE_T bits = blen(x);
	FX_SIZE_T count = 0;
	for (; count < bits; ++count) {
		stack <<= 1;	
		stack |= (x & 1);
		x >>= 1;
	}
	for (count = 0; count < bits; ++count) {
		printf("%u", stack & 1);
		stack >>= 1;
	}
	printf("\n");	
}