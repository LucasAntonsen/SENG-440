# SENG 440 Progress Report: QR Decomposition
By Ty Ellison (V00916580) and Lucas Antonsen (V00923982)

## Project Specifications
Our project shall make use of the C programming language and an ARM-based processor to create a QR Decomposition program. QR decomposition is useful in a variety of problems such as the Least Squares Problem and results in a matrix that is easier to use in certain capacities [1]. Our program shall use the Gram-Schmidt Orthogonalization algorithm.

## Solution Approach
QR decomposition is where a matrix, $A$, is decomposed to an orthogonal matrix, $Q$, and an upper triangular matrix, $R$, ($A = QR$). A common method to accomplish QR decomposition is through Gram-Schmidt Orthogonalization (GSO) [2].

In GSO, the matrix, $A$, is divided into columns: $A = [a_1 | a_2| \cdots | a_n]$. Then, we have  
$u_1 = a_1,$  
$e_1 = u_1/||u_1||,$  
$u_2 = a_2-(a_2\cdot e_1)e_1,$  
$e_2 = u_2/||u_2||.$  
$u_{k+1} = a_{k+1}-(a_{k+1}\cdot e_1)e_1- \cdots -(a_{k+1}\cdot e_k)e_k,$  
$e_{k+1} = u_{k+1}/||u_{k+1}||$.

Finally,

$$A = [e_1|e_2|\cdots|e_n] 
\begin{bmatrix}
a_{1}\cdot e_1 & a_{2}\cdot e_1 & \cdots & a_{n}\cdot e_1\\
0 & a_{2}\cdot e_2 & \cdots & a_{n}\cdot e_2\\ 
\vdots & \vdots & \ddots & \vdots\\ 
0 & 0 & \cdots & a_{n}\cdot e_n
\end{bmatrix}
= QR$$

GSO is the method we will use for our project.

## Work Completed
We have created a C program, GSO, for our interpretation of the Modified Gram-Schmidt Orthogonalization algorithm (see Appendix). The GSO program shall be used as a base for further optimizations.

In the current version of GSO (see appendix) input is passed via program execution as follows:

```./gso.exe file_input rows columns```

```file_input``` is the file containing the input matrix for QR decomposition.  
```rows``` is the number of rows in the input matrix.  
```columns``` is the number of columns in the input matrix.

From the input, the rows and column sizes are initialized and matrices A, A Transpose, Q and R are initialized based on the row and column sizes.

Using the function ```fscanm```, the file input is read and A is filled with the matrix values. The function ```transpose_m``` then is used to fill A Transpose with the appropriate values based on A.

Next, the function ```QR``` is called which handles the QR decomposition. In ```QR```, the columns of A are iterated through and used to generate u and e, and then the values of R and Q are populated.

A variety of functions are used in QR. ```vec_copy``` copies a vector represented as an array to another vector. ```l2_norm``` generates the Euclidean norm of a given vector. ```vec_div``` divides a vector by a constant. ```vec_dot``` generates the dot product of two vectors. ```vec_mulc``` multiplies a vector by a constant.

Additional auxiliary functions include ```sqr_rt```, a function for calculating the square root of a number, which is used by ```l2_norm```. The ```sqr_rt``` function utilizes the Newton-Raphson method for approximating a root of a function, in this case the function is the square root of a constant. The Newton-Raphson method requires a sufficiently good initial guess for the root being approximated. The ```closest_perfect_square``` function was created to seed the initial guess for the Newton-Raphson method. ```sqr_rt``` also uses the function ```abs_val``` for calculating the absolute forward error between successive root approximations. 

The function ```fprintm``` prints the matrix from file input. ```spec_map``` is used to select the appropriate format specifier for various data types. ```printm``` prints matrices, ```printv``` prints vectors, and ```openf``` opens files and checks to make sure the file was open properly.

## Future Plans

Moving forward, we plan on generating test matrices of various sizes and degrees of precision, measuring the run-time of the QR decomposition over the test suite, measuring the amount of numerical error accumulated for each input matrix in the test suite, using these measurements to decide if we need to make any implementation or algorithmic changes, and then perform C and assembly optimizations. It is important to note that the decomposition was written to allow for non-square real valued input matrices. Since ```sqr_rt``` may return a real number (not strictly an integer), we require the use of fixed or floating point arithmetic. Two potential hardware considerations we have are a) whether or not the specific hardware has a dedicated floating point unit, and b) the mathematical instructions (e.g. FSQRT) available on the specific arm device we use.  We are considering a variety of software optimizations including but not limited to loop unrolling, instruction pipelining, cache efficient data loading, and the use of SIMD operations.

## Questions

Should we consider other QR decomposition algorithms such as Householder Reflections or Givens Rotations or is the Modified Gram-Schmidt algorithm sufficient?

How could ill-conditioned matrices affect the accuracy of our algorithm?

Are we allowed to use any libraries for the project (e.g. standard library for file IO and string operations)?

How do we determine the memory (including size of different cache levels) and storage requirements of the system?

How could we implement some of our numerical routines (e.g. ```sqr_rt```) as hardware or firmware?

## References
[1] B. D. Shaffer, “QR Matrix Factorization,” towardsdatascience.com, Feb. 27, 2020. [Online]. Available: https://towardsdatascience.com/qr-matrix-factorization-15bae43a6b2.  
[2] I. Yanovsky. Author. QR Decomposition with Gram-Schmidt [Online Document]. Available: https://www.math.ucla.edu/~yanovsky/Teaching/Math151B/handouts/GramSchmidt.pdf.


## Appendix

The code for our GSO program is found below.

```c
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
void printm(char *delim, SIZE_T rows, SIZE_T cols, DATA_T A[rows][cols]);
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
			spec = "%.4lf";
			break;
	
		case 'f':
			spec = "%.4f";
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
```
