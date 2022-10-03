module ID_EX ( clk, reset, WB_in1, WB_in2, M_in1, M_in2, M_in3, EX_in1, EX_in2, EX_in3, PC_Plus4_Reg,Funct, Funct_out,
				Inst_Reg, RN1, RN2, Extend32_in, RD1_out, RD2_out, PC_Plus4_out, Extend32_out, WB_out1, WB_out2, M_out1, M_out2, M_out3
				, ALUOp, RegDst, ALUSrc,ALUOut, ALUOut_out, IF_ID_RegisterRs_in, IF_ID_RegisterRt1_in, IF_ID_RegisterRt2_in, IF_ID_RegisterRd_in,
				IF_ID_RegisterRs_out, IF_ID_RegisterRt1_out, IF_ID_RegisterRt2_out, IF_ID_RegisterRd_out, Mulrst, Mulrst_out,  HI, HI_out, LO, LO_out,
				shifter_in, shifter_out, pc_next_in, pc_next_out );

input clk, reset, EX_in3, WB_in1, M_in1, M_in2, M_in3, Mulrst;
input [1:0] EX_in1, EX_in2, WB_in2, ALUOut;
input [4:0] IF_ID_RegisterRs_in, IF_ID_RegisterRt1_in, IF_ID_RegisterRt2_in, IF_ID_RegisterRd_in, shifter_in;
input [5:0] Funct;
input [31:0] PC_Plus4_Reg, Inst_Reg, pc_next_in;
input [31:0] RN1, RN2;
input [31:0] Extend32_in, HI, LO ;
output reg ALUSrc, WB_out1, M_out1, M_out2, M_out3, Mulrst_out;  // EX_out
output reg [1:0] ALUOp, RegDst, WB_out2, ALUOut_out;  // 2-bit
output reg [4:0] IF_ID_RegisterRs_out, IF_ID_RegisterRt1_out, IF_ID_RegisterRt2_out, IF_ID_RegisterRd_out, shifter_out ;// 2-bit
output reg [5:0] Funct_out ;// 2-bit
output reg [31:0] RD1_out, RD2_out, PC_Plus4_out, Extend32_out, HI_out, LO_out, pc_next_out;

always@( posedge clk )
begin
	if ( reset )
	begin
		RD1_out <= 0;
		RD2_out <= 0;
		PC_Plus4_out <= 0;
		Extend32_out <= 0;
		RegDst <= 0;
		ALUSrc <= 0;
		ALUOp <= 0;
		WB_out1 <= 0;
		WB_out2 <= 0;
		M_out1 <= 0;
		M_out2 <= 0;
		M_out3 <= 0;
		IF_ID_RegisterRs_out <= 0;
		IF_ID_RegisterRt1_out <= 0;
		IF_ID_RegisterRt2_out <= 0;
		IF_ID_RegisterRd_out <= 0;
		ALUOut_out <= 0 ;
		Mulrst_out <= 0 ;
		HI_out <= 0 ;
		LO_out <= 0 ;
		shifter_out <= 0;
		pc_next_out <= 0;
	end
	else
	begin
		RD1_out <= RN1;
		RD2_out <= RN2;
		PC_Plus4_out <= PC_Plus4_Reg;
		Extend32_out <= Extend32_in;
		WB_out1 <= WB_in1;
		WB_out2 <= WB_in2;
		M_out1 <= M_in1;
		M_out2 <= M_in2;
		M_out3 <= M_in3;
		RegDst <= EX_in1;
		ALUOp <= EX_in2; 
		ALUSrc <= EX_in3;
		Funct_out <= Funct ;
		IF_ID_RegisterRs_out <= IF_ID_RegisterRs_in;
		IF_ID_RegisterRt1_out <= IF_ID_RegisterRt1_in;
		IF_ID_RegisterRt2_out <= IF_ID_RegisterRt2_in;
		IF_ID_RegisterRd_out <= IF_ID_RegisterRd_in;
		ALUOut_out <= ALUOut ;
		Mulrst_out <= Mulrst ;
		HI_out <= HI ;
		LO_out <= LO ;
		shifter_out <= shifter_in;
		pc_next_out <= pc_next_in;
	end
end

endmodule