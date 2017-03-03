#include <stdio.h>

/*

	Proyecto Organizacion del procesador 2016

	Integrantes:

		· Fernandez, Federico.
		· Delle Vedove, Mauricio.

*/

// SubRutinas implementadas en lenguaje ensamblador. (intervalArithmetic.asm)
//      API

int toInterval(int a, int b);
int addInterval(int x, int y);
int subInterval(int x, int y);
int getX(int x);
int getY(int x);

// -------------------------------------------------------------------------

int printInterval(int x){
  int x1 = getX(x);
  int y1 = getY(x);
  printf("[%x,%x]\n", x1,y1);
  return 0;
}

int createInterval(int x, int y){
  return toInterval(y,x);
}

int sumaIntervalar(int x, int y){
  return addInterval(x,y);
}

int restaIntervalar(int x, int y){
  return subInterval(x,y);
}
