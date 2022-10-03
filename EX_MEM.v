module EX_MEM ( clk, reset, WB_in1, WB_in2, M_in1, M_in2, M_in3, Zero_in, RD2, PC_ADD, ALU, RD2_out, PC_ADD_out, ALU_out, 
				WB_out1, WB_out2, Zero_out, MemRead, MemWrite, Branch ,WN ,WN_out, pc_next_in, pc_next_out);

input clk, reset, Zero_in, WB_in1, M_in1, M_in2, M_in3;
input [1:0] WB_in2;
input[4:0] WN;
input [31:0] RD2, PC_ADD, ALU, pc_next_in;
output reg Zero_out, MemRead, MemWrite, WB_out1, Branch;
output reg [1:0] WB_out2;
output reg [31:0] RD2_out, PC_ADD_out, ALU_out, pc_next_out;
output reg [4:0] WN_out;

always@( posedge clk )
begin
	if ( reset )
	begin
		RD2_out <= 0;
		PC_ADD_out <= 0;
		ALU_out <= 0;
		Zero_out <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		WB_out1 <= 0;
		WB_out2 <= 0; 
		Branch <= 0;
		WN_out <= 0 ;
		pc_next_out <= 0;
	end
	else
	begin
		RD2_out <= RD2;
		PC_ADD_out <= PC_ADD;
		ALU_out <= ALU;
		Zero_out <= Zero_in;
		WB_out1 <= WB_in1;
		WB_out2 <= WB_in2;
		MemRead <= M_in1;
		MemWrite <= M_in2;
		Branch <= M_in3;
		WN_out <= WN;
		pc_next_out <= pc_next_in;
		
	end
end

endmodule