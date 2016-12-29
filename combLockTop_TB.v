`timescale 1ns / 1ps
module TB_combLockTop;
	// Inputs to module being verified
	reg clk5, reset, newkey;
	reg [4:0] keycode;
	// Outputs from module being verified
	wire [5:0] led;
	// Instantiate module
	combLockTop uut (
		.clk5(clk5),
		.reset(reset),
		.newkey(newkey),
		.keycode(keycode),
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
			reset = 1'b0;
			newkey = 1'b0;
			keycode = 5'b0;
			#150
			reset = 1'b1;
			#200
			reset = 1'b0;
			#400
			newkey = 1'b1;
			keycode = 5'b10001;
			#200
			newkey = 1'b0;
			#1600
			newkey = 1'b1;
			keycode = 5'b10010;
			#200
			newkey = 1'b0;
			#1500
			newkey = 1'b1;
			keycode = 5'b11001;
			#200
			newkey = 1'b0;
			#1400
			newkey = 1'b1;
			keycode = 5'b10110;
			#200
			newkey = 1'b0;
			#5950
			
			#400
                        newkey = 1'b1;
                        keycode = 5'b10001;
                        #200
                        newkey = 1'b0;
                        #1600
                        newkey = 1'b1;
                        keycode = 5'b10010;
                        #200
                        newkey = 1'b0;
                        #1500
                        newkey = 1'b1;
                        keycode = 5'b11001;
                        #200
                        newkey = 1'b0;
                        #1400
                        newkey = 1'b1;
                        keycode = 5'b10110;
                        #200
                        newkey = 1'b0;
                        #5950
			$stop;
		end
endmodule
