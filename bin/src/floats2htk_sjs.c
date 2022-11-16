#include <stdio.h>
#include <stdlib.h>


/** 
 * @floats2htk Pasa de un formato texto ASCII a un formato binario. 
 * En este caso, numeros en coma flotante con un rango de 4 bytes,
 * en formato big endian. 
 * El motivo es que ese es el formato que acepta HTK.
 *
 * @author Carlos Martínez Hinarejos
 * @author Santiago Jiménez-Serrano 
 */


void write_long(FILE* fid, long value)
{
    fwrite(((char*) &value) + 3, sizeof(char), 1, fid);
    fwrite(((char*) &value) + 2, sizeof(char), 1, fid);
    fwrite(((char*) &value) + 1, sizeof(char), 1, fid);
    fwrite(((char*) &value)    , sizeof(char), 1, fid);
}

void write_int(FILE* fid, int value) 
{
    fwrite(((char*) &value) + 1, sizeof(char), 1, fid);
    fwrite(((char*) &value)    , sizeof(char), 1, fid);
}

void write_float(FILE *fid, float value)
{
    fwrite(((char*) &value) + 3, sizeof(char), 1, fid);
    fwrite(((char*) &value) + 2, sizeof(char), 1, fid);
    fwrite(((char*) &value) + 1, sizeof(char), 1, fid);
    fwrite(((char*) &value)    , sizeof(char), 1, fid);
}

int main(int argc, char *argv[])
{
    if(argc < 2)
    {
        fprintf(stdout,"USAGE: %s <NUM_COMPONENTS> <VECTORS> < <RAW_SAMPLE> > <HTK_SAMPLE>\n", argv[0]);
        return EXIT_FAILURE;
    }

    int h = atoi(argv[1]);
    int w = atoi(argv[2]);

    write_long(stdout, w);
    write_long(stdout, 10000);
    write_int(stdout,  4*h);
    write_int(stdout,  9);

    float f;
    while((fscanf(stdin,"%f",&f)) != EOF)
    {
        write_float(stdout, f);
    }

    return EXIT_SUCCESS;
}

