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



void bin_fx_to_str(char *s, UFX_T x, FX_SIZE_T scale);
void fx_to_str(char *s, UFX_T x, FX_SIZE_T scale);
UFX_T str_to_fx(char *s, char *delim, FX_SIZE_T scale);
UFX_T fract_dec_to_bin(UFX_T x, FX_SIZE_T zeros);
UFX_T get_threshold(UFX_T x, FX_SIZE_T offset);
FX_SIZE_T leading_zeros(char *s);
FX_SIZE_T dlen(UFX_T x);
FX_SIZE_T blen(UFX_T x);
void printb(UFX_T x);
char bmap(FX_T x);
void reorder(FX_T *x);



int main() {
	char delim[FX_MAX_DEC_CHARS] = ".";
	char output[FX_MAX_BIN_CHARS];
	char input[FX_MAX_DEC_CHARS] = "-1086.0004";
	printf("input = %s\n", input);


	UFX_T num = str_to_fx(input, delim, FX_FRACT_BITS);
	printf("fx num bin = ");
	printb(num);
	bin_fx_to_str(output, num, FX_FRACT_BITS);

	printf("output = %s\n", output);
	return 0;
}

UFX_T str_to_fx(char *s, char *delim, FX_SIZE_T scale) {
	FX_SIZE_T sign = 0;
	FX_T whole = 0;
	UFX_T fract = 0;
	FX_SIZE_T offset = 0;
	FX_SIZE_T zeros = 0;
	
	char *p;
	char *tok = strtok(s, delim);	
	whole = (FX_T) strtol(tok, &p, 10);	
	if (whole < 0) {
		sign = 1;
		whole -= 1;
		whole = ~whole;	
	}

	tok = strtok(NULL, delim);
	if (tok != NULL) { 
		zeros = leading_zeros(tok);
		fract = (UFX_T) strtoul(tok, &p, 10);
		fract = fract_dec_to_bin(fract, zeros);
		offset = scale - blen(fract);
	}
	return (sign) ? FX_SIGN | (whole << scale) | (fract << offset) :
					(whole << scale) | (fract << offset);
}

FX_SIZE_T leading_zeros(char *s) {
	FX_SIZE_T zeros = 0;
	for (; s[zeros] == '0' && zeros < FX_SIZE; ++zeros);
	return zeros;
}

void bin_fx_to_str(char *s, UFX_T x, FX_SIZE_T scale) {
	UFX_T stack = 0;
	FX_SIZE_T i = 0;
	FX_SIZE_T max_chars = FX_MAX_BIN_CHARS - 1;	

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
		if (s[i] == '.') continue; 
		s[i] = '0' + (stack & 1);
		stack >>= 1;
	}		
	
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

UFX_T fract_dec_to_bin(UFX_T x, FX_SIZE_T zeros) {
	UFX_T threshold = get_threshold(x, zeros);	
	UFX_T fract_bin = 0;
	FX_SIZE_T i = 0;
		
	for (; i < FX_FRACT_BITS; ++i) {
		if ((x <<= 1) > threshold) {
			fract_bin |= 1;
			x -= threshold;
		}
		fract_bin <<= 1;
	}
	return fract_bin;
}

UFX_T get_threshold(UFX_T x, FX_SIZE_T leading_zeros) {
	FX_SIZE_T digits = dlen(x) + leading_zeros;
	UFX_T threshold = 10;
	FX_SIZE_T i = 1;
	for (; i < digits; ++i) {
		threshold *= 10;
	}
	//printf("leading zeros = %u\n", leading_zeros);
	//printf("x = %u\n", x);
	//printf("digits = %u\n", digits);	
	//printf("threshold = %u\n", threshold);
	return threshold;	
}

FX_SIZE_T blen(UFX_T x) {
	FX_SIZE_T bits = 0;
	for (; x > 0; x >>= 1) {
		++bits;
	}
	return bits;
}

FX_SIZE_T dlen(UFX_T x) {
	FX_SIZE_T digits = 0; 
	for (; x > 0; x /= 10) {
		++digits;
	}
	return digits;
}

void printb(UFX_T x) {
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

