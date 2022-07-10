#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <assert.h>
#include "qr.h"


int main(int argc, char *argv[]) {
	char *end;
	char delim[] = " ";	
	assert(argc == 5);
	char *fin = argv[1];
	char *fout = argv[2];
	SIZE_T ROWS = (SIZE_T) strtoull(argv[3], &end, 10);
	SIZE_T COLS = (SIZE_T) strtoull(argv[4], &end, 10);
	
	DATA_T A[ROWS][COLS];
	DATA_T At[COLS][ROWS];
	NUM_T Q[ROWS][ROWS];
	NUM_T R[ROWS][COLS];
	
	fscanm(fin, delim, ROWS, COLS, A);	
	transpose_m(ROWS, COLS, A, At);
	
	QR2(ROWS, COLS, At, Q, R);
	
	fprintmt(fout, delim, ROWS, ROWS, Q);
	fprintmt(fout, delim, ROWS, COLS, R);

	// printf("%lf", sqr_rt(9.0/11.0, EPSILON, TOLERANCE, MAX_ITER));
	// printf("%lf", sqr_rt(66, EPSILON, TOLERANCE, MAX_ITER));	
	return 0;
}
