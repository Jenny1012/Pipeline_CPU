/*
	Title: MIPS Single-Cycle Control Unit
	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
	
	Input Port
		1. opcode: 輸入的指令代號，據此產生對應的控制訊號
	Onput Port
		1. RegDst: 控制RFMUX  ( 橫的(可能要刪) )
		2. ALUSrc: 控制ALUMUX ( ALU 前 )
		3. MemtoReg: 控制WRMUX  ( data memory 後面 )
		4. RegWrite: 控制暫存器是否可寫入
		5. MemRead:  控制記憶體是否可讀出
		6. MemWrite: 控制記憶體是否可寫入
		7. Branch: 與ALU輸出的zero訊號做AND運算控制PCMUX
		8. ALUOp: 輸出至ALU Control
*/
module control_pipeline( opcode, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, ALUOp, Mulrst, instr_in );
    input[5:0] opcode;
	input[5:0] funct ;
	input[31:0] instr_in;
    output ALUSrc, RegWrite, MemRead, MemWrite, Branch, Jump, Mulrst;
    output[1:0] ALUOp, MemtoReg, RegDst,ALUOut;
    reg ALUSrc, RegWrite, MemRead, MemWrite, Branch, Jump, Mulrst;
    reg[1:0] ALUOp, MemtoReg, RegDst,ALUOut ;

    parameter R_FORMAT = 6'd0;
    parameter LW = 6'd35;
    parameter SW = 6'd43;
    parameter BEQ = 6'd4;
	parameter J = 6'd2;
	parameter JAL = 6'd3;
	parameter ADDIU = 6'd9;
	
	
	
    always @( opcode ) begin
        case ( opcode )
          R_FORMAT : 
          begin
				if ( instr_in == 32'h00000000 ) begin
					RegDst = 2'b00; ALUSrc = 1'b0; MemtoReg = 2'b00; RegWrite = 1'b0; MemRead = 1'b0; 
					MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00;
				end
				else begin
					RegDst = 2'b01; ALUSrc = 1'b0; MemtoReg = 2'b00; RegWrite = 1'b1; MemRead = 1'b0; 
					MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b10;
				end
          end
          LW :
          begin
				RegDst = 2'b00; ALUSrc = 1'b1; MemtoReg = 2'b01; RegWrite = 1'b1; MemRead = 1'b1; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; 
          end
          SW :
          begin
				RegDst = 2'bxx; ALUSrc = 1'b1; MemtoReg = 2'bxx; RegWrite = 1'b0; MemRead = 1'b0; 
				MemWrite = 1'b1; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00;
          end
          BEQ :
          begin
				RegDst = 2'bxx; ALUSrc = 1'b0; MemtoReg = 2'bxx; RegWrite = 1'b0; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b1; Jump = 1'b0; ALUOp = 2'b01;
          end
		  J :
		  begin
				RegDst = 2'bxx; ALUSrc = 1'b0; MemtoReg = 2'bxx; RegWrite = 1'b0; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b1; Jump = 1'b1; ALUOp = 2'b01;
		  end
		  JAL :
		  begin
				RegDst = 2'b10; ALUSrc = 1'b0; MemtoReg = 2'b10; RegWrite = 1'b1; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b1; Jump = 1'b1; ALUOp = 2'b01;
		  end
		  ADDIU :
		  begin
				RegDst = 2'b00; ALUSrc = 1'b1; MemtoReg = 2'b00; RegWrite = 1'b1; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00;
		  end
          default
          begin
				$display("control_single unimplemented opcode %d", opcode);
				RegDst=2'bxx; ALUSrc=1'bx; MemtoReg=2'bxx; RegWrite=1'bx; MemRead=1'bx; 
				MemWrite=1'bx; Branch=1'bx; Jump = 1'bx; ALUOp = 2'bxx;
          end

        endcase
    end
	
	
endmodule

