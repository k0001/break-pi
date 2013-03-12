.section .init
.globl _start
_start:
    b main

.section .text
main:
    mov sp,#0x800

    /* Ready GPIO pin 16 (led) for output */
    pinNum .req r0
    pinFunc .req r1
    mov pinNum,#16
    mov pinFunc,#1
    bl SetGpioFunction
    .unreq pinNum
    .unreq pinFunc

blink_led_loop$:
    /* Turn on led by setting the pin LOW */
    pinNum .req r0
    pinVal .req r1
    mov pinNum,#16
    mov pinVal,#0
    bl SetGpio
    .unreq pinNum
    .unreq pinVal

    /* Wait 1 second */
    ldr r0,=1000000
    bl Wait

    /* Turn off led by setting the pin HIGH */
    pinNum .req r0
    pinVal .req r1
    mov pinNum,#16
    mov pinVal,#1
    bl SetGpio
    .unreq pinNum
    .unreq pinVal

    /* Wait 0.5 second */
    ldr r0,=500000
    bl Wait

    b blink_led_loop$

