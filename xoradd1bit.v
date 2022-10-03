module xoradd1bit( sum, c_out, a, b, c_in, sel );

output sum, c_out;
input a, b, c_in;
input [2:0] sel;

wire b2, aors;

assign aors = sel[2]; // aors = add or sub

xor( b2, b, aors );
fulladd fa( sum, c_out, a, b2, c_in );

endmodule