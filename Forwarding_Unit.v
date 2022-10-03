module Forwarding_unit( clk, rst, ID_EX_RegisterRs, ID_EX_RegisterRt, EX_MEM_RegisterRd, MEM_WB_RegisterRd,
						EX_MEM_RegWrite, MEM_WB_RegWrite, ForwardA, ForwardB );
	
	input clk, rst, EX_MEM_RegWrite, MEM_WB_RegWrite;
	input [4:0] ID_EX_RegisterRs, ID_EX_RegisterRt, EX_MEM_RegisterRd, MEM_WB_RegisterRd;
	output reg [1:0] ForwardA, ForwardB;
	
	always @( EX_MEM_RegWrite or EX_MEM_RegisterRd or ID_EX_RegisterRs or MEM_WB_RegWrite or MEM_WB_RegisterRd ) begin
		if ( ( EX_MEM_RegWrite ) && ( EX_MEM_RegisterRd != 0 ) && ( EX_MEM_RegisterRd == ID_EX_RegisterRs ) ) 
			ForwardA = 2'b10;
		else if ( ( MEM_WB_RegWrite ) && ( MEM_WB_RegisterRd != 0 ) && ( MEM_WB_RegisterRd == ID_EX_RegisterRs ) && ( EX_MEM_RegisterRd != ID_EX_RegisterRs ) ) 
			ForwardA = 2'b01;
		else 
			ForwardA = 2'b00;
	end
	
	always @( MEM_WB_RegWrite or MEM_WB_RegisterRd or ID_EX_RegisterRt or EX_MEM_RegisterRd or EX_MEM_RegWrite ) begin
		if ( ( MEM_WB_RegWrite ) && ( MEM_WB_RegisterRd != 0 ) && ( MEM_WB_RegisterRd == ID_EX_RegisterRt ) && ( EX_MEM_RegisterRd != ID_EX_RegisterRt ) ) 
			ForwardB = 2'b01;
		else if ( ( EX_MEM_RegWrite ) && ( EX_MEM_RegisterRd != 0 ) && ( EX_MEM_RegisterRd == ID_EX_RegisterRt ) )
			ForwardB = 2'b10;
		else
			ForwardB = 2'b00;
	end

endmodule