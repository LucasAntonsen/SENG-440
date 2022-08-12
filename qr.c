#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <assert.h>
#include "qr.h"
#include <time.h>
#include "fixed.h"


int main(int argc, char *argv[]) {
	char output[FX_MAX_BIN_CHARS];	
	char input[FX_MAX_DEC_CHARS] = "-1086.432";
	char decimal[] = ".";
	printf("decimal string input = %s\n", input);	
	UFX_T fx = str_to_fx(input, decimal, FX_FRACT_BITS);	
	bin_fx_to_str(output, fx);
	printf("fixed point binary string = %s\n", output);

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

	for(i = 0; i < 100; i++){
		start = clock();

		zero_m(ROWS, COLS, A);
		zero_m(COLS, ROWS, At);
		zero_m(ROWS, ROWS, Q);
		zero_m(ROWS, COLS, R);
		
		fscanm(fin, delim, ROWS, COLS, A);	
		transpose_m(ROWS, COLS, A, At, 0, ROWS, 0, COLS);
		//transpose_m(ROWS, COLS, A, At);
		
		QR(ROWS, COLS, At, Q, R);
		
		fprintmt(fout, delim, ROWS, ROWS, Q);
		fprintmt(fout, delim, ROWS, COLS, R);	

		finish = clock();
	
		// Calculating total time taken by the program.
		time_taken += ((float) (finish - start)) / CLOCKS_PER_SEC;
	}
	printf ("Total time = %lf seconds\n", time_taken/100.0);

	return 0;
}
