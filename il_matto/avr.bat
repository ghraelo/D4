avr-gcc -mmcu=atmega644p -DF_CPU=12000000 -Wall -Os %1.c -o %1.elf -Wl,-u,vfprintf -lprintf_flt -lm
@echo off
if %errorlevel% GEQ 1 goto error
:okay
@echo on
avr-objcopy -O ihex %1.elf %1.hex
avrdude -c usbasp -p m644p -U flash:w:%1.hex
@echo off
goto end
:error
echo Error
:end