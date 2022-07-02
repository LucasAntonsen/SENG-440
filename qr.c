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
#define MAX_ITER 50000


FILE *openf(char *fname, char *mode);
void fscanm(char *fname, char* delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]);
void printm(SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]);
char *spec_map(char type);
double l2_norm(SIZE_T size, DATA_T x[size]);
double sqr_rt(DATA_T x, double eps, double tol, size_t max_iter);
double abs_val(double x);
int closest_perfect_square(double x, size_t max_iter);
void transpose_m(SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols], DATA_T B[cols][rows]);
void vec_div(SIZE_T size, DATA_T v[size], double divisor);


int main(int argc, char *argv[]) {
	char *end;
	char *fname = argv[1];
	SIZE_T ROWS = (SIZE_T) strtoull(argv[2], &end, 10);
	SIZE_T COLS = (SIZE_T) strtoull(argv[3], &end, 10);
	
	DATA_T M[ROWS][COLS];
	DATA_T Mt[COLS][ROWS];
	char delim[] = " ";
	
	fscanm(fname, delim, ROWS, COLS, M);	
	transpose_m(ROWS, COLS, M, Mt);
	printf("M:\n");
	printm(ROWS, COLS, M);
	vec_div(COLS, M[0], 2);	
	printf("\nM:\n");
	printm(ROWS, COLS, M);
	return 0;
}

void QR(
		SIZE_T rows, 
		SIZE_T cols, 
		DATA_T A[rows][cols], 
		DATA_T At[cols][rows], 
		DATA_T Q[rows][rows], 
		DATA_T R[rows][cols]) {
	return;	
}

void vec_div(SIZE_T size, DATA_T v[size], double divisor) {
	assert(divisor > EPSILON);	
	SIZE_T i;
	
	for (i=0; i<size; ++i) {
		v[i] /= divisor;
	}
	
}

void transpose_m(SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols], DATA_T B[cols][rows]) {
	SIZE_T i, j;
	for (i=0; i<cols; ++i) {
		for (j=0; j<rows; ++j) {
			B[i][j] = A[j][i];
		}
	}
}

double l2_norm(SIZE_T size, DATA_T vec[size]) {
	double res;	
	SIZE_T i;
	
	for (i=0; i<size; ++i) {
		res += vec[i] * vec[i];
	}
	res = sqr_rt(res, EPSILON, TOLERANCE, MAX_ITER);
	return res;
}

double sqr_rt(DATA_T x, double eps, double tol, size_t max_iter) {
	double x0 = closest_perfect_square(x, MAX_ITER);
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

int closest_perfect_square(double x, size_t max_iter) {
	int xn = 0, x0 = 1;
	size_t i;
	
	for (i=0; i<max_iter; ++i) {
		xn = x0 * x0;
		if (xn > (int)x) {
			break;
		}
		x0 += 1;
	}
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
		fprintf(stderr, "FileError: cannot open %s\n", fname);
		exit(0);
	}	
	return fptr;
}

char *spec_map(char type) {
	char *spec;
	switch (type) {
		case 'd':
			spec = "%.4lf ";
			break;
	
		case 'f':
			spec = "%.4f ";
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

