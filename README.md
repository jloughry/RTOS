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

## Technical Notes:

The base address for the Raspberry Pi 3b is 0x3F000000, changed from
0x20000000 on the original Raspberry Pi.

When referring to GPIO pins, use the "BCM" pin numbering scheme, not the
other various ways of numbering Raspberry Pi GPIO pins on the J8 header.

For testing, connect an LED through a resistor of approximately 100 to 400
ohms between the GPIO pin and a ground pin (if the LED doesn't light up,
turn it around).

