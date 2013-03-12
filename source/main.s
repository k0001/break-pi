.section .init
.globl _start
_start:
    b main

.section .text
main:
    mov sp,#0x8000

    /* Ready GPIO pin 16 (led) for output */
    mov r0,#16
    mov r1,#1
    bl SetGpioFunction
    /* Blink pattern setup */
    ptrn .req r4
    ldr ptrn,=pattern
    ldr ptrn,[ptrn]
    seq .req r5
    mov seq,#0
loop$:
    /* Toggle led according to the given pattern */
    mov r0,#16
    mov r1,#1
    lsl r1,seq
    and r1,ptrn
    bl SetGpio
    /* Wait 0.5 second */
    ldr r0,=250000
    bl Wait
    /* Update pattern position */
    add seq,#1
    and seq,#0b11111
    b loop$


.section .data
.align 2
pattern:
    .int 0b11111111101010100010001000101010
