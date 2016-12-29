`timescale 1ns / 1ps
module TB_open;
	// Inputs to module being verified
	reg clk5, newkey, reset;
	reg [4:0] keycode;
	reg [2:0] whichState;
	// Outputs from module being verified
	wire open;
	// Instantiate module
	open uut (
		.clk5(clk5),
		.keycode(keycode),
		.newkey(newkey),
		.whichState(whichState),
		.reset(reset),
		.open(open)
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
			whichState = 3'b0;
			reset = 1'b0;
			#50
			reset = 1'b1;
			#500
			reset = 1'b0;
			#100
			keycode = 5'b10001;
			newkey = 1'b1;
			whichState = 3'b001;
			#200
			newkey = 1'b0;
			#1700
			keycode = 5'b10010;
			newkey = 1'b1;
			whichState = 3'b010;
			#200
			newkey = 1'b0;
			#1400
			keycode = 5'b11001;
			newkey = 1'b1;
			whichState = 3'b011;
			#200
			newkey = 1'b0;
			#1400
			keycode = 5'b10110;
			newkey = 1'b1;
			whichState = 3'b100;
			#200
			newkey = 1'b0;
			
			#200
                        keycode = 5'b10001;
                        newkey = 1'b1;
                        whichState = 3'b001;
                        #200
                        newkey = 1'b0;
                        #1700
                        keycode = 5'b10010;
                        newkey = 1'b1;
                        whichState = 3'b010;
                        #200
                        newkey = 1'b0;
                        #1400
                        keycode = 5'b11001;
                        newkey = 1'b1;
                        whichState = 3'b011;
                        #200
                        newkey = 1'b0;
                        #1400
                        keycode = 5'b10110;
                        newkey = 1'b1;
                        whichState = 3'b100;
                        #200
                        newkey = 1'b0;
			#6050
			$stop;
		end
endmodule
