/*
 *	embedded_controller.c
 *
 * Adapted from skeleton code (embedded_coms_boost.c) by Steve Gunn & Klaus-Peter Zauner 
 * 
 *   Notes: 
 *          - Use with host_coms_boost.c
 *  
 *          - F_CPU must be defined to match the clock frequency
 *
 *          - Compile with the options to enable floating point
 *            numbers in printf(): 
 *               -Wl,-u,vfprintf -lprintf_flt -lm
 *
 *          - Pin assignment: 
 *            | Port | Pin | Use                         |
 *            |------+-----+-----------------------------|
 *            | A    | PA0 | Voltage at load             |
 *            | D    | PD0 | Host connection TX (orange) |
 *            | D    | PD1 | Host connection RX (yellow) |
 *            | D    | PD7 | PWM out to drive MOSFET     |
 */

#include <stdio.h>
#include <avr/io.h>
#include <util/delay.h>

#include "debug.h"

void init_spi_master(void);
void spi_tx(uint8_t b);
uint8_t spi_rx(void);

int main(void)
{      	
	init_debug_uart0();
	init_spi_master();
	PORTB |= _BV(4);
	
	while(1)
	{
		uint8_t ltr = 0;
		printf("Press s to initiate transmission: ");

		scanf("%c",&ltr);

		PORTB &= ~_BV(4);
		spi_tx(ltr);
		ltr = spi_rx();
		PORTB |= _BV(4);

		printf("\nReceived: %x\n\n",ltr);
	}
}

void init_spi_master(void) 
{ /* out: MOSI, SCK, /SS, in: MISO */
	DDRB = _BV(PB4) | _BV(PB5) | _BV(PB7);
	SPCR = _BV(SPE) | _BV(MSTR) | _BV(SPI2X); /* F_SCK = F_CPU/2 */
}

void spi_tx(uint8_t b)
{
	SPDR = b;
	while(!(SPSR & _BV(SPIF)));
}

uint8_t spi_rx(void) 
{
	while(!(SPSR & _BV(SPIF)));
	return SPDR;
}