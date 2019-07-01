/*
 * my_test.c
 *
 *  Created on: April 29, 2019
 *      Author: madeanda
 */

/* You will utilize two, 32-bit memory-mapped registers, Reg0 and Reg1, to pass data between the two domains.
 * Writing to Reg0 will load n into the register, clear Reg1, and initiate a handshake with the factorial module.
 * When the computation is complete, the factorial module will load the result into Reg1 where it can be read by the CPU
 */

#include "myip.h"
#include "xparameters.h"
#include "xil_printf.h"
#include "xil_io.h"

/* 	Define the base memory address of the AXI slave IP core */
#define MYIP_BASE XPAR_MYIP_0_S00_AXI_BASEADDR

int main(void){

	u32 reg0, reg1; // for holding register values

	int i;

	xil_printf("Factorial Co-processor test begins.\r\n");

	                i = 12;

	                MYIP_mWriteReg(MYIP_BASE, 0, i);  // load n

					reg0 = MYIP_mReadReg(MYIP_BASE, 0);

					reg1 = MYIP_mReadReg(MYIP_BASE, 4);  //register should be cleared

					xil_printf("Wrote Register 0\r\n");

					while(!MYIP_mReadReg(MYIP_BASE, 4));

					xil_printf("The factorial of %d is equal to %d\r\n", reg0, reg1);

	return 1;

} // end my_test

