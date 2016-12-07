#include <stdio.h>

#define KRED "\x1B[31m"
#define RESET "\x1B[0m"

/*

	Proyecto Organizacion del procesador 2016
	
	Integrantes: 
		
		· Fernandez, Federico.
		· Delle Vedove, Mauricio.

*/

// SubRutinas implementadas en lenguaje ensamblador. (intervalArithmetic.asm)

int toInterval(int a, int b);

int addInterval(int x, int y, int z, int t);

int subInterval(int x, int y, int z, int t);

int mulInterval(int x, int y, int z, int t);

int supInterval(int x, int y, int z, int t);

int infInterval(int x, int y, int z, int t);

int getIntervals(int x);

// -------------------------------------------------------------------------


/*
	descrip: crea un numero intervalar.

	pre: -32678<x<32678 y -32678<y<32678.
	pos: un numero que representa un intervalo [x,y].
*/
int createInterval(int x, int y){
	return toInterval(x,y);
}

/*
	descrip: funcion para mostrar un numero
	intervalar.

	pre: true
	pos: un string representando el numero intervalar ('[x,y]')
*/
int printInterval(int interval){
	getIntervals(interval);
	register int edx asm("edx");  //Recuperamos los valores de los registros 
	register int ebx asm("ebx");  //en los que se guardo el valor de cada limite.
	printf("[%d,%d]", edx , ebx);
	return 0;
}

/*
	descrip: funcion que calcula la suma entre 2 
	numeros intervalar llamando a la subrutina definida 
	en lenguaje ensamblador.

	pre: x=intervalo e y=intervalo
	pos: un intervalo (representado con un entero) con la suma entre x e y.
*/
int sumaInterval(int x, int y){
	getIntervals(x);     
	register int x1 asm("edx");   //Recuperamos los valores de los registros 
	register int y1 asm("ebx");	  //en los que se guardo el valor de cada limite.
	int aux1 = x1;
	int aux2 = y1;
	getIntervals(y);
	register int x2 asm("edx");   //Recuperamos los valores de los registros
	register int y2 asm("ebx");	  //en los que se guardo el valor de cada limite.
	int aux3 = x2;
	int aux4 = y2;

	//Verifico que la suma no exceda la cantidad de 16bits para poder representarlo en un registro de 32bits  
	if(((aux1+aux3)<32768)&&(((aux1+aux3)>-32768))&&((aux2+aux4)<32768)&&(((aux2+aux4)>-32768))){
		return addInterval(aux2,aux3,aux1,aux4);
	}else{
		//en el caso de no poder representar el numero retorno 99999 (error)
		return 99999;
	}
}

/*
	descrip: funcion que calcula la resta entre 2 
	numeros intervalar llamando a la subrutina definida 
	en lenguaje ensamblador.

	pre: x=intervalo e y=intervalo
	pos: un intervalo (representado con un entero) con la resta entre x e y.
*/
int restaInterval(int x, int y){
	getIntervals(x);
	register int x1 asm("edx");	  //Recuperamos los valores de los registros 
	register int y1 asm("ebx");	  //en los que se guardo el valor de cada limite.
	int aux1 = x1;
	int aux2 = y1;
	getIntervals(y);
	register int x2 asm("edx");   //Recuperamos los valores de los registros 
	register int y2 asm("ebx");	  //en los que se guardo el valor de cada limite.
	int aux3 = x2;
	int aux4 = y2;

	//Verifico que la resta no exceda la cantidad de 16bits para poder representarlo en un registro de 32bits  
	if(((aux1-aux3)<32768)&&(((aux1-aux3)>-32768))&&((aux2-aux4)<32768)&&(((aux2-aux4)>-32768))){
		return subInterval(aux1,aux2,aux3,aux4);
	}else{
		//en el caso de no poder representar el numero retorno 99999 (error)
		return 99999;
	}
}

/*
	descrip: funcion que calcula la multiplicacion entre 2 
	numeros intervalar llamando a la subrutina definida 
	en lenguaje ensamblador.

	pre: x=intervalo e y=intervalo
	pos: un intervalo (representado con un entero) con la multiplicacion de x e y.
*/
int multiplicacionInterval(int x, int y){
	getIntervals(x);
	register int x1 asm("edx");  //Recuperamos los valores de los registros 
	register int y1 asm("ebx");	 //en los que se guardo el valor de cada limite.
	int aux1 = x1;
	int aux2 = y1;
	getIntervals(y);
	register int x2 asm("edx");	 //Recuperamos los valores de los registros 
	register int y2 asm("ebx");	 //en los que se guardo el valor de cada limite.
	int aux3 = x2;
	int aux4 = y2;

	//Verifico que la multiplicacion no exceda la cantidad de 16bits para poder representarlo en un registro de 32bits 
	if(
		(((aux1*aux3)<32768)&&((aux1*aux3)>-32768))&&
		(((aux1*aux4)<32768)&&((aux1*aux4)>-32768))&&
		(((aux2*aux3)<32768)&&((aux2*aux3)>-32768))&&
		(((aux2*aux4)<32768)&&((aux2*aux4)>-32768))
	){
		return mulInterval(aux1,aux2,aux3,aux4);
	}else{
		//en el caso de no poder representar el numero retorno 99999 (error)
		return 99999;
	}
}

