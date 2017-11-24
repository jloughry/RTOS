    @ rtos.s
    @ Version 20170423.1555
    @ Compile it this way:
    @
    @ arm-none-eabi-as vectors.s -o vectors.o
    @ arm-none-eabi-as rtos.s -o rtos.o
    @ arm-none-eabi-ld vectors.o rtos.o -T memmap -o rtos.elf
    @ arm-none-eabi-objcopy rtos.elf -O binary rtos.bin
    @
    @ And then rename rtos.bin to kernel7.img on the Raspberry Pi's
    @ micro-SD card (or recovery7.img for use on a FAT-formatted SD card)
    @
    @ Target hardware: Raspberry Pi Model 3b with an LED on BCM 16
    @ (pin 36 of the J8 header) to ground through a resistor. For
    @ more information see the Makefile at
    @ https://github.com/dwelch67/raspberrypi/blob/master/blinker01/
    
    .cpu arm7tdmi

    .eabi_attribute 20, 1   @ FP_denormal
    .eabi_attribute 21, 1   @ FP_exceptions
    .eabi_attribute 23, 3   @ FP_number_model 3
    .eabi_attribute 24, 1   @ align8_needed
    .eabi_attribute 25, 1   @ align8_preserved
    .eabi_attribute 26, 1   @ short enums
    .eabi_attribute 30, 2   @ optimisation goals 2
    .eabi_attribute 34, 0   @ no unaligned access
    .eabi_attribute 18, 4   @ PCS_wchar_t 4
    .text
    .align 2
    .global notmain
    .syntax unified
    .arm
    .fpu softvfp
    .type notmain, %function
notmain:
    @ Analogous to main() in C but with less overhead.
    push    {r4, r5, r6, r7, r8, lr}
    ldr     r0, .base_addr
    bl      GET32   @ external function
    bic     r1, r0, #1835008    @ 7<<18
    orr     r1, r1, #262144     @ 1<<18
    ldr     r0, .base_addr
    bl      PUT32   @ external function
    mov     r5, #65536          @ 1<<16
    ldr     r7, .gpio_set
    ldr     r6, .gpio_clear

.infinite_loop:    @ This is the beginning of an infinite loop.

    @ Tell the LED to turn on.
    mov     r1, r5
    mov     r0, r7
    bl      PUT32   @ control the GPIO

    @ This is a for loop; call dummy() about a million times.
    mov     r4, #0  @ This is the counter.
.delay1:
    mov     r0, r4          @ dummy() takes r0
    add     r4, r4, #1      @ This is the increment part.
    bl      dummy   @ dummy() is an external function.
    cmp     r4, #1048576    @ This is the compare part.
    bne     .delay1

    @ Tell the LED to turn off.
    mov     r1, r5
    mov     r0, r6
    bl      PUT32   @ control the GPIO

    @ This is a for loop; call dummy() about a million times.
    mov     r4, #0  @ This is the counter.
.delay2:
    mov     r0, r4          @ dummy() takes r0
    add     r4, r4, #1      @ This is the increment part.
    bl      dummy
    cmp     r4, #1048576    @ This is the compare part.
    bne     .delay2

    b       .infinite_loop     @ around and around we go

.data_area:
    .align   2
.base_addr:
    .word    1059061764
.gpio_set:
    .word    1059061788
.gpio_clear:
    .word    1059061800
    .size    notmain, .-notmain

