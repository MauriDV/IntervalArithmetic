global toInterval
global addInterval
global subInterval
global mulInterval
global supInterval
global infInterval
global toShow

section .data

section .text

;-----------------------------------------------------------------------------------------------------------------
;Subrutina que arma los intervalos
;
; @params
;	  ebp+8
;		ebp+12
; @return
; 	eax = [limiteInferior,limiteSuperior]
;

toInterval: 
	enter 0,0             ;Setea la pila

	mov eax,0
	mov ax,[ebp+12]       ;Limite Superior 
	rol eax,16            ;Rota el numero y lo pasa a la parte alta del registro
	mov ax,[ebp+8]        ;Limite Inferior

	leave
	ret

;-----------------------------------------------------------------------------------------------------------------
;Subrutina que desarma los intervalos
;
; @params
;		ebp+8 
; @return
; 	ebx = limite inferior 
; 	edx = limite superior
;

toShow:

	enter 0, 0

	mov eax,0						  ;Seteamos los registros
	mov ebx,0						  ;
	mov edx,0						  ;
	mov ecx,0						  ;

	mov eax,[ebp+8]				;Pasamos el numero intervalar a eax

	mov bx, ax						;pasamos el limite superior de eax a bx

	push ebx							;Apilamos 
	call esPositivo				;Llamamos a la subrutina esPositivo
	add esp,4							;Desapilamos ebp

	mov edx,ebx						;Pongo el primer numero completo (32bits) en ebx
	shr eax,16						;Sacamos el limite inferior del numero intervalar

	mov ebx,0							;seteamos ebx
	mov bx, ax						;Pasamos el limite inferior a bx

	push ebx							;Apilamos 
	call esPositivo				;Llamamos a la subrutina
	add esp,4							;Desapilamos

	leave 
	ret

;-----------------------------------------------------------------------------------------------------------------
;Subrutina privada que verifica si un 
;numero es positivo, en el caso de ser 
;negativo el numero se modifica ocupando 
;los 32 bits del registro.
;
; @params
;		ebp+8
; @return
; 	ebx (con el numero modificado en el caso de ser negativo)
;

esPositivo:
	enter 0,0

	mov ecx,0							;Seteamos ecx
	mov ecx,[ebp+8]				;Pasamos el primer numero a ecx
	shl cx,1							;Shifteamos el primer bit del numero para saber si es positivo o negativo
	jc negativo
	jmp positivo
	negativo:
		add ebx,11111111111111110000000000000000b    ;Le sumamos la mascara para acomodar el numero negativo
		jmp end

	positivo:
		jmp end							;Dejamos el numero como esta en caso de ser positivo

	end:
		leave
		ret

;-----------------------------------------------------------------------------------------------------------------
;Subrutina que suma dos intervalos.
;
; @params
;		ebp+8  (limite Inferior)
;		ebp+12 (limite Superior)
;		ebp+16 (limite Inferior)
;		ebp+20 (limite Superior)
; @return
; 	eax = [limiteInferior,limiteSuperior] (suma)
;

addInterval:

	enter 0,0

	mov ebx, 0						;Seteo los registros
	mov edx, 0						;
	mov eax, 0						;
	mov ecx, 0						;

	mov eax,[ebp+8]				;Movemos el numero a eax
	mov ebx,[ebp+12]			;Movemos el numero a ebx
	mov ecx,[ebp+16]			;Movemos el numero a ecx
	mov edx,[ebp+20]			;Movemos el numero a edx

	add eax,edx						;Sumamos los limites inferiores
	push eax							;Apilamos la suma de los limites superiores
	add ebx,ecx						;Sumamos los limites superiores

	push ebx							;Apilamos la suma	superiores
	call toInterval				;Llamamos a la subrutina toInterval para crear el intervalo
	add esp,8							;Desapilamos las dos sumas

	leave
	ret

;-----------------------------------------------------------------------------------------------------------------
;Subrutina que resta dos intervalos.
;
; @params
;		ebp+8  (limite Inferior)
;		ebp+12 (limite Superior)
;		ebp+16 (limite Inferior)
;		ebp+20 (limite Superior)
; @return
; 	eax = [limiteInferior,limiteSuperior] (resta)
;

subInterval: 
	enter 0,0

	mov ebx, 0						;Seteo los registros
	mov edx, 0						;
	mov eax, 0						;
	mov ecx, 0						;

	mov eax,[ebp+8]				;Movemos el numero a eax
	mov ebx,[ebp+12]			;Movemos el numero a ebx
	mov ecx,[ebp+16]			;Movemos el numero a ecx
	mov edx,[ebp+20]			;Movemos el numero a edx

	sub ebx,edx						;Restamos los limites 
	push ebx							;Apilamos el resultado
	sub eax,ecx						;Restamos los limites 

	push eax							;Apilamos el resultado
	call toInterval				;Llamamos a la subrutina para crear el intervalo
	add esp,8							;Desapilamos

	leave
	ret

