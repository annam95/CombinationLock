`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 01.12.2016 14:02:51
// Module Name: combLockTop
// Description: Verification of the individual blocks we designed, control, timer, and checker
// 
//////////////////////////////////////////////////////////////////////////////////


module combLockTop(
    input clk5,
    input reset,
    input newkey,
    input [4:0] keycode,
    output [5:0] led,
	output open
    );
	
    wire [2:0] whichState1;
    
	timeCounter timer(
        .clk5(clk5),
        .reset(reset),
        .whichState(whichState1),
        .timeUp(timeUp)
        );
    
    stateMachine control(
        .keycode(keycode),
        .newkey(newkey),
        .open(open1),
        .timeUp(timeUp),
        .clk5(clk5),
        .reset(reset),
        .whichState(whichState1),
        .led(led)
        );
         
    open checker(
        .keycode(keycode),
        .whichState(whichState1),
        .clk5(clk5),
        .reset(reset),
        .open(open1)
        );
        
endmodule
