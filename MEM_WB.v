module MEM_WB( clk, reset, WB_in1, WB_in2, ALU, RD, ALU_out, RD_out, RegWrite, MemtoReg, WN, WN_out, pc_next_in, pc_next_out );

input clk, reset, WB_in1;
input [1:0] WB_in2;
input [31:0] ALU, RD, pc_next_in;
input [4:0] WN ;
output reg RegWrite;
output reg [1:0] MemtoReg; 
output reg [31:0] ALU_out, RD_out, pc_next_out;
output reg[4:0] WN_out ;

always@( posedge clk )
begin
	if ( reset )
	begin
		ALU_out <= 0;
		RD_out <= 0;
		RegWrite <= 0;
		MemtoReg <= 0;
		WN_out <= 0 ;
		pc_next_out <= 0;
	end
	else
	begin
		ALU_out <= ALU;
		RD_out <= RD;
		RegWrite <= WB_in1;
		MemtoReg <= WB_in2;
		WN_out <= WN ;
		pc_next_out <= pc_next_in;
	end
end

endmodule