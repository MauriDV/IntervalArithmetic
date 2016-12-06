#include <stdio.h>

int toInterval(int a, int b);

int addInterval(int x, int y, int z, int t);

int subInterval(int x, int y, int z, int t);

int mulInterval(int x, int y, int z, int t);

int supInterval(int x, int y, int z, int t);

int infInterval(int x, int y, int z, int t);

int control(int x, int y, int z, int t);

int toShow(int x);

int createInterval(int x, int y){
	return toInterval(x,y);
}

int printInterval(int interval){
	toShow(interval);
	register int edx asm("edx");
	register int ebx asm("ebx");
	printf("[%d,%d]", edx , ebx);
	return 0;
}

int sumaInterval(int x, int y){
	toShow(x);
	register int x1 asm("edx");
	register int y1 asm("ebx");
	int aux1 = x1;
	int aux2 = y1;
	toShow(y);
	register int x2 asm("edx");
	register int y2 asm("ebx");
	int aux3 = x2;
	int aux4 = y2;
	return addInterval(aux2,aux3,aux1,aux4);
}

int restaInterval(int x, int y){
	toShow(x);
	register int x1 asm("edx");
	register int y1 asm("ebx");
	int aux1 = x1;
	int aux2 = y1;
	toShow(y);
	register int x2 asm("edx");
	register int y2 asm("ebx");
	int aux3 = x2;
	int aux4 = y2;
	return subInterval(aux1,aux2,aux3,aux4);
}

int multiplicacionInterval(int x, int y){
	toShow(x);
	register int x1 asm("edx");
	register int y1 asm("ebx");
	int aux1 = x1;
	int aux2 = y1;
	toShow(y);
	register int x2 asm("edx");
	register int y2 asm("ebx");
	int aux3 = x2;
	int aux4 = y2;
	return mulInterval(aux1,aux2,aux3,aux4);
}

int infimoInterval(int x, int y){
	toShow(x);
	register int x1 asm("edx");
	register int y1 asm("ebx");
	int aux1 = x1;
	int aux2 = y1;
	toShow(y);
	register int x2 asm("edx");
	register int y2 asm("ebx");
	int aux3 = x2;
	int aux4 = y2;
	int interval = infInterval(aux1,aux2,aux3,aux4);
	toShow(interval);
	register int limiteInferior asm("edx");
	register int limiteSuperior asm("ebx");
	int li = limiteInferior;
	int ls = limiteSuperior;
	if(li>=ls){
		return 99999;
	}else{
		return interval;
	}
}

int supremoInterval(int x, int y){
	toShow(x);
	register int x1 asm("edx");
	register int y1 asm("ebx");
	int aux1 = x1;
	int aux2 = y1;
	toShow(y);
	register int x2 asm("edx");
	register int y2 asm("ebx");
	int aux3 = x2;
	int aux4 = y2;
	return supInterval(aux1,aux2,aux3,aux4);
}

int setInterval(){
	int a;
	int b;
	printf("limite inferior: ");
	scanf("%d", &a);
	do{
		printf("limite superior: ");
		scanf("%d", &b);
	}while(a>b);
	return createInterval(a,b);
}

int showResults(int x, int y){
	printf("--------------------------------------\n");
	printf("Numeros intervalares ingresados: \n");
	printf("    ·");
	printInterval(x);
	printf("    ·");
	printInterval(y);
	printf("\n");
	printf("--------------------------------------\n");
	printf("Suma: ");
	printInterval(sumaInterval(x,y));
	printf("\n");
	printf("--------------------------------------\n");
	printf("Resta: ");
	printInterval(restaInterval(x,y));
	printf("\n");
	printf("--------------------------------------\n");
	printf("Multiplicacion: ");
	printInterval(multiplicacionInterval(x,y));
	printf("\n");
	printf("--------------------------------------\n");
	printf("Infimo: ");
	int inter = infimoInterval(x,y);
	if(inter == 99999){
		printf("es vacio");
	}else{
		printInterval(inter);
	}
	printf("\n");
	printf("--------------------------------------\n");
	printf("Supremo: ");
	printInterval(supremoInterval(x,y));
	printf("\n");
	printf("--------------------------------------\n");
	return 0;
}

int main(int argc, char **argv)
{
	printf("--------------------------------------\n");
	printf("Primer numero intervalar:\n");
	int interval1 = setInterval();
	printf("--------------------------------------\n");
	printf("Segundo numero intervalar:\n");
	int interval2 = setInterval();
	showResults(interval1,interval2);
	return 0;
}