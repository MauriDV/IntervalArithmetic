;Exportamos las subrutinas.
global toInterval
global addInterval
global subInterval
global mulInterval
global supInterval
global infInterval
global getIntervals
global getX
global getY

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

getX:
	enter 0,0
	mov eax,0
	mov eax,[ebp+8]
	shr eax,16
	leave
	ret

getY:
	enter 0,0
	mov eax,0
	mov ax,[ebp+8]
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

	mov eax,0
	mov ebx,0
	mov ecx,0
	mov edx,0

	mov eax,[ebp+8] ;(3,4)
	mov ebx,[ebp+12] ;(1,2)

	mov dx,ax
	shr eax,16
	mov cx,bx
	shr ebx,16

	add eax,ebx	;(1+3)=4
	add ecx,edx	;(2+4)=6

	push eax
	push ecx

	call toInterval

	pop edx
	pop edx
	mov edx,0
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
	mov eax,0
	mov ebx,0
	mov ecx,0
	mov edx,0

	mov eax,[ebp+8] ;(3,4)
	mov ebx,[ebp+12] ;(5,10)

	mov dx,ax ;dx=4
	shr eax,16 ;eax=3
	mov cx,bx	;cx = 10
	shr ebx,16 ;ebx=5

	sub ebx,eax	;(5-3)=2
	sub ecx,edx	;(10-4)=6

	push ebx
	push ecx

	call toInterval

	pop edx
	pop edx
	mov edx,0
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
	mov eax,0
	mov ebx,0
	mov ecx,0
	mov edx,0
	mov edi,0

	mov ebx,[ebp+12] ;ebp+12 = (1.2)
	shr ebx,16 ;ebx=1
	mov ecx,[ebp+8] ;ebp+8 = (3.4)
	shr ecx,16 ;ecx=3
	imul ebx, ecx
	push ebx ;ebx(1*3)=3

	mov ebx, [ebp+12]
	shr ebx,16
	mov ecx, [ebp+8]
	shl ecx,16
	shr ecx,16
	imul ebx, ecx ;ebx(1*4) = 4
	push ebx

	mov ebx, [ebp+12]
	shl ebx,16
	shr ebx,16
	mov ecx, [ebp+8]
	shr ecx,16
	imul ebx,ecx ;ebx(2*3)=6
	push ebx

	mov ebx, [ebp+12]
	shl ebx,16
	shr ebx,16
	mov ecx, [ebp+8]
	shl ecx,16
	shr ecx,16
	imul ebx, ecx ;ebx(2*4)=8
	push ebx

	call minArray

	mov edx,eax

	call maxArray

	pop esi
	pop esi
	pop esi
	pop esi

	push edx
	push eax

	call toInterval

	pop esi
	pop esi
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

	mov eax,0
	mov ecx,0
	mov edx,0
	mov ebx,0

	mov eax,[ebp+12] ;ebp+12 =(1.2)
	shr eax,16
	push eax ;eax=1
	mov eax,[ebp+8] ;ebp+8 =(3.4)
	shr eax,16
	push eax ;eax=3
	mov eax,0
	call calcMax
	pop edx
	pop edx

	mov ebx,eax

	mov eax,0
	mov eax,[ebp+12]	;ebp+12 =(1.2)
	shl eax,16
	shr eax,16 ;eax = 2
	push eax
	mov eax,[ebp+8] ;ebp+8 =(3.4)
	shl eax,16
	shr eax,16
	push eax
	call calcMin

	pop edx
	pop edx

	push eax
	push ebx
	call toInterval
	pop edx
	pop edx

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

	mov eax,0
	mov ebx,0
	mov ecx,0
	mov ebx,0

	mov eax,[ebp+12] ;ebp+12 =(1.2)
	shr eax,16 ;eax=1
	push eax
	mov eax,0
	mov eax,[ebp+8] ;ebp+8=(3.4)
	shr eax,16 ;eax=3
	push eax
	call calcMin
	pop edx
	pop edx

	mov ebx,eax
	mov eax,0

	mov eax,[ebp+12] ;ebp+12 =(1.2)
	shl eax, 16
	shr eax, 16 ;eax = 2
	push eax
	mov eax,[ebp+8] ;ebp+8 = (3.4)
	shl eax,16
	shr eax,16 ;eax = 4
	push eax
	call calcMax
	pop edx
	pop edx

	push ebx
	push eax
	call toInterval
	pop edx
	pop edx

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
