# This makes a bootable kernel for a Raspberry Pi 3 Model B.

bootable_kernel: kernel7.img

ARCH = arm-none-eabi

vectors.o: vectors.s
	$(ARCH)-as vectors.s -o vectors.o

rtos.o: rtos.s
	$(ARCH)-as rtos.s -o rtos.o

rtos.elf: rtos.o vectors.o memmap
	$(ARCH)-ld vectors.o rtos.o -T memmap -o rtos.elf

rtos.bin: rtos.elf
	$(ARCH)-objcopy rtos.elf -O binary rtos.bin

kernel7.img: rtos.bin
	cp rtos.bin kernel7.img

clean:
	rm -fv *.o *.bin *.elf *.img

