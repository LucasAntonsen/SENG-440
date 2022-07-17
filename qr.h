#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <assert.h>

#define SIZE_T uint16_t
#define DATA_T double
#define DATA_T_KEY 'd'
#define NUM_T double
#define NUM_T_KEY 'd'
#define TOLERANCE 1e-14
#define EPSILON 1e-15
#define MAX_ITER 46340


FILE *openf(char *fname, char *mode);
void fscanm(char *fname, char *delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]);
void fprintm(char *fname, char *delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]);
void fprintmt(char *fname, char *delim, SIZE_T rows, SIZE_T cols, NUM_T A[rows][cols]);
void printm(char *delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]);
void printv(SIZE_T size, DATA_T v[size]);
char *spec_map(char type);
NUM_T l2_norm(SIZE_T size, NUM_T v[size]);
NUM_T sqr_rt(NUM_T x, NUM_T eps, NUM_T tol, size_t max_iter);
NUM_T abs_val(NUM_T x);
int closest_perfect_square(DATA_T x, size_t max_iter);
void transpose_m(SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols], DATA_T B[cols][rows]);
void numt_set_col(SIZE_T rows, SIZE_T cols, SIZE_T target_col, NUM_T v[rows], NUM_T A[rows][cols]);
void mat_set_col(SIZE_T rows, SIZE_T cols, SIZE_T target_col, DATA_T v[rows], DATA_T A[rows][cols]);
void numt_vec_copy(SIZE_T size, NUM_T src[size], NUM_T dest[size]);
void vec_copy(SIZE_T size, DATA_T src[size], NUM_T dest[size]);
NUM_T vec_dot(SIZE_T size, NUM_T v1[size], NUM_T v2[size]);
void vec_divc(SIZE_T size, NUM_T v[size], NUM_T divisor);
void vec_mulc(SIZE_T size, NUM_T v[size], NUM_T c);
void vec_mul(SIZE_T size, NUM_T src[size], NUM_T dest[size]);
void vec_sub(SIZE_T size, NUM_T v1[size], NUM_T v2[size]);
void QR(SIZE_T rows, SIZE_T cols, DATA_T At[cols][rows], NUM_T Q[rows][rows], NUM_T R[rows][cols]);
void numt_copy_col(SIZE_T rows, SIZE_T cols, SIZE_T target_col, NUM_T src[rows][cols], NUM_T dest[rows]);


void QR(SIZE_T rows, SIZE_T cols, DATA_T At[cols][rows], NUM_T Q[rows][rows], NUM_T R[rows][cols]) {
	assert(rows >= cols);
	NUM_T y[rows], q[rows];
	NUM_T y_norm;
	SIZE_T i, j;	
	
	for (j=0; j<cols; ++j) {
		vec_copy(rows, At[j], y);
		printf("y:\n");
		printv(3,y);
		printf("\n");
		
		for (i=0; i<j; ++i) {
			numt_copy_col(rows, cols, i, Q, q);
			printf("q inner loop:\n");
			printv(3,q);
			printf("\ny_norm inner loop:\n");
			//y_norm = l2_norm(rows, y);
			//printf("%lf\n\nq inner loop after div:\n", y_norm);
			//vec_divc(rows, q, y_norm);	
			//printv(3,q);
			printf("\nR inner loop dot prod:\n");
			R[i][j] = vec_dot(rows, q, y);
			printm(" ", 3, 3, R);
			printf("\nq inner loop after mulc:\n");
			vec_mulc(rows, q, R[i][j]);
			printv(3,q);
			printf("\ny after inner loop sub:\n"); 
			vec_sub(rows, q, y);
			printv(3,y);
			printf("\n");
		}
		y_norm = l2_norm(rows, y);
		printf("y_norm outer loop:\n%lf\n", y_norm);
		printf("\nR outer loop:\n");
		R[j][j] = y_norm;
		printm(" ", 3, 3, R);
		vec_divc(rows, y, y_norm);
		printf("\ny after div by y_norm outer loop:\n");
		printv(3,y);
		printf("\nQ after setting columns:\n");
		numt_set_col(rows, rows, j, y, Q);
		printm(" ", 3, 3, Q);
		printf("\n");
	}
}

NUM_T l2_norm(SIZE_T size, NUM_T v[size]) {
	NUM_T res;		
	res = vec_dot(size, v, v);
	res = sqr_rt(res, EPSILON, TOLERANCE, MAX_ITER);
	return res;
}

NUM_T sqr_rt(NUM_T x, NUM_T eps, NUM_T tol, size_t max_iter) {
	assert((int)x >= 0);
	NUM_T x0 = (NUM_T) closest_perfect_square(x, MAX_ITER);
	NUM_T xn, err;
	NUM_T f_n, f_prime;
	size_t i;
	
	for (i=0; i<max_iter; ++i) { 
		f_n = (x0 * x0) - x;
		f_prime = 2. * x0;
		
		if (abs_val(f_prime) < eps) {
			xn = 0.;
			break;
		}
		
		xn = x0 - (f_n / f_prime);
		err = abs_val(xn - x0);
		if (err <= tol) {
			break;	
		}
		x0 = xn;	
	}
	return xn;
}