/*
	descrip: funcion que calcula el infimo entre 2 
	numeros intervalar llamando a la subrutina definida 
	en lenguaje ensamblador.

	pre: x=intervalo e y=intervalo
	pos: un intervalo (representado con un entero) con el infimo entre x e y.
*/
int infimoInterval(int x, int y){
	getIntervals(x);
	register int x1 asm("edx");  //Recuperamos los valores de los registros 
	register int y1 asm("ebx");	 //en los que se guardo el valor de cada limite.
	int aux1 = x1;
	int aux2 = y1;
	getIntervals(y);
	register int x2 asm("edx");  //Recuperamos los valores de los registros 
	register int y2 asm("ebx");	 //en los que se guardo el valor de cada limite.
	int aux3 = x2;
	int aux4 = y2;
	int interval = infInterval(aux1,aux2,aux3,aux4);

	// verifico que el numero obtenido no sea vacio.
	getIntervals(interval);
	register int limiteInferior asm("edx");
	register int limiteSuperior asm("ebx");
	int li = limiteInferior;
	int ls = limiteSuperior;
	if(li>=ls){
		//en el caso de ser vacio retorno 99999 (error)
		return 99999;
	}else{
		return interval;
	}
}

/*
	descrip: funcion que calcula el supremo entre 2 
	numeros intervalar llamando a la subrutina definida 
	en lenguaje ensamblador.

	pre: x=intervalo e y=intervalo
	pos: un intervalo (representado con un entero) con el supremo entre x e y.
*/
int supremoInterval(int x, int y){
	getIntervals(x);
	register int x1 asm("edx");  //Recuperamos los valores de los registros 
	register int y1 asm("ebx");	 //en los que se guardo el valor de cada limite.
	int aux1 = x1;
	int aux2 = y1;
	getIntervals(y);
	register int x2 asm("edx");  //Recuperamos los valores de los registros 
	register int y2 asm("ebx");	 //en los que se guardo el valor de cada limite.
	int aux3 = x2;
	int aux4 = y2;
	return supInterval(aux1,aux2,aux3,aux4);
}


/*
	descrip: funcion para verificar si un numero 
	intervalar es correcto.

	pre: interval = intervalo
	pos: true(1) en el caso de que la representacion del intervalo
	sea correcta, false(0) en el caso contrario. 
*/
int repOk(int interval){
	getIntervals(interval);
	register int x asm("edx");
	register int y asm("ebx");
	return (x<=y);
}

/*
	descrip: funcion que crea un numero 
	intervalar correcto.

	pre: true
	pos: un numero intervalar
*/
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
	return createInterval(a,b);
}

/*
	descrip: funcion para mostrar los resultados
	de las operaciones de los numeros intervalares.

	pre: true
	pos: informacion sobre las operaciones basicas 
	entre numeros intervalares. 
*/
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
	int interSuma = sumaInterval(x,y);
	// TRATAMIENTO DE ERRORES DE REPRESENTACION
	if((interSuma==99999)||(!(repOk(interSuma)))){
		printf("el numero intervalar es incorrecto o no se pudo representar en 16bits");
	}else{
		printInterval(interSuma);
	}
	printf("\n");
	printf("--------------------------------------\n");
	printf("Resta: ");
	int interResta = restaInterval(x,y);
	// TRATAMIENTO DE ERRORES DE REPRESENTACION
	if((interResta==99999)||(!(repOk(interResta)))){
		printf("el numero intervalar es incorrecto o no se pudo representar en 16bits");
	}else{
		printInterval(interResta);
	}
	printf("\n");
	printf("--------------------------------------\n");
	printf("Multiplicacion: ");
	int interMul = multiplicacionInterval(x,y);
	// TRATAMIENTO DE ERRORES DE REPRESENTACION
	if((interMul==99999)||(!(repOk(interMul)))){
		printf("el numero intervalar es incorrecto o no se pudo representar en 16bits");
	}else{
		printInterval(interMul);
	}
	printf("\n");
	printf("--------------------------------------\n");
	printf("Infimo: ");
	int inter = infimoInterval(x,y);
	// TRATAMIENTO DE ERRORES DE REPRESENTACION
	if(inter == 99999){
		printf("es vacio");
	}else{
		if(repOk(inter)){
			printInterval(inter);
		}else{
			printf("el numero intervalar es incorrecto");
		}
	}
	printf("\n");
	printf("--------------------------------------\n");
	printf("Supremo: ");
	int interSup = supremoInterval(x,y);
	// TRATAMIENTO DE ERRORES DE REPRESENTACION
	if(repOk(interSup)){
		printInterval(interSup);
	}else{
		printf("el numero intervalar es incorrecto");
	}
	printf("\n");
	printf("--------------------------------------\n");
	return 0;
}

/*
	Programa principal.
*/

int main(int argc, char **argv){
	int a;
	do{
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
		showResults(interval1,interval2);
	}else{
		int int1 = createInterval(0,0);
		int int2 = createInterval(-32767,32767);
		int int3 = createInterval(6,10);
		int int4 = createInterval(-4,-1);
		int int5 = createInterval(-30,120);
		int int6 = createInterval(30,-120);
		int int7 = createInterval(-54,-1);
		int int8 = createInterval(1500,1500);
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

	}
	return 0;
}