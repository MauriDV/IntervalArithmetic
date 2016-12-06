global toInterval
global addInterval
global subInterval
global mulInterval
global supInterval
global infInterval
global toShow

section .data

section .text

;--------------------------------------------------
;Subrutina que arma los intervalos
;
; @params
;	ebp+8
;	ebp+12
; @return
; 	eax = [limiteInferior,limiteSuperior]
;

toInterval: 
	enter 0, 0

	mov eax,0
	mov ax,[ebp+12]
	rol eax,16
	mov ax,[ebp+8]

	mov esp,ebp
	pop ebp
	ret

;--------------------------------------------------
;Subrutina que desarma los intervalos
;
; @params
;	ebp+8
; @return
; 	ebx = limite inferior 
; 	edx = limite superior
;

toShow:

	enter 0, 0

	mov eax,0
	mov ebx,0
	mov edx,0
	mov ecx,0

	mov eax,[ebp+8]

	mov bx, ax

	push ebx
	call esPositivo
	add esp,4

	mov edx,ebx
	shr eax,16

	mov ebx,0
	mov bx, ax

	push ebx
	call esPositivo
	add esp,4

	leave 
	ret

;--------------------------------------------------
;Subrutina privada que verifica si un 
;numero es positivo, en el caso de ser 
;negativo el numero se modifica ocupando 
;los 32 bits del registro.
;
; @params
;	ebp+8
; @return
; 	ebx (con el numero modificado en el caso de ser negativo)
;

esPositivo:
	enter 0,0

	mov ecx,0
	mov ecx,[ebp+8]
	shl cx,1
	jc negativo
	jmp positivo
	negativo:
		add ebx,11111111111111110000000000000000b
		jmp end

	positivo:
		jmp end

	end:
		leave
		ret

;--------------------------------------------------
;Subrutina que suma dos intervalos.
;
; @params
;	ebp+8  (limite inferior)
;	ebp+12 (limite superior)
;	ebp+16 (limite inferior)
;	ebp+20 (limite superior)
; @return
; 	eax = [limiteInferior,limiteSuperior] (suma)
;

addInterval:

	enter 0,0

	mov ebx, 0
	mov edx, 0
	mov eax, 0
	mov ecx, 0

	mov eax,[ebp+8]
	mov ebx,[ebp+12]
	mov ecx,[ebp+16]
	mov edx,[ebp+20]

	add eax,edx
	push eax
	add ebx,ecx

	push ebx
	call toInterval
	add esp,8

	leave
	ret

;--------------------------------------------------
;Subrutina que resta dos intervalos.
;
; @params
;	ebp+8  (limite inferior)
;	ebp+12 (limite superior)
;	ebp+16 (limite inferior)
;	ebp+20 (limite superior)
; @return
; 	eax = [limiteInferior,limiteSuperior] (resta)
;

subInterval: 
	enter 0,0

	mov ebx, 0
	mov edx, 0
	mov eax, 0
	mov ecx, 0

	mov eax,[ebp+8]
	mov ebx,[ebp+12]
	mov ecx,[ebp+16]
	mov edx,[ebp+20]

	sub ebx,edx
	push ebx
	sub eax,ecx

	push eax
	call toInterval
	add esp,8

	leave
	ret

;--------------------------------------------------
;Subrutina que multiplica dos intervalos.
;
; @params
;	ebp+8  (limite inferior)
;	ebp+12 (limite superior)
;	ebp+16 (limite inferior)
;	ebp+20 (limite superior)
; @return
; 	eax = [limiteInferior,limiteSuperior] (multiplicacion)
;

mulInterval:
	enter 0,0

	mov ebx, 0
	mov edx, 0
	mov eax, 0
	mov ecx, 0

	mov eax,[ebp+8]
	mov ebx,[ebp+12]
	mov ecx,[ebp+16]
	mov edx,[ebp+20]

	imul edx,ebx  ;-2 * 9

	push edx
	mov edx,[ebp+20]

	imul ecx, ebx ;3 * 9

	push ecx
	mov ecx,[ebp+16]

	imul edx, eax ;-2 * -4

	push edx
	mov edx,[ebp+20]

	imul ecx,eax  ;3*4

	push ecx

	call maxArray
	mov edi, eax

	call minArray

	add esp,16

	push edi
	push eax
	call toInterval
	add esp, 8

	leave
	ret

;--------------------------------------------------
;Subrutina que calcula el infimo entre dos intervalos.
;
; @params
;	ebp+8  (limite inferior)
;	ebp+12 (limite superior)
;	ebp+16 (limite inferior)
;	ebp+20 (limite superior)
; @return
; 	eax = [limiteInferior,limiteSuperior] (infimo)
;

infInterval:
	enter 0,0

	mov ebx, 0
	mov edx, 0
	mov eax, 0
	mov ecx, 0

	mov ebx,[ebp+12]
	mov edx,[ebp+20]

	push ebx
	push edx
	call calcMin
	add esp,8

	mov ebx,eax

	mov eax,[ebp+8]
	mov ecx,[ebp+16]
	
	push eax
	push ecx 
	call calcMax
	add esp,8

	push ebx
	push eax
	call toInterval
	add esp,8
	
	leave
	ret