int closest_perfect_square(DATA_T x, size_t max_iter) {
	int sq = 0, xn = 1;
	size_t i;
	
	for (i=0; i<max_iter; ++i) {
		sq = xn * xn;
		if (sq > (int)x) {
			break;
		}
		xn += 1;
	}
	return xn;
}

NUM_T abs_val(NUM_T x) {
	return (NUM_T) ((x < 0.) ? -x : x);
}

void numt_copy_col(SIZE_T rows, SIZE_T cols, SIZE_T target_col, NUM_T src[rows][cols], NUM_T dest[rows]) {
	SIZE_T i;
	for (i=0; i<rows; ++i) {
		dest[i] = src[i][target_col];
	}
}

void numt_set_col(SIZE_T rows, SIZE_T cols, SIZE_T target_col, NUM_T v[rows], NUM_T A[rows][cols]) {
    SIZE_T i;

    for (i=0; i<rows; ++i) {
        A[i][target_col] = (NUM_T) v[i];
    }
}

void mat_set_col(SIZE_T rows, SIZE_T cols, SIZE_T target_col, DATA_T v[rows], DATA_T A[rows][cols]) {
	SIZE_T i;

	for (i=0; i<rows; ++i) {
		A[i][target_col] = v[i];
	}
}

void vec_sub(SIZE_T size, NUM_T v1[size], NUM_T v2[size]) {
	SIZE_T i;

	for (i=0; i<size; ++i) {
		v2[i] -= v1[i];
	}
}

void numt_vec_copy(SIZE_T size, NUM_T src[size], NUM_T dest[size]) {
	SIZE_T i;

	for (i=0; i<size; ++i) {
		dest[i] = (NUM_T) src[i];
	}
}

void vec_copy(SIZE_T size, DATA_T src[size], NUM_T dest[size]) {
    SIZE_T i;

    for (i=0; i<size; ++i) {
        dest[i] = (NUM_T) src[i];
    }
}

NUM_T vec_dot(SIZE_T size, NUM_T v1[size], NUM_T v2[size]) {
	NUM_T res = 0;
	SIZE_T i;
	
	for (i=0; i<size; ++i) {
		res += (v1[i] * v2[i]);
	}
	return res;
}

void vec_mulc(SIZE_T size, NUM_T v[size], NUM_T c) {
	SIZE_T i;

	for (i=0; i<size; ++i) {
		v[i] *= c;
	}
}

void vec_mul(SIZE_T size, NUM_T src[size], NUM_T dest[size]) {
	SIZE_T i;	

	for (i=0; i<size; ++i) {
		dest[i] *= src[i]; 
	}	
}

void vec_divc(SIZE_T size, NUM_T v[size], NUM_T divisor) {
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

void fprintmt(char *fname, char *delim, SIZE_T rows, SIZE_T cols, NUM_T A[rows][cols]) {
	FILE *fptr = openf(fname, "a");
	char *spec = spec_map(NUM_T_KEY);
	SIZE_T i, j;
	
	for (i=0; i<rows; ++i) {
		for (j=0; j<cols; ++j) {
			fprintf(fptr, spec, A[i][j]);
			fprintf(fptr, delim);
		}
		fprintf(fptr, "\n");
	}
	fprintf(fptr, "\n");	
	fclose(fptr);
}

void fprintm(char *fname, char *delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]) {
	FILE *fptr = openf(fname, "a");
	char *spec = spec_map(DATA_T_KEY);
	SIZE_T i, j;
	
	for (i=0; i<rows; ++i) {
		for (j=0; j<cols; ++j) {
			fprintf(fptr, spec, A[i][j]);
			fprintf(fptr, delim);
		}
		fprintf(fptr, "\n");
	}
	fprintf(fptr, "\n");	
	fclose(fptr);
}

void printm(char *delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]) {
	char *spec = spec_map(DATA_T_KEY);
	SIZE_T i, j;	
	
	for (i=0; i<rows; ++i) {
		for (j=0; j<cols; ++j) {
			printf(spec, A[i][j]);
			printf(delim);
		}
		printf("\n");
	}	
}

void printv(SIZE_T size, DATA_T v[size]) {
	char *spec = spec_map(DATA_T_KEY);
	SIZE_T i;
	
	for (i=0; i<size; ++i) {
		printf(spec, v[i]);
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
			spec = "%.8lf";
			break;
	
		case 'f':
			spec = "%.8f";
			break;

		case 'u':
			spec = "%u";
			break;
		
		case 'i':
			spec = "%i";
			break;
	}	
	return spec;	
}
