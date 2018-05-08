/*
Raúl Monzon y Carlos Chew
Organizacion de computadoras y Assembler
Seccion 20
main (muestra un número que ingresa el usuario en binario utilizando leds)
utiliza la biblioteca gpio0_2.s extraída de canvas
*/ 

.text
.align 2
.global main


main:
	/*
	Se utiliza la biblioteca anteriormente mencionada
	*/
	bl GetGpioAddress 
		
	@GPIO para escritura puerto 16
	mov r0,#16
	mov r1,#1
	bl SetGpioFunction

	@GPIO para escritura puerto 20
	mov r0,#20
	mov r1,#1
	bl SetGpioFunction

	@GPIO para escritura puerto 21
	mov r0,#21
	mov r1,#1
	bl SetGpioFunction


/*
Etiqueta/ciclo del programa
*/
programa:
	/*
	Muestra las opciones que puede realizar
	*/
	ldr r0,=mensajeMenu
	bl puts

	/*
	Guarda lo que desea el usuario
	*/
	ldr r0,=entrada
	ldr r1,=opcion
	bl scanf

	cmp r1, #1
	
	/*
	Termina el programa si ingresa 2
	*/
	bne fin

	/*
	Solicita nuevo número
	*/
	ldr r0,=mensajeNumero
	bl puts

	/*
	Recibe el numero
	*/
	ldr r0,=entrada
	ldr r1,=numero
	bl scanf

	/*
	guardamos numero en r1 
	*/
	ldr r0,=numero
	ldr r1,[r0]	


	/*
	Utilizamos subrutina
	*/
	bl encenderLeds

	/*
	Utilizamos subrutina
	*/
	b programa	

fin:

	/*
	GPIO 16 apaga el led
	*/
	mov r0,#16
	mov r1,#0
	bl SetGpio

	/*
	GPIO 20 apaga el led
	*/ 
	mov r0,#20
	mov r1,#0
	bl SetGpio

	/*
	GPIO 21 apaga el led
	*/
	mov r0,#21
	mov r1,#0
	bl SetGpio


	@Salida del Programa
	mov r7,#1
	swi 0
	                                                                                                                                                                                                                                                                           

/*
Rutina para hacer pausa
*/
wait:
 mov r0, #0x4000000 @ big number

/*
Rutina para hacer pausa
*/
sleepLoop:
 subs r0,#1
 bne sleepLoop @ loop delay
 mov pc,lr

.data
.align 2

opcion:
	.word 0

numero:
	.word 0

entrada:
	.asciz "%d"

formato:
	.asciz "%d\n"

mensajeMenu:
	.asciz "1. Nuevo numero 2. Salir"

mensajeNumero:
	.asciz "Ingrese numero: \n"

.global myloc
myloc: 
	.word 0

.end

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        