`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// 
// Create Date: 24.11.2016 12:52:48
// Module Name: timeCounter 
// Description: count up to one second in either the correct code or wrong code states
//////////////////////////////////////////////////////////////////////////////////


module timeCounter(
    input clk5,
    input reset,
    input [2:0] whichState,
    output timeUp
    );
    
        localparam CORRECT_CODE = 3'b101;    // fifth state in state machine
        localparam WRONG_CODE = 3'b110;      // sixth state in state machine
        
        reg [22:0]count;
        wire [22:0]nextCount;
        
        always @(posedge clk5 or posedge reset)
        begin 
            if(reset)
                count = 1'b0;
            else
                count = nextCount;
        end
        
        assign nextCount = ((whichState == CORRECT_CODE) || (whichState == WRONG_CODE)) ? count + 1'b1 : 1'b0;    // only count up in correct or wrong states. count will be ready to re-start at 0 for next time state machine is in either of these states. 
        assign timeUp = (count == 23'd4999999);                                  // 1s has passed after 5M clock cycles
    
endmodule
