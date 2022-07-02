#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <assert.h>

#define SIZE_T uint16_t
#define DATA_T float
#define DATA_T_NAME 'f'
#define TOLERANCE 1e-6
#define EPSILON 1e-8
#define MAX_ITER 500000

FILE *openf(char *fname, char *mode);
void fscanm(char *fname, char* delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]);
SIZE_T linear(SIZE_T x, SIZE_T slope, SIZE_T intercept);
void printm(SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]);
void make_format(char *format, SIZE_T size);
char *spec_map(char type);
double l2_norm(SIZE_T size, DATA_T x[size]);
double sqr_rt(DATA_T x, double eps, double tol, size_t max_iter);
double abs_val(double x);
int closest_perfect_square(double x, double tol, size_t max_iter);


int main(int argc, char *argv[]) {
	char *end;
	char *fname = argv[1];
	SIZE_T ROWS = (SIZE_T) strtoull(argv[2], &end, 10);
	SIZE_T COLS = (SIZE_T) strtoull(argv[3], &end, 10);
	
	
	DATA_T mat[ROWS][COLS];
	char delim[] = " ";
	
	fscanm(fname, delim, ROWS, COLS, mat);	
	printm(ROWS, COLS, mat);
	double norm = l2_norm(COLS, mat[0]);
	printf("norm: %lf\n", norm);	
	
	return 0;
}

double l2_norm(SIZE_T size, DATA_T vec[size]) {
	double res;	
	SIZE_T i;
	
	for (i=0; i<size; ++i) {
		res += vec[i] * vec[i];
	}
	printf("sum of squares: %lf\n", res);
	res = sqr_rt(res, EPSILON, TOLERANCE, MAX_ITER);
	return res;
}

double sqr_rt(DATA_T x, double eps, double tol, size_t max_iter) {
	double x0 = closest_perfect_square(x, tol, max_iter);
	double xn;
	double f_n, f_prime;
	size_t i;
	
	for (i=0; i<max_iter; ++i) { 
		f_n = x0 * x0;
		f_prime = 2. * x0;
		
		if (abs_val(f_prime) < eps) {
			xn = 0.;
			break;
		}
		
		xn = x0 - ((f_n - (double)x) / f_prime);
		x0 = xn;
		
		if (abs_val(xn - x0) <= tol) {
			break;	
		}
		
	}
	return xn;
}

int closest_perfect_square(double x, double tol, size_t max_iter) {
	int xn = 0, x0 = 1;
	size_t i;
	
	for (i=0; i<max_iter; ++i) {
		xn = x0 * x0;
		if (xn > (int)x) {
			break;
		}
		x0 += 1;
	}
	printf("closest perfect square: %d\n", x0);
	return x0;
}

double abs_val(double x) {
	return (unsigned) ((x < 0.)? -x : x);
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
			A[i][j] = (DATA_T) strtod(tok, &end);
			tok = strtok(NULL, delim);
		}
	}	
	fclose(fptr);	
}

void printm(SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]) {
	SIZE_T i,j;	
	for (i=0; i<rows; ++i) {
		for (j=0; j<cols; ++j) {
			printf(spec_map(DATA_T_NAME), A[i][j]);
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

char *spec_map(char type) {
	char *spec;
	switch (type) {
		case 'd':
			spec = "%lf ";
			break;
	
		case 'f':
			spec = "%f ";
			break;

		case 'u':
			spec = "%u ";
			break;
		
		case 'i':
			spec = "%i ";
			break;
	}	
	return spec;	
}

void make_format(char *format, SIZE_T size) {
	SIZE_T j;
	for (j=0; j < size-2; j=j+3) {
		format[j] = '%';
		format[j+1] = 'd';
		format[j+2] = ' ';
	}
}

