# RTOS

This is the beginnings of a new RTOS for Raspberry Pi B hardware, *e.g.*,
the Raspberry Pi 3 Model B &mdash; the current version.

It is a bootable OS kernel in 160 bytes on bare metal. It boots much faster
than Linux.

It has been tested on a Raspberry Pi 3 Model B; it should run on a Compute
Module 3 or 3 lite, or a Pi Zero, but has not been tested there.

The project was started by Ryan Loughry, a student at Grandview High School
in Aurora, Colorado. There were two parallel implementations of the new
RTOS; this is mine.

For more information, contact [Joe Loughry](mailto:joe.loughry@gmail.com).

## How to Build:

`make`

You'll need an assembler for the ARM architecture; install the [GNU Embedded
Toolchain for
ARM](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads);
there are Windows, Linux, and Mac OS X versions. As long as you can run the
assembler as `arm-none-eabi-as` then you're good.

Once you've got the actual `kernel.img` file, copy it to the root of a
Linux-formatted micro-SD card that already has the Raspbian OS on it, or
renamed `recovery.img` on the root of a FAT-formatted micro-SD card. Either
way, it'll boot when the Raspberry Pi is next powered on.

The only way to know this kernel is running is to watch an LED conneced to
GPIO pin BCM 16 on J8 through a small resistor to ground. The LED will
flash at a rate of 1 Hz.

## Technical Notes:

The base address for the Raspberry Pi 3b is 0x3F000000, changed from
0x20000000 on the original Raspberry Pi.

When referring to GPIO pins, use the "BCM" pin numbering scheme, not the
other various ways of numbering Raspberry Pi GPIO pins on the J8 header.

For testing, connect an LED through a resistor of approximately 100 to 400
ohms between the GPIO pin and a ground pin (if the LED doesn't light up,
turn it around).

There's no real scheduler yet, just round robin, and only one task; it uses
a busy-wait for timing. But the hard part was getting anything at all to boot
on the Raspberry Pi 3 hardware; after that, the rest (interrupts, timing,
priority scheduler, I/O) is, in comparison, easy.

