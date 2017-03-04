#include <stdio.h>
#include "api.h"

int createInterval(int x, int y);
int sumaIntervalar(int x, int y);
int restaIntervalar(int x, int y);
int multiplicacionIntervalar(int x, int y);
int printInterval(int x);

int main(int argc, char const *argv[]) {
  int intervalo1 = createInterval(1,2);
  int intervalo2 = createInterval(3,4);
  printInterval(intervalo1);
  printInterval(intervalo2);
  printInterval(multiplicacionIntervalar(intervalo1,intervalo2));
  return 0;
}
