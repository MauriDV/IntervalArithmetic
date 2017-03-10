#include <stdio.h>
#include "api.h"

#define KRED "\x1B[31m"
#define RESET "\x1B[0m"

int setInterval(){
	int a;
	int b;
	do{
		printf("limite Inferior: ");
		scanf("%d", &a);
	}while((a>=32768)||(a<=-32768));  //verifico que el numero ingresado se pueda representar con 16bits
	do{
		printf("limite superior: ");
		scanf("%d", &b);					  //verifico que el numero ingresado se pueda representar
	}while((a>b)||((b>=32768)||(b<=-32768))); // con 16bits, ademas que sea mayor al limite inferior.
	return toInterval(a,b);
}

void showResults(int x, int y){
  printf("Intervalos ingresados: %s - %s \n", printInterval(x),printInterval(y));
  printf("Suma: %s\n",printInterval(addInterval(x,y)));
  printf("Resta: %s\n",printInterval(subInterval(x,y)));
  printf("Multiplicacion: %s\n",printInterval(mulInterval(x,y)));
  printf("Supremo: %s\n",printInterval(supInterval(x,y)));
  printf("Infimo: %s\n",printInterval(infInterval(x,y)));
}

int main(int argc, char const *argv[]) {
  int a;
	do{
    system("clear");
		printf("------------------Menu--------------------\n");
		printf("1) Igresar numeros intervalares.\n");
		printf("2) Test\n");
		printf("--------------------------------------\n");
		printf("...ingrese 1 o 2:");
		scanf("%d", &a);
	}while (a!=2 && a!=1);
	if(a==1){
		printf("--------------------------------------\n");
		printf("Primer numero intervalar:\n");
		int interval1 = setInterval(); //Creacion del primer intervalo.
		printf("--------------------------------------\n");
		printf("Segundo numero intervalar:\n");
		int interval2 = setInterval(); //Creacion del segundo intervalo.
    system("clear");
		showResults(interval1,interval2);
	}else{
    int int1 = toInterval(0,1);
		int int2 = toInterval(-32767,32767);
		int int3 = toInterval(6,10);
		int int4 = toInterval(-4,-1);
		int int5 = toInterval(-30,120);
		int int6 = toInterval(-120,30);
		int int7 = toInterval(-54,-1);
		int int8 = toInterval(1500,1501);
		printf("\n");
		printf(KRED "TEST N° 0\n" RESET);
		showResults(int1,int1); //[0,0],[0,0]
		printf("\n");
		printf(KRED "TEST N° 1\n" RESET);
		showResults(int1,int2); //[0,0],[-32767,32767]
		printf("\n");
		printf(KRED "TEST N° 2\n" RESET);
		showResults(int1,int3); //[0,0],[6,10]
		printf("\n");
		printf(KRED "TEST N° 3\n" RESET);
		showResults(int1,int4); //[0,0],[-4,-1]
		printf("\n");
		printf(KRED "TEST N° 4\n" RESET);
		showResults(int3,int8); //[6,10],[1500,1500]
		printf("\n");
		printf(KRED "TEST N° 5\n" RESET);
		showResults(int3,int4); //[6,10],[-4,-1]
		printf("\n");
		printf(KRED "TEST N° 6\n" RESET);
		showResults(int4,int7); //[-4,1],[-54,-1]
		printf("\n");
		printf(KRED "TEST N° 7\n" RESET);
		showResults(int8,int8); //[1500,1500],[1500,1500]
		printf("\n");
		printf(KRED "TEST N° 8\n" RESET);
		showResults(int6,int5); //[30,-120],[-30,120]
		printf("\n");
		printf(KRED "TEST N° 9\n" RESET);
		showResults(int5,int6); //[-30,120],[30,-120]
		printf("\n");
		printf("Fin");
    printf("\n");
  }

  return 0;
}
