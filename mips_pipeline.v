//	Title: MIPS Single-Cycle Processor
//	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
module mips_pipeline( clk, rst );
	input clk, rst, mulrst ;
	
	// instruction bus
	wire[31:0] instr, instr_out;
	
	// break out important fields from instruction
	wire [5:0] opcode, funct, funct_out, MulSignal ;
	wire [4:0] rs, rt, rd, shamt;
    wire [15:0] immed;
    wire [31:0] extend_immed, b_offset;
	wire [31:0] extend_immed_out, b_offset_out;
	wire [31:0] extend_immed_out2, b_offset_out2;
    wire [25:0] jumpoffset;
	
	// datapath signals
    wire [4:0] rfile_wn,rfile_wn_out,rfile_wn_out2, shamt_out;
    wire [31:0] rfile_rd1, rfile_rd2, rfile_wd, alu_b, alu_out, b_tgt, pc_next,
                pc, pc_incr, dmem_rdata, jump_addr, branch_addr, pc_incr_out, hi, lo, hi_out, lo_out, pc_next_out, pc_next_out2, pc_next_out3, pc_next_out4;
				
	wire [31:0] rfile_rd1_out, rfile_rd2_out, branch_addr_out, alu_out2,dmem_rdata_out, muxA_out, muxB_out;
	wire [31:0] rfile_rd1_out2, rfile_rd2_out2, branch_addr_out2, alu_out3, alu_b_out2, muxalu;
	wire [63:0] mul_out ;
	wire [31:0] instr_in;
	
	// control signals
    wire RegWrite, Branch, PCSrc, MemRead, MemWrite, ALUSrc, Zero, Jump, IF_Flush, Mulrst, IF_ID_write2,PCWrite_M, HiLo_out ;
	wire RegWrite_out, Branch_out, PCSrc_out, MemRead_out, MemWrite_out, ALUSrc_out, Zero_out, Jump_out, Mulrst_out;
	wire RegWrite_out2, Branch_out2, PCSrc_out2, MemRead_out2, MemWrite_out2, ALUSrc_out2, Zero_out2, Jump_out2;
	wire RegWrite_out3, Branch_out3, PCSrc_out3, MemRead_out3, MemWrite_out3, ALUSrc_out3, Zero_out3, Jump_out3;
	wire RegWrite_out4, Branch_out4, PCSrc_out4, MemRead_out4, MemWrite_out4, ALUSrc_out4, Zero_out4, Jump_out4;
	
	
    wire [1:0] ALUOp, RegDst, MemtoReg, RegDst_out, MemtoReg_out,  RegDst_out2, MemtoReg_out2,  RegDst_out3, MemtoReg_out3, MemtoReg_out4;
	wire [1:0] ALUOp_out, forwardA, forwardB, ALUOp_out2, ALUOp_out3, ALUOp_out4, Ans, Ans_out, Ans_out2;
    wire [2:0] Operation; // ALU ctl
	wire IF_ID_write, PC_write, hmcontrol, control_out;
	
    assign opcode = instr[31:26];
    assign rs = instr[25:21];
    assign rt = instr[20:16];
    assign rd = instr[15:11];
    assign shamt = instr[10:6];
    assign funct = instr[5:0];
    assign immed = instr[15:0];
    assign jumpoffset = instr[25:0];
	
	wire [4:0] rs_out, rt1_out, rt2_out, rd_out;
	
	// branch offset shifter
    assign b_offset = extend_immed << 2;
	
	// jump offset shifter & concatenation
	assign jump_addr = { pc_incr[31:28], jumpoffset <<2 };

	// module instantiations
	
	
	reg32 PC( .clk(clk), .rst(rst), .en_reg(PCWrite), .d_in(pc_next), .d_out(pc), .en_reg2(PCWrite_M) );
	memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr) );
	add32 PCADD( .a(pc), .b(32'd4), .result(pc_incr) );
	mux2 #(32) PCMUX( .sel(PCSrc), .a(pc_incr), .b(b_tgt), .y(branch_addr) );  // 看看是不是branch
	mux2 #(32) JMUX( .sel(Jump), .a(branch_addr), .b(jump_addr), .y(pc_next) ); // 最右邊最外面
	
	//*************************** IF_ID ************************* //
	IF_ID IF_ID_REG( .clk(clk), .rst(rst), .PC_Plus4(pc_incr), .Inst(instr), .Inst_Reg(instr_out), .PC_Plus4_Reg(pc_incr_out), .IF_ID_Write(IF_ID_Write),
					.IF_ID_Write2(IF_ID_write_M), .IF_Flush(IF_Flush), .pc_next_in(pc_incr), .pc_next_out(pc_next_out) );
	
	reg_file RegFile( .clk(clk), .RegWrite(RegWrite_out4), .RN1(rs), .RN2(rt), .WN(rfile_wn_out2), .WD(rfile_wd), .RD1(rfile_rd1), .RD2(rfile_rd2) );
	equ equ( .clk(clk), .Rs(rfile_rd1), .Rt(rfile_rd2), .Zero(Zero) ) ;
	and BR_AND(PCSrc, Branch, Zero);  // branch
	
	// sign-extender
	sign_extend SignExt( .immed_in(immed), .ext_immed_out(extend_immed) );
	control_pipeline CTL(.opcode(opcode), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), 
                       .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), 
                       .Jump(Jump), .ALUOp(ALUOp), .instr_in(instr_out));
	multu MULTU( .funct(funct), .ALUout(Ans) );
					   
	mux8 MUX8( .sel(hmcontrol), .a_in(RegWrite), .b_in(MemtoReg), .c_in(MemRead), .d_in(MemWrite), .e_in(Branch), .f_in(RegDst), .g_in(ALUOp), .h_in(ALUSrc), .i_in(Ans),
					.a_out(RegWrite_out), .b_out(MemtoReg_out), .c_out(MemRead_out), .d_out(MemWrite_out), .e_out(Branch_out), .f_out(RegDst_out),
					.g_out(ALUOp_out), .h_out(ALUSrc_out), .i_out(Ans_out) );
					   
	add32 BRADD( .a(pc_incr), .b(b_offset), .result(b_tgt) );  // branch add
	
	Hazard_Detection_unit hdu( .clk(clk), .rst(rst), .IF_ID_RegisterRs(rs), .IF_ID_RegisterRt(rt), .ID_EX_RegisterRt(rt2_out),
								.ID_EX_MemRead(MemRead_out2), .PCWrite(PCWrite), .IF_ID_Write(IF_ID_write), .HazardMuxControl(hmcontrol));
	

	MULCTL mulctl( .clk(clk), .rst(rst), .PCWrite(PCWrite_M), .IF_ID_Write(IF_ID_write_M), .funct(funct), .MULOut(MulSignal), .MULrst(mulrst) ) ;	
	
	Multiplier multiplier( .clk(clk), .dataA(rfile_rd1), .dataB(rfile_rd2), .funct(funct), .Signal(MulSignal) , .dataOut(mul_out), .reset(mulrst) ) ;

	HiLo hilo( .clk(clk), .MulAns(mul_out), .HiOut(hi), .LoOut(lo), .reset(rst), .MULSignal(MulSignal) );
	
	
	//*************************** ID_EX ************************* //
	ID_EX ID_EX_REG( .clk(clk), .reset(rst), .WB_in1(RegWrite_out), .WB_in2(MemtoReg_out), .M_in1(MemRead_out), .M_in2(MemWrite_out), .M_in3(Branch_out),
			.EX_in1(RegDst_out), .EX_in2(ALUOp_out), .EX_in3(ALUSrc_out), .PC_Plus4_Reg(pc_incr), .Inst_Reg(pc_incr), .RN1(rfile_rd1), .RN2(rfile_rd2),
			.Extend32_in(extend_immed), .Funct(funct),.Funct_out(funct_out), .RD1_out(rfile_rd1_out), .RD2_out(rfile_rd2_out), .PC_Plus4_out(pc_incr_out),
			.Extend32_out(extend_immed_out), .WB_out1(RegWrite_out2), .WB_out2(MemtoReg_out2), .M_out1(MemRead_out2), .M_out2(MemWrite_out2), .M_out3(Branch_out2),
			.ALUOp(ALUOp_out2), .RegDst(RegDst_out2), .ALUSrc(ALUSrc_out2),.ALUOut(Ans_out), .ALUOut_out(Ans_out2),
		   .IF_ID_RegisterRs_in(rs), .IF_ID_RegisterRt1_in(rt), .IF_ID_RegisterRt2_in(rt), .IF_ID_RegisterRd_in(rd),
		   .IF_ID_RegisterRs_out(rs_out), .IF_ID_RegisterRt1_out(rt1_out), .IF_ID_RegisterRt2_out(rt2_out), .IF_ID_RegisterRd_out(rd_out),  .HI(hi), .HI_out(hi_out),
		   .LO(lo), .LO_out(lo_out), .shifter_in(shamt), .shifter_out(shamt_out), .pc_next_in(pc_next_out), .pc_next_out(pc_next_out2));
	
	alu_ctl ALUCTL( .ALUOp(ALUOp_out2), .Funct(funct_out), .ALUOperation(Operation) );
	mux2 #(32)  ALUB1MUX( .sel(ALUSrc_out2), .a(muxB_out), .b(extend_immed_out), .y(alu_b) );  // ALU 前
	mux3 ALUB2MUX( .sel(forwardB), .a(rfile_rd2_out), .b(rfile_wd), .c(alu_out2), .y(muxB_out) );  // ALU 前
	alu ALU( .ctl(Operation), .a(muxA_out), .b(alu_b), .result(alu_out), .shamt(shamt_out) );
	
	mux3 ALUMUX( .sel(Ans_out2), .a(hi_out), .b(lo_out), .c(alu_out), .y(muxalu)) ;
	
	mux3 #(32) ALUAMUX( .sel(forwardA), .a(rfile_rd1_out), .b(rfile_wd), .c(alu_out2), .y(muxA_out) ); // 選WN
	mux3 #(5) RFMUX( .sel(RegDst_out2), .a(rt2_out), .b(rd_out), .c(5'b11111), .y(rfile_wn) );
	Forwarding_unit fu( .clk(clk), .rst(rst), .ID_EX_RegisterRs(rs_out), .ID_EX_RegisterRt(rt1_out), .EX_MEM_RegisterRd(rfile_wn_out),
						.MEM_WB_RegisterRd(rfile_wn_out2), .EX_MEM_RegWrite(RegWrite_out2), .MEM_WB_RegWrite(RegWrite_out3), .ForwardA(forwardA),
						.ForwardB(forwardB) );
	//*************************** EX_MEM ************************* //
		   
	EX_MEM EX_MEM_REG( .clk(clk), .reset(rst), .WB_in1(RegWrite_out2), .WB_in2(MemtoReg_out2), .M_in1(MemRead_out2), .M_in2(MemWrite_out2), .M_in3(Branch_out2),
				.Zero_in(Zero_out), .RD2(rfile_rd2_out), .PC_ADD(branch_addr), .ALU(muxalu), .RD2_out(rfile_rd2_out2), .PC_ADD_out(branch_addr_out),
				.ALU_out(alu_out2), .WB_out1(RegWrite_out3), .WB_out2(MemtoReg_out3), .Zero_out(Zero_out2), .MemRead(MemRead_out3), .MemWrite(MemWrite_out3),
				.Branch(Branch_out2), .WN(rfile_wn) , .WN_out(rfile_wn_out), .pc_next_in(pc_next_out2), .pc_next_out(pc_next_out3) );
	
	memory DatMem( .clk(clk), .MemRead(MemRead_out3), .MemWrite(MemWrite_out3), .wd(rfile_rd2_out2), .addr(alu_out2), .rd(dmem_rdata) );	
	//*************************** MEM_WB ************************* //
	MEM_WB MEM_WB_REG( .clk(clk), .reset(rst), .WB_in1(RegWrite_out3), .WB_in2(MemtoReg_out3), .ALU(alu_out2), .RD(dmem_rdata), .ALU_out(alu_out3), 
					   .RD_out(dmem_rdata_out), .RegWrite(RegWrite_out4), .MemtoReg(MemtoReg_out4), .WN(rfile_wn_out) , .WN_out(rfile_wn_out2)
						, .pc_next_in(pc_next_out3), .pc_next_out(pc_next_out4));		   
	mux3 #(32) WRMUX( .sel(MemtoReg_out4), .a(alu_out3), .b(dmem_rdata_out), .c(pc_next_out4), .y(rfile_wd) ); // data memory 後面

				   
endmodule
