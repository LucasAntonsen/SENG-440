#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <assert.h>


#define SIZE_T uint16_t
#define DATA_T double
#define DATA_T_KEY 'd'
#define TOLERANCE 1e-4
#define EPSILON 1e-10
#define MAX_ITER 50000


FILE *openf(char *fname, char *mode);
void fscanm(char *fname, char *delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]);
void fprintm(char *fname, char *delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]);
void printm(SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]);
void printv(SIZE_T size, DATA_T v[size]);
char *spec_map(char type);
double l2_norm(SIZE_T size, DATA_T x[size]);
double sqr_rt(DATA_T x, double eps, double tol, size_t max_iter);
double abs_val(double x);
int closest_perfect_square(double x, size_t max_iter);
void transpose_m(SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols], DATA_T B[cols][rows]);
void vec_copy(SIZE_T size, DATA_T src[size], DATA_T dest[size]);
double vec_dot(SIZE_T size, DATA_T v1[size], DATA_T v2[size]);
void vec_div(SIZE_T size, DATA_T v[size], double divisor);
void vec_mulc(SIZE_T size, DATA_T v[size], double c);
void vec_mul(SIZE_T size, DATA_T src[size], DATA_T dest[size]);
void vec_sub(SIZE_T size, DATA_T v1[size], DATA_T v2[size]);
void QR(
		SIZE_T rows, 
		SIZE_T cols, 
		DATA_T A[rows][cols], 
		DATA_T At[cols][rows], 
		DATA_T Q[rows][rows], 
		DATA_T R[rows][cols]);


int main(int argc, char *argv[]) {
	char *end;
	char delim[] = " ";	
	assert(argc == 5);
	char *fin = argv[1];
	char *fout =argv[2];
	SIZE_T ROWS = (SIZE_T) strtoull(argv[3], &end, 10);
	SIZE_T COLS = (SIZE_T) strtoull(argv[4], &end, 10);
	

	DATA_T A[ROWS][COLS];
	DATA_T At[COLS][ROWS];
	DATA_T Q[ROWS][ROWS];
	DATA_T R[ROWS][COLS];
	
	fscanm(fin, delim, ROWS, COLS, A);	
	transpose_m(ROWS, COLS, A, At);
	
	QR(ROWS, COLS, A, At, Q, R);
	
	fprintm(fout, delim, ROWS, ROWS, Q);
	fprintm(fout, delim, ROWS, COLS, R);	
	return 0;
}

void QR(
		SIZE_T rows, 
		SIZE_T cols, 
		DATA_T A[rows][cols], 
		DATA_T At[cols][rows], 
		DATA_T Q[rows][rows], 
		DATA_T R[rows][cols]) {
	
	assert(rows >= cols);
	DATA_T y[rows], q[rows];
	double y_norm;
	SIZE_T i, j;	
	
	for (j=0; j<cols; ++j) {
		vec_copy(rows, At[j], y);
		vec_copy(rows, y, q);
		y_norm = l2_norm(rows, y);	
		vec_div(rows, q, y_norm);
		
		for (i=0; i<j-1; ++i) {
			R[i][j] = vec_dot(rows, q, y);
			vec_mulc(rows, q, R[i][j]); 
			vec_sub(rows, q, y);
		}
		R[j][j] = l2_norm(rows, y);
		vec_div(rows, y, R[j][j]);
		vec_copy(rows, y, Q[j]);
	}
}

void vec_sub(SIZE_T size, DATA_T v1[size], DATA_T v2[size]) {
	SIZE_T i;
	for (i=0; i<size; ++i) {
		v2[i] -= v1[i];
	}
}

void vec_copy(SIZE_T size, DATA_T src[size], DATA_T dest[size]) {
	SIZE_T i;
	for (i=0; i<size; ++i) {
		dest[i] = src[i];
	}
}

double vec_dot(SIZE_T size, DATA_T v1[size], DATA_T v2[size]) {
	DATA_T res=0;
	SIZE_T i;
	
	for (i=0; i<size; ++i) {
		res += (v1[i] * v2[i]);
	}
	return res;
}

void vec_mulc(SIZE_T size, DATA_T v[size], double c) {
	SIZE_T i;
	for (i=0; i<size; ++i) {
		v[i] *= c;
	}
}

void vec_mul(SIZE_T size, DATA_T src[size], DATA_T dest[size]) {
	SIZE_T i;
	
	for (i=0; i<size; ++i) {
		dest[i] *= src[i]; 
	}
	
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
		f_n = (x0 * x0) - (double)x;
		f_prime = 2. * x0;
		
		if (abs_val(f_prime) < eps) {
			xn = 0.;
			break;
		}
		
		xn = x0 - (f_n / f_prime);
		
		if (abs_val(xn - x0) <= tol) {
			break;	
		}
		x0 = xn;	
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

void fprintm(char *fname, char *delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]) {
	FILE *fptr = openf(fname, "a");
	SIZE_T i, j;
	
	for (i=0; i<rows; ++i) {
		for (j=0; j<cols; ++j) {
			fprintf(fptr, spec_map(DATA_T_KEY), A[i][j]);
		}
		fprintf(fptr, "\n");
	}
	fprintf(fptr, "\n");	
	fclose(fptr);
}

void printm(SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]) {
	SIZE_T i, j;	
	for (i=0; i<rows; ++i) {
		for (j=0; j<cols; ++j) {
			printf(spec_map(DATA_T_KEY), A[i][j]);
		}
		printf("\n");
	}	
}

void printv(SIZE_T size, DATA_T v[size]) {
	SIZE_T i;
	for (i=0; i<size; ++i) {
		printf(spec_map(DATA_T_KEY), v[i]);
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
