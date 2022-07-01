#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <assert.h>

#define SIZE_T uint16_t
#define DATA_T int

FILE *openf(char *fname, char *mode);
void fscanm(char *fname, char* delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]);
SIZE_T linear(SIZE_T x, SIZE_T slope, SIZE_T intercept);
void printm(SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]);
void make_format(char *format, SIZE_T size);

int main(int argc, char *argv[]) {
	char *end;
	char *fname = argv[1];
	SIZE_T ROWS = (SIZE_T) strtoul(argv[2], &end, 10);
	SIZE_T COLS = (SIZE_T) strtoul(argv[3], &end, 10);
	
	DATA_T mat[ROWS][COLS];
	char delim[2] = " ";
	
	fscanm(fname, delim, ROWS, COLS, mat);	
	printm(ROWS, COLS, mat);
	
	return 0;
}

void fscanm(char *fname, char *delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]) {
	FILE *fptr = openf(fname, "r");	
	SIZE_T line_size = 0;
	line_size = (SIZE_T) ~(line_size & 0);
	char line[line_size]; 
	char *tok;
	char *end;
	SIZE_T i, j;	
			
	for (i=0; i<rows; ++i) {
		fgets(line, sizeof(line), fptr);
		tok = strtok(line, delim);
		for (j=0; j<cols; ++j) {
			A[i][j] = (DATA_T) strtoll(tok, &end, 10);
			tok = strtok(NULL, delim);
		}
	}	
	fclose(fptr);	
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

