`timescale 1ns/1ns
module Multiplier( clk, dataA, dataB, funct, Signal, dataOut, reset );
input clk ;
input reset ;
input [31:0] dataA ;
input [31:0] dataB ;
input [5:0] Signal, funct ;
output [63:0] dataOut ;

reg [63:0] dataOut ;
parameter MULTU = 6'd25;


always@( posedge clk or reset )
begin
        if ( reset )
        begin
            dataOut = {32'b0,dataB} ;
        end
/*
reset訊號 如果是reset就做歸0
*/

        else begin 
			if ( funct == MULTU ) 
			begin				
					if ( dataOut[0] )  
						dataOut[63:32] = dataOut[63:32] + dataA ;	
				
					dataOut = dataOut >> 1 ; 					
				
			end
		
        end

end


endmodule