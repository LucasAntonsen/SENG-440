#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <assert.h>
#include "qr.h"
#include <time.h>


int main(int argc, char *argv[]) {
	clock_t start, finish;			//for measuring program runtime

	char *end;
	char delim[] = " ";	
	assert(argc == 5);		//./qr.exe input_m.txt output_m.txt ROWS COLS
	char *fin = argv[1];	//file input pointer for matrix input
	char *fout = argv[2];	//file output pointer for QR output
	SIZE_T ROWS = (SIZE_T) strtoull(argv[3], &end, 10);
	SIZE_T COLS = (SIZE_T) strtoull(argv[4], &end, 10);
	
	DATA_T A[ROWS][COLS];
	DATA_T At[COLS][ROWS];
	NUM_T Q[ROWS][ROWS];
	NUM_T R[ROWS][COLS];

	SIZE_T i;
	double time_taken = 0;

	for(i = 0; i < 100; i++){	//run 100 times
		start = clock();		//start time

		zero_m(ROWS, COLS, A);	//zero out matrices so garbage values aren't used in calculations
		zero_m(COLS, ROWS, At);
		zero_m(ROWS, ROWS, Q);
		zero_m(ROWS, COLS, R);
		
		fscanm(fin, delim, ROWS, COLS, A);					//load input matrix values into matrix A
		transpose_m(ROWS, COLS, A, At, 0, ROWS, 0, COLS);	//new cache-oblivious matrix transpose function call
		//transpose_m(ROWS, COLS, A, At);					//old matrix transpose function call
		
		QR(ROWS, COLS, At, Q, R);				//call QR to perform the QR decomposition
		
		fprintmt(fout, delim, ROWS, ROWS, Q);	//print Q to output file
		fprintmt(fout, delim, ROWS, COLS, R);	//print R to output file

		finish = clock();	//end time
	
		//calculating total time taken by the program
		time_taken += ((float) (finish - start)) / CLOCKS_PER_SEC;	//add measurement for this run to the total time taken
	}
	printf ("Total time = %lf seconds\n", time_taken/100.0);	//divide the total time taken for all runs by 100 to get the average

	return 0;
}
