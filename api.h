#include <stdio.h>
/*

	Proyecto Organizacion del procesador 2016

	Integrantes:

		· Fernandez, Federico.
		· Delle Vedove, Mauricio.

*/

// SubRutinas implementadas en lenguaje ensamblador. (intervalArithmetic.asm)
//      API

int toInterval(int x, int y);
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
  //printf("%d,%d\n",x1,y1);
  if(x1>=y1){
    asprintf(&a, "Vacio o el numero no tiene una representacion valida") ;
  }else{
    asprintf(&a, "[%d,%d]",x1,y1) ;
  }
  return a;
}
