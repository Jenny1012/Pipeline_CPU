module equ( clk, Rs, Rt, Zero );
	input [31:0] Rs, Rt ;
	input clk ;
	output reg Zero ;


    always @( posedge clk or Rs or Rt ) begin
		if ( Rs == Rt )
			Zero = 1 ;
		else
			Zero = 0 ;
	end
	
endmodule
