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

#define compute_f_n(x_0,x_) (x_0)*(x_0) - x_
#define compute_xn(x_0,fn,fprime) x_0 - (fn / fprime)
#define compute_l(end,start) end - start


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
void transpose_m(SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols], DATA_T B[cols][rows], SIZE_T start_i, SIZE_T end_i, SIZE_T start_j, SIZE_T end_j);
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
void zero_m(SIZE_T rows, SIZE_T cols, DATA_T M[rows][cols]);


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

//optimized for loop
NUM_T sqr_rt(NUM_T x, NUM_T eps, NUM_T tol, size_t max_iter) {
	assert((int)x >= 0);
	NUM_T x0 = (NUM_T) closest_perfect_square(x, MAX_ITER);
	NUM_T xn, err;
	NUM_T f_n, f_prime;
	size_t i;

	for (i=max_iter; i != 0; --i) { 
		f_n = compute_f_n(x0, x); //macro
		f_prime = 2. * x0;
		
		if (abs_val(f_prime) < eps) {
			xn = 0.;
			break;
		}
		
		xn = compute_xn(x0, f_n, f_prime); //macro
		err = abs_val(xn - x0);
		if (err <= tol) {
			break;	
		}
		x0 = xn;	
	}
	return xn;
}

//loop unrolling done
//optimized for loop
int closest_perfect_square(DATA_T x, size_t max_iter) {
	int sq = 0, xn = 1;
	size_t i;

	for (i=max_iter; i!=0; i-=2) {
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

//loop unrolling done.
void numt_copy_col(SIZE_T rows, SIZE_T cols, SIZE_T target_col, NUM_T src[rows][cols], NUM_T dest[rows]) {
	SIZE_T i;
	for (i=0; i<rows-1; i+=2) {
		dest[i] = src[i][target_col];
		dest[i+1] = src[i+1][target_col];
	}
	if(rows & 1){
		dest[rows-1] = src[rows-1][target_col];
	}
}

//loop unrolling done.
void numt_set_col(SIZE_T rows, SIZE_T cols, SIZE_T target_col, NUM_T v[rows], NUM_T A[rows][cols]) {
    SIZE_T i;

    for (i=0; i<rows-1; i+=2) {
        A[i][target_col] = (NUM_T) v[i];
		A[i+1][target_col] = (NUM_T) v[i+1];
    }
	if(rows & 1){
		A[rows-1][target_col] = (NUM_T) v[rows-1];
	}
}

//loop unrolling done.
void mat_set_col(SIZE_T rows, SIZE_T cols, SIZE_T target_col, DATA_T v[rows], DATA_T A[rows][cols]) {
	SIZE_T i;

	for(i=0; i<rows-1; i+=2){
		A[i][target_col] = v[i];
		A[i+1][target_col] = v[i+1];
	}
	if(rows & 1){
		A[rows-1][target_col] = v[rows-1];
	}
}

//loop unrolling done.
void vec_sub(SIZE_T size, NUM_T v1[size], NUM_T v2[size]) {
	SIZE_T i;

	for(i=0; i<size-1; i+=2){
		v2[i] -= v1[i];
		v2[i+1] -= v1[i+1];
	}
	if(size & 1){
		v2[size-1] -= v1[size-1];
	}
}

//loop unrolling done.
void numt_vec_copy(SIZE_T size, NUM_T src[size], NUM_T dest[size]) {
	SIZE_T i;

	for(i=0; i<size-1; i+=2){
		dest[i] = (NUM_T) src[i];
		dest[i+1] = (NUM_T) src[i+1];;
	}
	if(size & 1){
		dest[size-1] = (NUM_T) src[size-1];
	}
}

//loop unrolling done.
void vec_copy(SIZE_T size, DATA_T src[size], NUM_T dest[size]) {
    SIZE_T i;

    for (i=0; i<size-1; i+=2) {
        dest[i] = (NUM_T) src[i];
		dest[i+1] = (NUM_T) src[i+1];
    }
	if(size & 1){
		dest[size-1] = (NUM_T) src[size-1];
	}
}

//loop unrolling done.
NUM_T vec_dot(SIZE_T size, NUM_T v1[size], NUM_T v2[size]) {
	NUM_T res = 0;
	SIZE_T i;
	
	for (i=0; i<size-1; i+=2) {
		res += (v1[i] * v2[i]);
		res += (v1[i+1] * v2[i+1]);
	}
	if(size & 1){
		res += (v1[size-1] * v2[size-1]);
	}
	return res;
}

//loop unrolling done.
void vec_mulc(SIZE_T size, NUM_T v[size], NUM_T c) {
	SIZE_T i;

	for (i=0; i<size-1; i+=2) {
		v[i] *= c;
		v[i+1] *= c;
	}
	if(size & 1){
		v[size-1] *= c;
	}
}

//loop unrolling done.
void vec_mul(SIZE_T size, NUM_T src[size], NUM_T dest[size]) {
	SIZE_T i;	

	for (i=0; i<size-1; i+=2) {
		dest[i] *= src[i];
		dest[i+1] *= src[i+1];
	}
	if(size & 1){
		dest[size-1] *= src[size-1];
	}	
}

//loop unrolling done.
void vec_divc(SIZE_T size, NUM_T v[size], NUM_T divisor) {
	assert(divisor > EPSILON);	
	SIZE_T i;

	NUM_T div = 1/divisor;	//operator strength reduction
	
	for (i=0; i<size-1; i+=2){
		v[i] *= div;
		v[i+1] *= div;
	}
	if(size & 1){
		v[size-1] *= div;
	}	
}

//cache friendly matrix transpose
void transpose_m(SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols], DATA_T B[cols][rows], SIZE_T start_i, SIZE_T end_i, SIZE_T start_j, SIZE_T end_j){

	SIZE_T l_i = compute_l(end_i, start_i); //macro
	SIZE_T l_j = compute_l(end_j, start_j); //macro
	SIZE_T i, j;
	
	if (l_i <= 2 && l_j <= 2) {
		for (i = start_i; i < end_i; i++) {
			for (j = start_j; j < end_j; j++) {
				B[j][i] = A[i][j];
			}
		}
	} else if (l_i >= l_j) {
		l_i = l_i >> 1;	//operator strength reduction
		transpose_m(rows, cols, A, B, start_i, start_i + l_i, start_j, end_j);
		transpose_m(rows, cols, A, B, start_i + l_i, end_i, start_j, end_j);
	} else {
		l_j = l_j >> 1;	//operator strength reduction
		transpose_m(rows, cols, A, B, start_i, end_i, start_j, start_j + l_j);
		transpose_m(rows, cols, A, B, start_i, end_i, start_j + l_j, end_j);
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

//loop unrolling done.
void fprintmt(char *fname, char *delim, SIZE_T rows, SIZE_T cols, NUM_T A[rows][cols]) {
	FILE *fptr = openf(fname, "a");
	char *spec = spec_map(NUM_T_KEY);
	SIZE_T i, j;
	
	for (i=0; i<rows; ++i) {
		for (j=0; j<cols-1; j+=2) {
			fprintf(fptr, spec, A[i][j]);
			fprintf(fptr, delim);
			fprintf(fptr, spec, A[i][j+1]);
			fprintf(fptr, delim);
		}
		if(cols & 1){
			fprintf(fptr, spec, A[i][cols-1]);
			fprintf(fptr, delim);
		}
		fprintf(fptr, "\n");
	}
	fprintf(fptr, "\n");	
	fclose(fptr);
}

//debugging function.
void fprintm(char *fname, char *delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]) {
	FILE *fptr = openf(fname, "a");
	char *spec = spec_map(DATA_T_KEY);
	SIZE_T i, j;
	
	for (i=0; i<rows; ++i) {
		for (j=0; j<cols-1; j+=2) {
			fprintf(fptr, spec, A[i][j]);
			fprintf(fptr, delim);
			fprintf(fptr, spec, A[i][j+1]);
			fprintf(fptr, delim);
		}
		if(cols & 1){
			fprintf(fptr, spec, A[i][cols-1]);
			fprintf(fptr, delim);
		}
		fprintf(fptr, "\n");
	}
	fprintf(fptr, "\n");	
	fclose(fptr);
}

//debugging function.
void printm(char *delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]) {
	char *spec = spec_map(DATA_T_KEY);
	SIZE_T i, j;	
	
	for (i=0; i<rows; ++i) {
		for (j=0; j<cols-1; j+=2) {
			printf(spec, A[i][j]);
			printf(delim);
			printf(spec, A[i][j+1]);
			printf(delim);
		}
		if(cols & 1){
			printf(spec, A[i][cols-1]);
			printf(delim);
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

//loop unrolling done.
void zero_m(SIZE_T rows, SIZE_T cols, DATA_T M[rows][cols]){
	SIZE_T i, j;

	for(i = 0; i < rows; i++){
		for(j = 0; j < cols-1; j+=2){
			M[i][j] = 0;
			M[i][j+1] = 0;
		}
		if(cols & 1){
			M[i][cols-1] = 0;
		}
	}
}
