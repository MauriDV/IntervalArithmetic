#include <stdio.h>
#include "api.h"

int createInterval(int x, int y);
int sumaIntervalar(int x, int y);
int restaIntervalar(int x, int y);
int multiplicacionIntervalar(int x, int y);
int infimoIntervalar(int x, int y);
int supremoIntervalar(int x, int y);
char * printInterval(int x);


int main(int argc, char const *argv[]) {

  int intervalo1 = createInterval(1,2);
  int intervalo2 = createInterval(3,4);

  printf("Operaciones entre: %s y %s \n", printInterval(intervalo1),printInterval(intervalo2));

  printf("Suma: ");
  printf("%s\n", printInterval(sumaIntervalar(intervalo1,intervalo2)));
  printf("Resta: ");
  printf("%s\n", printInterval(restaIntervalar(intervalo1,intervalo2)));
  printf("Multiplicacion: ");
  printf("%s\n", printInterval(multiplicacionIntervalar(intervalo1,intervalo2)));
  printf("Infimo: ");
  printf("%s\n", printInterval(infimoIntervalar(intervalo1,intervalo2)));
  printf("Supremo: ");
  printf("%s\n", printInterval(supremoIntervalar(intervalo1,intervalo2)));

  return 0;
}
