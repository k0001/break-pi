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

    /* Waste time: decrement the number 0x3f0000 to 0 */
    decr .req r0
    mov decr,#0x3F0000
    wait1$:
        sub decr,#1
        teq decr,#0
        bne wait1$
    .unreq decr


    /* Turn off led by setting the pin HIGH */
    pinNum .req r0
    pinVal .req r1
    mov pinNum,#16
    mov pinVal,#1
    bl SetGpio
    .unreq pinNum
    .unreq pinVal

    /* Waste more time: decrement the number 0x3f0000 to 0 */
    decr .req r0
    mov decr,#0x3F0000
    wait2$:
        sub decr,#1
        teq decr,#0
        bne wait2$
    .unreq decr

    b blink_led_loop$

