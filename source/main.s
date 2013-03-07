.section .init
.globl _start

_start:
    # GPIO controller address
    ldr r0,=0x20200000

    # Ready GPIO pin 16 (led) for output
    mov r1,#1
    lsl r1,#18
    str r1,[r0,#4]

blink_led_loop$:
    # Turn off GPIO pin 16, which will *turn on* the led. Blame the manufacturer
    mov r1,#1
    lsl r1,#16
    str r1,[r0,#40]

    # Waste time
    mov r2,#0x3f0000
wait1$:
    sub r2,#1
    cmp r2,#0
    bne wait1$

    # Turn on GPIO pin 16, which will *turn off* the led. Blame the manufacturer
    str r1,[r0,#28]

    b blink_led_loop$

