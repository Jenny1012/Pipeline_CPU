module alu1bit( c_out, out, set, a, b, sel, c_in, less );

input a, b, c_in, less;  // c_in (1. SEL[2])
input [2:0] sel;
output c_out, out, set; // c_out(carry out), out(answer)

wire sum0, sum1, sum2, sum3;

and( sum0, a, b );  // 3'b000
or( sum1, a, b );   // 3'b001
xoradd1bit MUX2( .sum(sum2), .c_out(c_out), .a(a), .b(b), .c_in(c_in), .sel(sel) );  // 3'b010(add)  3'b110(sub)

// multiplexer 
assign set = sum2;
assign out = ( sel == 3'b000 ) ? sum0 : ( sel == 3'b001 ) ? sum1 : ( sel == 3'b010 ) ? sum2 : ( sel == 3'b110 ) ? sum2 : less ;
// alu0 ~ alu30 set = 0;
// alu1 ~ alu31 less = 0;
// alu31 set = alu0 less;

endmodule
