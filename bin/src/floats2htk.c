#include <stdio.h>
#include <stdlib.h>

void write_long(long data, FILE *arch_dest) {
  fwrite( ((char*) &data) + 3, sizeof(char), 1, arch_dest);
  fwrite( ((char*) &data) + 2, sizeof(char), 1, arch_dest);
  fwrite( ((char*) &data) + 1, sizeof(char), 1, arch_dest);
  fwrite( ((char*) &data)    , sizeof(char), 1, arch_dest);
}

void write_int(int data, FILE *arch_dest) {
  fwrite( ((char*) &data) + 1, sizeof(char), 1, arch_dest);
  fwrite( ((char*) &data)    , sizeof(char), 1, arch_dest);
}

void write_float(float data, FILE *arch_dest) {
  fwrite( ((char*) &data) + 3, sizeof(char), 1, arch_dest);
  fwrite( ((char*) &data) + 2, sizeof(char), 1, arch_dest);
  fwrite( ((char*) &data) + 1, sizeof(char), 1, arch_dest);
  fwrite( ((char*) &data)    , sizeof(char), 1, arch_dest);
}

int main(int argc, char *argv[])
{
  float f;

  if(argc < 2)
  {
    fprintf(stdout,"USAGE: %s <NUM_COMPONENTS> <VECTORS> < <RAW_SAMPLE> > <HTK_SAMPLE>\n",argv[0]);
    exit(1);
  }
  int h = atoi(argv[1]);
  int w = atoi(argv[2]);

  write_long(w,stdout); write_long(10000,stdout); write_int(4*h,stdout); write_int(9,stdout);

  while((fscanf(stdin,"%f",&f)) != EOF){
    write_float(f,stdout);
  }

  exit(0);
}

