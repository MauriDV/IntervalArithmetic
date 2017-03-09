#include <stdio.h>

#define ERROR 99999
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
int mulInterval(int x, int y);
int infInterval(int x, int y);
int supInterval(int x, int y);
int getX(int x);
int getY(int x);

// -------------------------------------------------------------------------

char * printInterval(int x){
  char * a = "";
  int x1 = getX(x);
  int y1 = getY(x);
  asprintf(&a, "[%i,%i]",x1,y1) ;
  return a;
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

int multiplicacionIntervalar(int x, int y){
  return mulInterval(x,y);
}

int infimoIntervalar(int x, int y){
  return infInterval(x,y);
}

int supremoIntervalar(int x, int y){
  return supInterval(x,y);
}
