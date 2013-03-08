.section .init
.globl _start
_start:
    b main

.section .text
main:
    mov sp,#0x800

    # Ready GPIO pin 16 (led) for output
    pinNum .req r0
    pinFunc .req r1
    mov pinNum,#16
    mov pinFunc,#1
    bl SetGpioFunction
    .unreq pinNum
    .unreq pinFunc

blink_led_loop$:
    # Turn on led
    pinNum .req r0
    pinVal .req r1
    mov pinNum,#16
    mov pinVal,#0
    bl SetGpio
    .unreq pinNum
    .unreq pinVal

    # Waste time
    mov r2,#0x3f0000
    wait$:
        sub r2,#1
        cmp r2,#0
        bne wait$

    # Turn off led
    pinNum .req r0
    pinVal .req r1
    mov pinNum,#16
    mov pinVal,#1
    bl SetGpio
    .unreq pinNum
    .unreq pinVal

    b blink_led_loop$

