.globl GetSystemTimerBase
GetSystemTimerBase:
    ldr r0,=0x20003000
    mov pc,lr

.globl GetTimeStamp
GetTimeStamp:
    push {lr}
    bl GetSystemTimerBase
    ldrd r0,r1,[r0,#4]
    pop {pc}

.globl Wait
Wait:
    delay .req r2
    mov delay,r0
    push {lr}
    bl GetTimeStamp
    start .req r3
    mov start,r0
    loop1$:
        bl GetTimeStamp
        sub r0,start
        cmp r0,delay
        bls loop1$
    .unreq delay
    .unreq start
    pop {pc}

