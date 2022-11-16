#include <stdio.h>
#include <stdlib.h>

void printUsage(char *argv[])
{
	printf("Usage: %s <VEC_SIZE> <NUM_STATES> <FILE_PATH> <PROTO_LABEL1> PROTO_LABEL2 ... PROTO_LABELn \n", argv[0]);
}

void printProtoToFile(FILE *fid, char* proto_label, int VEC_SIZE, int NUM_STATES)
{
	int vi, si;
	int i, j;
	
	fprintf(fid, "~h \"%s\"\n", proto_label);
	fprintf(fid, "<BeginHMM>\n");
	fprintf(fid, "<NumStates> %d\n", NUM_STATES);

	for (si = 2; si < NUM_STATES; si++)
	{
		fprintf(fid, "<State> %d\n", si);

		fprintf(fid, "  <Mean> %d \n", VEC_SIZE);
		for (vi = 0; vi < VEC_SIZE; vi++)
			fprintf(fid, "  0.0");
		fprintf(fid, "\n");

		fprintf(fid, "  <Variance> %d\n", VEC_SIZE);
		for (vi = 0; vi < VEC_SIZE; vi++)
			fprintf(fid, "  1.0");
		fprintf(fid, "\n");
	}


	fprintf(fid, "<TransP> %d\n", NUM_STATES);

	float m[NUM_STATES][NUM_STATES];

	// Inicializamos la matriz
	for (i = 0; i < NUM_STATES; i++)
	{
		for (j = 0; j < NUM_STATES; j++)
		{
			m[i][j] = 0.0f;
		}
	}

	m[0][1] = 1.0f;
	for (i = 1; i < NUM_STATES - 1; i++)
	{
		m[i][i] = 0.6f;
		m[i][i + 1] = 0.4f;
	}
	m[NUM_STATES - 2][NUM_STATES - 2] = 0.7f;
	m[NUM_STATES - 2][NUM_STATES - 1] = 0.3f;

	// Imprimimos la matriz
	for (i = 0; i < NUM_STATES; i++)
	{
		for (j = 0; j < NUM_STATES; j++)
		{
			fprintf(fid, "%.1f ", m[i][j]);
		}
		fprintf(fid, "\n");
	}

	fprintf(fid, "<EndHMM>\n");

	/* Ejemplo de Matriz de Transición con 5 estados
	*
	* 	0.0 1.0 0.0 0.0 0.0
	* 	0.0 0.6 0.4 0.0 0.0
	* 	0.0 0.0 0.6 0.4 0.0
	* 	0.0 0.0 0.0 0.7 0.3
	* 	0.0 0.0 0.0 0.0 0.0
	*/
}

int main(int argc, char *argv[])
{
	// Test for errors
	if (argc < 5)
	{
		printUsage(argv);
		return -1;
	}
	
	// Declaracion de variables locales
	int VEC_SIZE;
	int NUM_STATES;
	int i;
	FILE *fid;

	// Inicialización de variables
	VEC_SIZE   = atoi(argv[1]);
	NUM_STATES = atoi(argv[2]);

	// Apertura del fichero
	fid = fopen(argv[3], "w");
	if (fid == NULL)
	{
		printf("ERROR: El fichero %s no se pudo abrir para escriturafopen example", argv[3]);
		return -1;
	}
	
	// Escribimos las cabeceras
	fprintf(fid, "~o <VecSize> %d <USER>\n", VEC_SIZE);

	// Escribimos cada uno de los modelos
	for (i = 4; i < argc; i++)
		printProtoToFile(fid, argv[i], VEC_SIZE, NUM_STATES);

	// Cerramos el fichero
	fclose(fid);
	
	return EXIT_SUCCESS;	
}
