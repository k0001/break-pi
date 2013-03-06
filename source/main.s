.section .init
.globl _start

_start:
    # GPIO controller address
    ldr r0,=0x20200000
    # Ready GPIO pin 16 (led) for output
    mov r1,#1
    lsl r1,#18
    str r1,[r0,#4]
    # Turn off GPIO pin 16, which will *turn on* the led. Blame the manufacturer
    mov r1,#1
    lsl r1,#16
    str r1,[r0,#40]

loop$:
    b loop$


