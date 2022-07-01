#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>

int main(int argc, char *argv[]) {
	char *fname = argv[1];
	uint8_t rows = *(uint8_t *) argv[2];
	uint8_t cols = *(uint8_t *) argv[3];
	
	FILE *fptr = fopen(fname, "r");	
	
	if (fptr == NULL) {
		printf("cannot open matrix file\n");
		exit(0);
	}
	char line[cols * 2 + 1];
	
	while (fgets(line, sizeof(line), fptr)) {
    	printf("%s", line);
	}	
	
	fclose(fptr);

	return 0;
}
