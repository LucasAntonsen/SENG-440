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


//can do software pipelining here...
void QR(SIZE_T rows, SIZE_T cols, DATA_T At[cols][rows], NUM_T Q[rows][rows], NUM_T R[rows][cols]) {
	assert(rows >= cols);
	NUM_T y[rows], q[rows];
	NUM_T y_norm;
	SIZE_T i, j;	
	
	for (j=0; j<cols; ++j) {
		vec_copy(rows, At[j], y);
		
		for (i=0; i<j; ++i) {
			numt_copy_col(rows, cols, i, Q, q);
			R[i][j] = vec_dot(rows, q, y);
			vec_mulc(rows, q, R[i][j]);
			vec_sub(rows, q, y);
		}
		y_norm = l2_norm(rows, y);
		R[j][j] = y_norm;
		vec_divc(rows, y, y_norm);
		numt_set_col(rows, rows, j, y, Q);
	}
}

NUM_T l2_norm(SIZE_T size, NUM_T v[size]) {
	NUM_T res;		
	res = vec_dot(size, v, v);
	res = sqr_rt(res, EPSILON, TOLERANCE, MAX_ITER);
	return res;
}

//can do software pipelining here...
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

//can do software pipelining here...
//loop unrolling done
int closest_perfect_square(DATA_T x, size_t max_iter) {
	int sq = 0, xn = 1;
	size_t i;

	for (i=0; i<max_iter; i+=2) {
		sq = xn * xn;
		if (sq > (int)x) {
			break;
		}
		xn += 1;

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

//loop unrolling done
void numt_copy_col(SIZE_T rows, SIZE_T cols, SIZE_T target_col, NUM_T src[rows][cols], NUM_T dest[rows]) {
	SIZE_T i;
	for (i=0; i<rows; i+=2) {
		dest[i] = src[i][target_col];

		if(i+1 != rows){
			dest[i+1] = src[i+1][target_col];
		}
	}
}

//loop unrolling done
void numt_set_col(SIZE_T rows, SIZE_T cols, SIZE_T target_col, NUM_T v[rows], NUM_T A[rows][cols]) {
    SIZE_T i;

    for (i=0; i<rows; i+=2) {
        A[i][target_col] = (NUM_T) v[i];

		if(i+1 != rows){
			A[i+1][target_col] = (NUM_T) v[i+1];
		}
    }
}

//loop unrolling done
void mat_set_col(SIZE_T rows, SIZE_T cols, SIZE_T target_col, DATA_T v[rows], DATA_T A[rows][cols]) {
	SIZE_T i;

	// for (i=0; i<rows; ++i) {
	// 	A[i][target_col] = v[i];
	// }
	for(i=0; i<rows; i+=2){
		A[i][target_col] = v[i];

		if(i+1 != rows){
			A[i+1][target_col] = v[i+1];
		}
	}
}

//loop unrolling done
void vec_sub(SIZE_T size, NUM_T v1[size], NUM_T v2[size]) {
	SIZE_T i;

	// for (i=0; i<size; ++i) {
	// 	v2[i] -= v1[i];
	// }
	for(i=0; i<size; i+=2){
		v2[i] -= v1[i];

		if(i+1 != size){
			v2[i+1] -= v1[i+1];
		}
	}
}

//loop unrolling done
void numt_vec_copy(SIZE_T size, NUM_T src[size], NUM_T dest[size]) {
	SIZE_T i;

	// for (i=0; i<size; ++i) {
	// 	dest[i] = (NUM_T) src[i];
	// }
	for(i=0; i<size; i+=2){
		dest[i] = (NUM_T) src[i];

		if(i+1 != size){
			dest[i+1] = (NUM_T) src[i+1];;
		}
	}
}

//loop unrolling done
void vec_copy(SIZE_T size, DATA_T src[size], NUM_T dest[size]) {
    SIZE_T i;

    for (i=0; i<size; i+=2) {
        dest[i] = (NUM_T) src[i];

		if(i+1 != size){
			dest[i+1] = (NUM_T) src[i+1];
		}
    }
}

//loop unrolling done
NUM_T vec_dot(SIZE_T size, NUM_T v1[size], NUM_T v2[size]) {
	NUM_T res = 0;
	SIZE_T i;
	
	for (i=0; i<size; i+=2) {
		res += (v1[i] * v2[i]);

		if(i+1 != size){
			res += (v1[i+1] * v2[i+1]);
		}
	}
	return res;
}

//loop unrolling done
void vec_mulc(SIZE_T size, NUM_T v[size], NUM_T c) {
	SIZE_T i;

	for (i=0; i<size; i+=2) {
		v[i] *= c;

		if(i+1 != size){
			v[i+1] *= c;
		}
	}
}

//loop unrolling done
void vec_mul(SIZE_T size, NUM_T src[size], NUM_T dest[size]) {
	SIZE_T i;	

	for (i=0; i<size; i+=2) {
		dest[i] *= src[i];

		if(i+1 != size){
			dest[i+1] *= src[i+1];
		}
	}	
}

//loop unrolling done
void vec_divc(SIZE_T size, NUM_T v[size], NUM_T divisor) {
	assert(divisor > EPSILON);	
	SIZE_T i;

	NUM_T div = 1/divisor;	//optimization
	
	for (i=0; i<size; i+=2) {
		v[i] *= div;

		if(i+1 != size){
			v[i+1] *= div;
		}
	}	
}

//loop unrolling done
void transpose_m(SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols], DATA_T B[cols][rows]) {
	SIZE_T i, j;
	for (i=0; i<cols; ++i) {
		for (j=0; j<rows; j+=2) {
			B[i][j] = A[j][i];

			if(j+1 != rows){
				B[i][j+1] = A[j+1][i];
			}
		}
	}
}

//can do software pipelining here...
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
		for (j=0; j<cols; j+=2) {
			fprintf(fptr, spec, A[i][j]);
			fprintf(fptr, delim);

			if(j+1 != cols){
				fprintf(fptr, spec, A[i][j+1]);
				fprintf(fptr, delim);
			}
		}
		fprintf(fptr, "\n");
	}
	fprintf(fptr, "\n");	
	fclose(fptr);
}

//debugging function
void fprintm(char *fname, char *delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]) {
	FILE *fptr = openf(fname, "a");
	char *spec = spec_map(DATA_T_KEY);
	SIZE_T i, j;
	
	for (i=0; i<rows; ++i) {
		for (j=0; j<cols; j+=2) {
			fprintf(fptr, spec, A[i][j]);
			fprintf(fptr, delim);

			if(j+1 != cols){
				fprintf(fptr, spec, A[i][j+1]);
				fprintf(fptr, delim);
			}
		}
		fprintf(fptr, "\n");
	}
	fprintf(fptr, "\n");	
	fclose(fptr);
}

//debugging function
void printm(char *delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]) {
	char *spec = spec_map(DATA_T_KEY);
	SIZE_T i, j;	
	
	for (i=0; i<rows; ++i) {
		for (j=0; j<cols; j+=2) {
			printf(spec, A[i][j]);
			printf(delim);

			if(j+1 != cols){
				printf(spec, A[i][j+1]);
				printf(delim);
			}
		}
		printf("\n");
	}	
}

//debugging function
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
