`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 01.12.2016 14:02:51
// Module Name: Toplock
// Description: Top-level module to implement entire design in hardware
// 
//////////////////////////////////////////////////////////////////////////////////

module TopLock(
    input clk100,
    input rstPBn,
    input [5:0] kpcol,
    output [3:0] kprow,
    output [5:0] led
	output unlock
);
    wire [2:0] whichState1;
    wire [4:0] keycode;
 
clockReset clkRst(
    .clk100(clk100),           // 100 MHz input clock
    .rstPBn(rstPBn),           // input from reset pushbutton, active low
    .clk5(clk5),               // 5 MHz output clock, used by rest of the blocks in design
    .reset(reset)              // reset output for rest of blocks, active high
    );

combLockTop top3(
    .clk5(clk5),
    .reset(reset),
    .newkey(newkey),
    .keycode(keycode),
    .led(led)
	.open(open1)
    );
	
keypad keyPad(
    .clk(clk5),					
    .rst(reset),					
    .kpcol(kpcol),			    // inputs from keypad columns, 0 on right
    .kprow(kprow), 	            // outputs to drive keyad rows, 0 on top
    .newkey(newkey),				// high for one cycle for each new keypress
    .keycode(keycode)
    );
    assign unlock = open1;
    
endmodule