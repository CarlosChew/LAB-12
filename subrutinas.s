/* 
RAUL MONZON
CARLOS CHEW
*/ 

.data
.align 2

cadenaNombre:   .asciz  "                                               "
cadenaNombre2:  .asciz  "                                               "

.text
.align 2

/*
SUBRUTINA
SE CREAN LOS FORMATOS Y PARAMETROS
DE IGUAL FORMA SE GUARDA LA DIRECCION Y LARGO (R0 A R3)
*/


.global formaNombre
formaNombre:
    push {r4-r12, lr}

    ldr r5, =cadenaNombre

    nombre      .req r0
    largoNombre .req r1
    apellido    .req r2
    largoApellido .req r3
    
    contador .req r6

/* APELLIDO
*/
    mov contador, #0
cicloApellido:
    ldrb r7, [apellido, contador] @ cargamos con ldrb porque un ascii ocupa 1 byte
    strb r7, [r5]       @ guardamos con strb por la misma razon
    add contador, #1    @ movemos el puntero de cadena
    add r5, #1
    cmp contador, largoApellido
    blt cicloApellido

 
    mov r7, #','
    strb r7, [r5]
    add r5, #1
    mov r7, #' '
    strb r7, [r5]
    add r5, #1

/* NOMBRE
*/
    mov contador, #0
cicloNombre:
    ldrb r7, [nombre, contador]
    strb r7, [r5]

    add r5, #1
    add contador, #1
    cmp contador, largoNombre
    blt cicloNombre

/* FIN
*/
    mov r7, #0
    strb r7, [r5]
    add r5, #1

    .unreq contador
    .unreq nombre
    .unreq largoNombre
    .unreq apellido
    .unreq largoApellido


    ldr r0, =cadenaNombre

    pop {r4-r12, pc}






/* SUBRUTINA CON REGISTROS 
*/
.global formaNombre2
formaNombre2:
    push {r4-r12, lr}

    ldr r5, =cadenaNombre2

    nombre    .req r0
    apellido  .req r1
    
    contador .req r6

/* APELLIDO
*/
    mov contador, #0
cicloApellido2:
    ldrb r7, [apellido, contador]

    cmp r7, #0
    beq continuar1
    strb r7, [r5]
    add contador, #1
    add r5, #1
    b cicloApellido2
    
continuar1:

    mov r7, #','
    strb r7, [r5]
    add r5, #1
    mov r7, #' '
    strb r7, [r5]
    add r5, #1


    mov contador, #0
cicloNombre2:
    ldrb r7, [nombre, contador]
    cmp r7, #0
    beq continuar2
    strb r7, [r5]
    add r5, #1
    add contador, #1
    b cicloNombre2

continuar2:

    mov r7, #0
    strb r7, [r5]
    add r5, #1

    .unreq contador
    .unreq nombre
    .unreq apellido

    ldr r0, =cadenaNombre2

    pop {r4-r12, pc}
