`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Module Name: TB_stateMachine
// Description: testbench to test the "control" state machine bloc
//////////////////////////////////////////////////////////////////////////////////

module TB_stateMachine;
	// Inputs to module being verified
	reg clk5, newkey, open, timeUp, reset;
	reg [4:0] keycode;
	// Outputs from module being verified
	wire [2:0] whichState;
	wire [5:0] led;
	// Instantiate module
	stateMachine uut (
		.clk5(clk5),
		.keycode(keycode),
		.newkey(newkey),
		.open(open),
		.timeUp(timeUp),
		.reset(reset),
		.whichState(whichState),
		.led(led)
		);
	// Generate clock signal
	initial
		begin
			clk5  = 1'b1;
			forever
				#100 clk5  = ~clk5 ;
		end
	// Generate other input signals
	initial
		begin
			keycode = 5'b0;
			newkey = 1'b0;
			open = 1'b0;
			timeUp = 1'b0;
			reset = 1'b0;
			#150
			reset = 1'b1;
			#400
			reset = 1'b0;
			#200
			newkey = 1'b1;
			#300
			newkey = 1'b0;
			#1400
			keycode = 5'b10010;
			newkey = 1'b1;
			#200
			newkey = 1'b0;
			#1600
			newkey = 1'b1;
			#200
			newkey = 1'b0;
			#1700
			keycode = 5'b10110;
			newkey = 1'b1;
			#300
			newkey = 1'b0;
			#100
			open = 1'b1;
			#300
			open = 1'b0;
			#2600
			timeUp = 1'b1;
			#400
			timeUp = 1'b0;
			#2150
			$stop;
		end
endmodule
