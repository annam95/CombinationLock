`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 24.11.2016 12:52:48 
// Module Name: stateMachine
// Description: keep track of how many keys have been pressed, and indicate to outside world what is happening
//
//////////////////////////////////////////////////////////////////////////////////


module stateMachine(
    input [4:0] keycode,
    input newkey,
    input open,
    input timeUp,
    input clk5,
    input reset,
    output [2:0] whichState,
    output reg [5:0] led
    );
    
    
        localparam IDLE = 3'b000;
        localparam FIRST_KEY = 3'b001;
        localparam SECOND_KEY = 3'b010;
        localparam THIRD_KEY = 3'b011;
        localparam FOURTH_KEY = 3'b100;
        localparam CORRECT_CODE = 3'b101;
        localparam WRONG_CODE = 3'b110;
        localparam WAIT =3'b111;
        localparam CLEAR = 5'b11100;
        
        reg [2:0]currentState;
        reg [2:0]nextState;

        assign whichState = currentState;
        
        always @ (posedge clk5 or posedge reset)    // asynchronous reset
        begin
            if (reset)
                currentState <= IDLE;
            else
                currentState <= nextState;
        end
        
        always @ (currentState,keycode,newkey,timeUp,open)
        begin
            nextState = currentState;          // default, most of the time no key is pressed
            if (keycode == CLEAR)              // allows person to go back to idle state from any state by pressing 'C' on the keypad
             begin   nextState = IDLE;
                led[5:0] = 6'b000000;
                end
            else
            begin
            case(currentState)
                IDLE:                          // only condition to move to next state is that a key has been pressed, this is the same for the next three states
                begin
                    led[5:0] = 6'b000000;
                    if(newkey)
                        nextState = FIRST_KEY;
                end
                FIRST_KEY:
                begin
                    led[5:0] = 6'b000001;
                    if(newkey)
                        nextState = SECOND_KEY;
                end
                SECOND_KEY:
                begin
                    led[5:0] = 6'b000011;        
                    if(newkey)
                        nextState = THIRD_KEY;
                end
                THIRD_KEY:
                begin
                    led[5:0] = 6'b000111;
                    if(newkey)
                        nextState = FOURTH_KEY;
                end
                FOURTH_KEY:                    // automatically enter WAIT state on next clock cycle
                begin
                    led[5:0] = 6'b001111;
                    nextState = WAIT;
                end
                WAIT:                          // this is where the check condition for open signal from checker block occurs
                begin
                    led[5:0] = 6'b001111;
                    if (open)    
                        nextState = CORRECT_CODE;
                    else
                        nextState = WRONG_CODE;
                end
                CORRECT_CODE:                 // indicate that correct code has been entered, stay in this state for one second
                begin
                    led[5:0] = 6'b010000;
                    if (timeUp)
                    nextState = IDLE;
                end
                WRONG_CODE:                   // indicate that wrong code has been entered, stay in this state for one second
                begin
                    led[5:0] = 6'b100000;
                    if(timeUp)
                    nextState = IDLE;
                end
                default: 
                begin
                    nextState = IDLE;
                    led[5:0] = 6'b000000;
                 end
            endcase
            end
        end
    
endmodule
