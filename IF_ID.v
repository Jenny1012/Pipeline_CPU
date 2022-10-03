module IF_ID( clk, rst, PC_Plus4, Inst, Inst_Reg, PC_Plus4_Reg, IF_ID_Write, IF_ID_Write2 ,IF_Flush, pc_next_in, pc_next_out );

	input [31:0] PC_Plus4, Inst, pc_next_in;
	input clk, rst, IF_ID_Write,IF_ID_Write2, IF_Flush ;
	output [31:0] Inst_Reg, PC_Plus4_Reg, pc_next_out;
	reg [31:0] Inst_Reg, PC_Plus4_Reg, pc_next_out;
	
	always@( posedge clk )
	begin
		if ( rst || IF_Flush )
		begin
			Inst_Reg <= 0;
			PC_Plus4_Reg <= 0;		
			pc_next_out <= 0;
		end
		else if ( IF_ID_Write && IF_ID_Write2 ) 
		begin
			Inst_Reg <= Inst;
			PC_Plus4_Reg <= PC_Plus4;
			pc_next_out <= pc_next_in;
		end
		else if( IF_ID_Write == 1'b0 || IF_ID_Write2 == 1'b0 )
		begin
			Inst_Reg <= Inst_Reg;
			PC_Plus4_Reg <= PC_Plus4_Reg;
			pc_next_out <= pc_next_in;
		end		
		else begin
			Inst_Reg <= Inst;
			PC_Plus4_Reg <= PC_Plus4;
			pc_next_out <= pc_next_in;
		end
	end
	
endmodule 