;-----------------------------------------------------------------------------------------------------------------
;Subrutina que multiplica dos intervalos.
;
; @params
;		ebp+8  (limite Inferior)
;		ebp+12 (limite Superior)
;		ebp+16 (limite Inferior)
;		ebp+20 (limite Superior)
; @return
; 	eax = [limiteInferior,limiteSuperior] (multiplicacion)
;

mulInterval:
	enter 0,0

	mov ebx, 0						;Seteamos los registros
	mov edx, 0						;
	mov eax, 0						;
	mov ecx, 0						;

	mov eax,[ebp+8]				;Movemos el numero a eax
	mov ebx,[ebp+12]			;Movemos el numero a ebx
	mov ecx,[ebp+16]			;Movemos el numero a ecx
	mov edx,[ebp+20]			;Movemos el numero a edx

	imul edx,ebx					;Multiplicamos los limites

	push edx							;Apilamos el primer resultado
	mov edx,[ebp+20]			;Restrablecemos el valor del limite 

	imul ecx, ebx					;Multiplicamos los limites

	push ecx							;Apilamos el segundo resultado
	mov ecx,[ebp+16]			;Restablecemos el valor del limite

	imul edx, eax					;Mutiplicamos los limites

	push edx							;Apilamos el resultado
	mov edx,[ebp+20]			;Restablecemos el valor del limite

	imul ecx,eax					;Multiplicamos los limites

	push ecx							;Apilamos el resultado

	call maxArray					;Llamamos a la subrutina para calcular el maximo
	mov edi, eax					;Lo que hay en eax (nro maximo del arreglo) lo ponemos en edi

	call minArray					;Llamamos a la subrutina para calcular el minimo

	add esp,16						;Desapilamos

	push edi							;Apilamos el maximo
	push eax							;Apilamos el minimo
	call toInterval				;Armamos el intervalo
	add esp, 8						;Desapilamos

	leave
	ret

;-----------------------------------------------------------------------------------------------------------------
;Subrutina que calcula el infimo entre dos intervalos.
;
; @params
;		ebp+8  (limite inferior)
;		ebp+12 (limite superior)
;		ebp+16 (limite inferior)
;		ebp+20 (limite superior)
; @return
; 	eax = [limiteInferior,limiteSuperior] (infimo)
;

infInterval:
	enter 0,0

	mov ebx, 0						;Seteamos los registros
	mov edx, 0						;
	mov eax, 0						;
	mov ecx, 0						;

	mov ebx,[ebp+12]			;Movemos el limite superior a ebx
	mov edx,[ebp+20]			;Movemos el limite superior a edx

	push ebx							;Apilamos el primer numero
	push edx							;Apilamos el segundo numero
	call calcMin					;Llamamos a la subrutina para que calcule el minimo
	add esp,8							;Desapilamos

	mov ebx,eax

	mov eax,[ebp+8]				;Movemos el limite inferior a eax
	mov ecx,[ebp+16]			;Movemos el limite inferior a ecx
	
	push eax							;Apilamos el primer numero
	push ecx 							;Apilamos el segundo numero
	call calcMax					;Llamamos a la subrutina para que calcule el maximo
	add esp,8							;Desapilamos

	push ebx							;Apilamos el minimo
	push eax							;Apilamos el maximo
	call toInterval				;Armamos el intervalo
	add esp,8							;Desapilamos
	
	leave
	ret

;-----------------------------------------------------------------------------------------------------------------
;Subrutina que calcula el supremo entre dos intervalos.
;
; @params
;		ebp+8  (limite inferior)
;		ebp+12 (limite superior)
;		ebp+16 (limite inferior)
;		ebp+20 (limite superior)
; @return
; 	eax = [limiteInferior,limiteSuperior] (supremo)
;

supInterval:
	enter 0,0

	mov ebx, 0						;Seteamos los registros
	mov edx, 0						;
	mov eax, 0						;
	mov ecx, 0					  ;

	mov ebx,[ebp+12]			;Movemos el limite superior a ebx
	mov edx,[ebp+20]			;Movemos el limite superior a edx

	push ebx							;Apilamos el primero numero
	push edx							;Apilamos el segundo numero
	call calcMax					;Llamamos a la subrutina para sacar el maximo entre los dos numeros
	add esp,8							;Desapilamos

	mov ebx,eax						;Ponemos el resultado en ebx

	mov eax,[ebp+8]				;Movemos el limite inferior a eax
	mov ecx,[ebp+16]			;Movemos el limite inferior	a ecx
	
	push eax							;Apilamos el primer numero
	push ecx 							;Apilamos el segundo numero
	call calcMin					;Llamamos a la subrutina para sacar el minimo entre dos numeros
	add esp,8							;Desapilamos

	push ebx							;Apilamos el maximo
	push eax							;Apilamos el minimo
	call toInterval				;Armamos el intervalo
	add esp,8							;Desapilamos
	
	leave
	ret

