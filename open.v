`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: open
// Description: output one high signal if the code entered matches the correct code
//////////////////////////////////////////////////////////////////////////////////


module open(
    input [4:0] keycode,
    input [2:0] whichState,
    input clk5,
    input reset,
    output open
    );
    
    
         reg compareEdge;
         reg compareOld;
         reg [2:0] count;
         reg [4:0] muxOut;
         wire compare;
         wire select;
         wire [2:0] nextcount;
         wire clear;
         assign clear = (keycode== 5'b11100);    // corresponds to 'C' key on keypad
         always @(whichState)
         begin
            case(whichState)
                3'b001: muxOut <= 5'b10001; //1
                3'b010: muxOut <= 5'b10010; //2
                3'b011: muxOut <= 5'b11001; //9
                3'b100: muxOut <= 5'b10110; //6
                default: muxOut <= 5'b00000;
            endcase
         end 
  
     assign compare = (keycode==muxOut);     
     
     always @(posedge clk5)                      // store the current compare signal to be used in next cycle as compareOld
     begin 
         compareOld <= compare;
     end
      
    assign select = (compare && !compareOld);                     // select only true if positive edge has occured
    assign nextcount = (open?3'b000:(select?count+1'b1:count));   // only count up if correct digit entered for this key press
    always @ (posedge clk5 or posedge reset)
        begin
     
            if(reset) count <= 3'b000;
            else if(clear) count <= 3'b000;
            else count <= nextcount;
     
        end
     
     assign open = (count==3'b100);             // four correct digits 
     
     
 
endmodule
