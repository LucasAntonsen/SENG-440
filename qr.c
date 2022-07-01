#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <assert.h>

#define SIZE_T uint16_t
#define DATA_T int

FILE *openf(char *fname, char *mode);
SIZE_T linear(SIZE_T x, SIZE_T slope, SIZE_T intercept);
void printm(SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]);
void make_format(char *format, SIZE_T size);

int main(int argc, char *argv[]) {
	char *fname = argv[1];
	SIZE_T ROWS = atoi(argv[2]);
	SIZE_T COLS = atoi(argv[3]);
	
	DATA_T mat[ROWS][COLS];
	SIZE_T line_size = linear(COLS, 2, 1);
	char line[line_size];
	char delim[2] = " ";
	char *tok;
	
	SIZE_T i, j;	
	FILE *fptr = openf(fname, "r");	
	
	for (i=0; i<ROWS; ++i) {
		fgets(line, line_size, fptr);
		tok = strtok(line, delim);
		for (j=0; j<COLS; ++j) {
			mat[i][j] = (DATA_T) atoi(tok);
			tok = strtok(NULL, delim);
		}
	}	
	fclose(fptr);
	
	printm(ROWS, COLS, mat);
	
	return 0;
}

void printm(SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]) {
	SIZE_T i,j;	
	for (i=0; i<rows; ++i) {
		for (j=0; j<cols; ++j) {
			printf("%d ", A[i][j]);
		}
		printf("\n");
	}	
}

FILE *openf(char *fname, char *mode) {
	FILE *fptr = fopen(fname, mode);	
	
	if (fptr == NULL) {
		printf("cannot open matrix file\n");
		exit(0);
	}	
	return fptr;
}

SIZE_T linear(SIZE_T x, SIZE_T slope, SIZE_T intercept) {
	return (x * slope) + intercept;
}

void make_format(char *format, SIZE_T size) {
	SIZE_T j;
	for (j=0; j < size-2; j=j+3) {
		format[j] = '%';
		format[j+1] = 'd';
		format[j+2] = ' ';
	}
}

