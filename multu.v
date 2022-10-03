module multu( funct, ALUout );
	input [5:0] funct;
	output reg [1:0] ALUout;
	
	always @ ( funct ) begin
		if ( funct == 6'd16 ) begin
			ALUout = 2'b00;
		end
		else if ( funct == 6'd18 ) begin
			ALUout = 2'b01;
		end
		else begin
			ALUout = 2'b10;
		end
	end
endmodule