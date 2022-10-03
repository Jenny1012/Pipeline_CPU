module Hazard_Detection_unit( clk, rst, IF_ID_RegisterRs, IF_ID_RegisterRt, ID_EX_RegisterRt, ID_EX_MemRead, PCWrite,
							IF_ID_Write, HazardMuxControl);
							
	input [4:0] IF_ID_RegisterRs, IF_ID_RegisterRt, ID_EX_RegisterRt;
	input ID_EX_MemRead, clk, rst;
	input [31:0] instr_in;
	output reg PCWrite, IF_ID_Write, HazardMuxControl;
	
	
	always @( IF_ID_RegisterRs or IF_ID_RegisterRt or ID_EX_RegisterRt or ID_EX_MemRead ) begin
		if ( ID_EX_MemRead && ( ( ID_EX_RegisterRt == IF_ID_RegisterRs ) | ( IF_ID_RegisterRt == ID_EX_RegisterRt ) ) ) begin
			PCWrite <= 0;
			IF_ID_Write <= 0;
			HazardMuxControl <= 1;
		end
		else begin 
			PCWrite <= 1;
			IF_ID_Write <= 1;
			HazardMuxControl <= 1;
		end
	end
	
	
	  
endmodule