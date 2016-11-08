/* *****************************************************************
*   						modulo.s
*						
*					Julio Barahona 	141206
*					Diego Lopez 	141222
*					Oscar Lopez		
******************************************************************** */


#sub rutina que se usa para terminar de imprimir cualquier imagen
/*
* r0 	Direccion de memoria a la matriz
* r1 	X 
* r2 	Y 
* r3	Ancho
* r4 	Alto de la matriz
*/
.global printImage
printImage:
	mov r5, r4
	mov r4, r3
	mov r6, r0
	push {lr}
	
	x 		.req r1
	y 		.req r2
	ancho 		.req r4
	colour 		.req r3
	matriz 		.req r6
	alto 		.req r5
	numpixel 	.req r7
	
	#suma desplazo a coordenadas iniciales
	add r4,r1
	add r5,r2


	mov numpixel, #0
	mov r8, x

	pintar_fila:
		mov x, r8
		pintar_pixel:
			cmp x, ancho
			bge pintarColumna
			ldrh colour, [matriz, numpixel]
			ldr r0, =pixelAddr
			ldr r0, [r0]
			push {r0-r12}
			bl pixel
			pop {r0-r12}
			add numpixel, #1
			add x, #1
			b pintar_pixel

	pintarColumna:
		add y, #1
		teq y, alto
		bne pintar_fila

		.unreq x
		.unreq numpixel
		.unreq y
		.unreq ancho
		.unreq colour
		.unreq alto
		.unreq matriz
		

	pop {pc}	  

# Carga los datos de la bienvenida y llama a la funcion printImage a ejecucion	
.global printBienvenida
printBackground:
	push {lr}
		ldr r0, =Bienvenida
		mov r1, #0
		mov r2, #0
		ldr r3, =BienvenidaWidth
		ldr r3, [r3]
		ldr r4, =BienvenidaHeight
		ldr r4, [r4]
		bl printImage
	pop {pc}

	
.global getgpio
getgpio:
	#copia de r0 en r4, verficar que el numero sea valido
	mov r4,r0
	movgt pc,lr
	
	push {lr}
		#asignacion en registro al vector myloc (es global)
		ldr r6, =myloc
		ldr r0, [r6]
		
		#direcion donde esta el bit
		ldr r5,[r0,#0x34]
		
		# 1 va a r7
		mov r7,#1
		#corrimineto de bits
		lsl r7,r4
		#cmp logico
		and r5,r7
		
		#asignacion de valores 
		# 0 --> no presionado
		# 1 -->    presionado
		teq r5,#0
		movne r0,#1
		moveq r0,#0
		
	pop {pc}
	
.global getGpio
getGpio:
	# se hace copia de el registro en r4  para tener referencia 
	mov r4,r0

    # si mira que el numero se menor que 31, 
	# 31 es el maximo de puertos en raspberry 2 
	cmp r4,#31
	movgt pc,lr

	push {lr}

		# @bl GetGpioAddress no se llama la funcion sino a la variable global myloc
		ldr r6, =myloc
	 	ldr r0, [r6] @ obtener direccion )xf3200000

		@@  se mueve a la direccion 0xf3200034 donde esta el bit que indica el estado
	    	ldr r5,[r0,#0x34]
	    	@ carga valor de 1 en r0
		mov r7,#1
		@ hace un movimiento de bit segun el puerto que se indico anteriormente.
		lsl r7,r4

		and r5,r7 

		@Si el boton esta en alto coloca 1 en r0, sino 0 en r0
		teq r5,#0
		movne r0,#1
		moveq r0,#0

	pop {pc}

.global delay
delay:
	push {lr}
		#da la impresion de que el movimiento es tardado
		ldr r0, =cantidadDelay
		ldr r0, [r0]
		bandera:
			subs r0, #1
		bne bandera
	pop {pc}

#---------- AREA DE DATOS ----------#
.data
.global pixelAddr
pixelAddr: 
	.word 0

.global myloc
myloc: 
	.word 0

.global cantidadDelay
cantidadDelay:
	.word 597000000
