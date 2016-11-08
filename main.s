/* *****************************************************************
*   						main.s
*						
*					Julio Barahona 	141206
*					Diego Lopez 	141222
*					Oscar Lopez		
******************************************************************** */

 .text
 .align 2

 .global main
main:
	
	
	bl getScreenAddr
	ldr r1,=pixelAddr
	str r0,[r1]

	ciclo:

				
		bl printBienvenida		
		# Da tiempo para que las instruccione puedan ser leidas
		bl delay
		
	b ciclo

 
		
#-----------------------------------------------------------------------------#	
#				   Fin de programa			      #
#-----------------------------------------------------------------------------#	
end:
    mov r7,#1
    swi 0

#-----------------------------------------------------------------------------#	
#				   AREA DE DATOS			      #
#-----------------------------------------------------------------------------#
.data

.global vectorsName
vectorsName:
	.word 10
