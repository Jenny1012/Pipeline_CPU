module mux8( sel, a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in, i_in, a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out, i_out );
	
	input sel, a_in, c_in, d_in, e_in, h_in;
	input [1:0] b_in, f_in, g_in , i_in;
	output reg a_out, c_out, d_out, e_out, h_out;
	output reg [1:0] b_out, f_out, g_out, i_out;
	
	always@ ( sel or a_in or b_in or c_in or d_in or e_in or f_in or g_in or h_in or i_in ) begin
		if ( sel ) begin
			a_out <= a_in;
			b_out <= b_in;
			c_out <= c_in;
			d_out <= d_in;
			e_out <= e_in;
			f_out <= f_in;
			g_out <= g_in;
			h_out <= h_in;
			i_out <= i_in;
		end
		else begin
			a_out <= 0;
			b_out <= 0;
			c_out <= 0;
			d_out <= 0;
			e_out <= 0;
			f_out <= 0;
			g_out <= 0;
			h_out <= 0;
			i_out <= 0;
		
		end
	end
endmodule