;--------------------------------------------------
;Subrutina que calcula el supremo entre dos intervalos.
;
; @params
;	ebp+8  (limite inferior)
;	ebp+12 (limite superior)
;	ebp+16 (limite inferior)
;	ebp+20 (limite superior)
; @return
; 	eax = [limiteInferior,limiteSuperior] (supremo)
;

supInterval:
	enter 0,0

	mov ebx, 0
	mov edx, 0
	mov eax, 0
	mov ecx, 0

	mov ebx,[ebp+12]
	mov edx,[ebp+20]

	push ebx
	push edx
	call calcMax
	add esp,8

	mov ebx,eax

	mov eax,[ebp+8]
	mov ecx,[ebp+16]
	
	push eax
	push ecx 
	call calcMin
	add esp,8

	push ebx
	push eax
	call toInterval
	add esp,8
	
	leave
	ret

;--------------------------------------------------
;Subrutina privada que calcula el 
;maximo entre 4 numeros (resultados
;de las multiplicaciones) pasados como 
;parametros.
;
; @params
;	ebp+8  (num1)
;	ebp+12 (num2)
;	ebp+16 (num3)
;	ebp+20 (num4)
; @return
; 	eax = numero maximo
;


maxArray:
	enter 0,0

	mov eax, 0
	mov ecx, 0
	mov eax, [ebp+8]
	mov esi, 0
	add esi,12
	while_loop_max:
		cmp ecx,5
		jge end_loop_max      ;salto por mayor-igual (>)
		mov edx,[ebp+esi]
		push eax          ;Apilo eax
		push edx          ;Apilo edx
		call calcMax      ;en eax voy a obtener el mayor
		add esp,8         ;Desapilo
		inc esi           ;Avanzo en el arreglo
		inc esi
		inc ecx           ;Incremento el indice
		jmp while_loop_max    ;vuelvo a la etiqueda del ciclo while

	end_loop_max:
		leave
		ret

;--------------------------------------------------
;Subrutina privada que calcula el 
;minimo entre 4 numeros (resultados
;de las multiplicaciones) pasados como 
;parametros.
;
; @params
;	ebp+8  (num1)
;	ebp+12 (num2)
;	ebp+16 (num3)
;	ebp+20 (num4)
; @return
; 	eax = numero minimo
;

minArray:
	enter 0,0

	mov eax, 0
	mov ecx, 0
	mov eax, [ebp+8]
	mov esi, 0
	add esi,12
	while_loop_min:
		cmp ecx,3
		jge end_loop_min      ;salto por mayor-igual (>)
		mov edx,[ebp+esi]
		push eax          ;Apilo eax
		push edx          ;Apilo edx
		call calcMin      ;en eax voy a obtener el mayor
		add esp,8        ;Desapilo
		inc esi           ;Avanzo en el arreglo
		inc esi
		inc esi
		inc esi
		inc ecx           ;Incremento el indice
		jmp while_loop_min    ;vuelvo a la etiqueda del ciclo while

	end_loop_min:
		leave
		ret

;--------------------------------------------------
;Subrutina privada que calcula el 
;maximo entre 2 numeros pasados como 
;parametros.
;
; @params
;	ebp+8  (num1)
;	ebp+12 (num2)
; @return
; 	eax = numero maximo
;

calcMax:
	enter 0, 0

	mov eax, 0

	mov eax,[ebp+8]   ;A eax le doy el valor del primer parametro

	cmp ax,[ebp+12]
	jge mayorIzq      ;ES MAYOR EAX
	jmp mayorDerecha  ; ES MAYOR EBX

	mayorDerecha:
			mov eax, 0
			mov eax,[ebp+12]
			jmp end_max

	mayorIzq:
		;El mayor ya se encuentra en eax
		jmp end_max       ; Solo por convencion salto al final luego de cada "metodo".	
	end_max:
		mov esp,ebp
		pop ebp
		ret

;--------------------------------------------------
;Subrutina privada que calcula el 
;minimo entre 2 numeros pasados como 
;parametros.
;
; @params
;	ebp+8  (num1)
;	ebp+12 (num2)
; @return
; 	eax = numero minimo
;

calcMin:
	enter 0, 0

	mov eax, 0

	mov eax,[ebp+8]   ;A eax le doy el valor del primer parametro

	cmp eax,[ebp+12]
	jle menorIzq      ;ES MAYOR EAX
	jmp menorDerecha  ; ES MAYOR EBX

	menorDerecha:
			mov eax, 0
			mov eax,[ebp+12]
			jmp end_min

	menorIzq:
		;El mayor ya se encuentra en eax
		jmp end_min       ; Solo por convencion salto al final luego de cada "metodo".	
	end_min:
		mov esp,ebp
		pop ebp
		ret