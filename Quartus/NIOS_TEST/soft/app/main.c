#include <unistd.h> // for usleep

#include "system.h"
#include "altera_avalon_pio_regs.h"

#include <stdio.h>

int main (void)
{
	while(1){
        IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE,0);
        usleep(1 usec);
        IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE,1);
        usleep(1 usec)
}