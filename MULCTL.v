module MULCTL(  clk, rst,PCWrite,IF_ID_Write, funct, MULBack,  MULOut, MULrst ) ;
							
	input [5:0] funct, MULBack ;
	input clk, rst;
	output reg PCWrite, IF_ID_Write, MULrst ;
	output reg[5:0] MULOut ;
	
	reg [6:0] counter ;
	parameter MULTU = 6'd25;
	parameter OUT = 6'b111111 ;
	
	always@( funct )
	begin
	  if ( funct == MULTU  )
	  begin
		counter = 0 ;
		MULOut = funct ;
		MULrst = 1 ;
		PCWrite = 0 ;
		IF_ID_Write  = 0 ; 
	  end
	  else
		begin
			MULOut <= funct ;
			PCWrite <= 1;
			IF_ID_Write <= 1 ;
		end		
			
	end
	
	always@( posedge clk )
	begin
		if ( funct == MULTU )
		begin
			PCWrite <= 0;
			IF_ID_Write <= 0;
			MULrst <= 0 ;
			if ( funct == MULTU )
				MULOut <= funct ;
			counter = counter + 1 ;
		end
		else
			begin
			MULOut <= funct ;
			PCWrite <= 1;
			IF_ID_Write <= 1 ;
		end		
			
		if ( counter == 31 )
			begin
			  MULOut <= 6'b111111 ; // Open HiLo reg for MULTU
			  PCWrite <= 1;
			  IF_ID_Write <= 1;
			  counter = 0 ;
			end		
			 
	end		
	  
endmodule