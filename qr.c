#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <assert.h>
#include "qr.h"
#include <time.h>


int main(int argc, char *argv[]) {
	clock_t start, finish;

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

	SIZE_T i;
	double time_taken = 0;

	for(i = 0; i < 10000; i++){
		start = clock();

		zero_m(ROWS, COLS, A);
		zero_m(COLS, ROWS, At);
		zero_m(ROWS, ROWS, Q);
		zero_m(ROWS, COLS, R);
		
		fscanm(fin, delim, ROWS, COLS, A);	
		transpose_m(ROWS, COLS, A, At);
		
		QR(ROWS, COLS, At, Q, R);
		
		fprintmt(fout, delim, ROWS, ROWS, Q);
		fprintmt(fout, delim, ROWS, COLS, R);	

		finish = clock();
	
		// Calculating total time taken by the program.
		time_taken += ((float) (finish - start)) / CLOCKS_PER_SEC;
	}
	printf ("Total time = %lf seconds\n", time_taken/10000.0);

	return 0;
}