;-----------------------------------------------------------------------------------------------------------------
;Subrutina privada que calcula el 
;maximo entre 4 numeros (resultados
;de las multiplicaciones) pasados como 
;parametros.
;
; @params
;		ebp+8  (num1)
;		ebp+12 (num2)
;		ebp+16 (num3)
;		ebp+20 (num4)
; @return
; 	eax = numero maximo
;


maxArray:
	enter 0,0

	mov eax, 0
	mov ecx, 0
	mov eax, [ebp+8]			;Muevo el numero a eax
	mov esi, 0						;Seteo esi(variable control)
	add esi,12						;Le sumo 12(No tomamos el primer numero de la pila "ebp+8")
	while_loop_max:
		cmp ecx,5
		jge end_loop_max    ;salto por mayor-igual (>)
		mov edx,[ebp+esi]
		push eax          	;Apilo eax
		push edx          	;Apilo edx
		call calcMax      	;En eax voy a obtener el mayor
		add esp,8         	;Desapilo
		inc esi           	;Avanzo en el arreglo(Incremento el indice de la pila)
		inc esi							;
		inc ecx           	;Incremento la variable control
		jmp while_loop_max  ;vuelvo a la etiqueda del ciclo while

	end_loop_max:
		leave
		ret

;-----------------------------------------------------------------------------------------------------------------
;Subrutina privada que calcula el 
;minimo entre 4 numeros (resultados
;de las multiplicaciones) pasados como 
;parametros.
;
; @params
;		ebp+8  (num1)
;		ebp+12 (num2)
;		ebp+16 (num3)
;		ebp+20 (num4)
; @return
; 	eax = numero minimo
;

minArray:
	enter 0,0

	mov eax, 0						;Seteo eax
	mov ecx, 0						;Seteo ecx
	mov eax, [ebp+8]			;Pongo el primer elemento de la pila en eax
	mov esi, 0						;Seteo esi(Variable control)
	add esi,12						;Empiezo a ver la pila desde el segundo elemento("ebp+12")
	while_loop_min:
		cmp ecx,3
		jge end_loop_min    ;salto por mayor-igual (>)
		mov edx,[ebp+esi]		;Pongo en edx el siguiente elemento de la pila
		push eax          	;Apilo eax
		push edx          	;Apilo edx
		call calcMin      	;Llamo a la subrutina para calcular el minimo
		add esp,8        		;Desapilo
		inc esi           	;Avanzo en el arreglo
		inc esi							;
		inc esi							;
		inc esi							;
		inc ecx           	;Incremento el indice
		jmp while_loop_min  ;vuelvo a la etiqueda del ciclo while

	end_loop_min:
		leave
		ret

;-----------------------------------------------------------------------------------------------------------------
;Subrutina privada que calcula el 
;maximo entre 2 numeros pasados como 
;parametros.
;
; @params
;		ebp+8  (num1)
;		ebp+12 (num2)
; @return
; 	eax = numero maximo
;

calcMax:
	enter 0, 0

	mov eax, 0						;Seteo eax

	mov eax,[ebp+8]   		;A eax le doy el valor del primer parametro

	cmp ax,[ebp+12]				;Comparo la parte baja con el siguiente numero de la pila
	jge mayorIzq      		;Salto a mayorIzq si ax es mayor que lo que hay en [ebp+12]
	jmp mayorDerecha  		;Salto a mayorDerecha si ax es menor que lo que hay en [ebp+12]

	mayorDerecha:
			mov eax, 0				;Seteo eax
			mov eax,[ebp+12]	;Pongo el siguiente elemento en eax(porque es mayor)
			jmp end_max				;Salto al final de la subrutina

	mayorIzq:
		jmp end_max       	; Solo por convencion salto al final luego de cada "metodo".	
	end_max:
		leave
		ret

;-----------------------------------------------------------------------------------------------------------------
;Subrutina privada que calcula el 
;minimo entre 2 numeros pasados como 
;parametros.
;
; @params
;		ebp+8  (num1)
;		ebp+12 (num2)
; @return
; 	eax = numero minimo
;

calcMin:
	enter 0, 0

	mov eax, 0

	mov eax,[ebp+8]   ;A eax le doy el valor del primer parametro

	cmp eax,[ebp+12]	;Comparo el eax con El siguiente elemento
	jle menorIzq      ;Salto si eax es menor que [ebp+12]
	jmp menorDerecha  ;Salto si eax es mayor que [ebp+12]

	menorDerecha:
		mov eax, 0			;Seteo eax
		mov eax,[ebp+12];Pongo el siguiente numero en eax(porque [ebp+12] es mayor)
		jmp end_min			;Salto a la etiqueta "end_min"

	menorIzq:
		jmp end_min     	
	end_min:
		leave
		ret
