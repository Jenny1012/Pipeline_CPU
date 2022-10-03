module alu32( C_OUT, SUM, A, B, SEL, C_IN, LESS );

input [31:0] A, B, LESS;
input C_IN, reset;  // carry in
input [2:0] SEL;
output [31:0] SUM;  // SUM(答案) , SET(slt)
output C_OUT;  // carry out

wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10;
wire c11, c12, c13, c14, c15, c16, c17, c18, c19, c20;
wire c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31;
wire set;

alu1bit a1( .c_out(c1), .out(SUM[0]), .less(set), .a(A[0]), .b(B[0]), .sel(SEL), .c_in(SEL[2]) );
alu1bit a2( .c_out(c2), .out(SUM[1]), .less(1'b0), .a(A[1]), .b(B[1]), .sel(SEL), .c_in(c1) );
alu1bit a3( .c_out(c3), .out(SUM[2]), .less(1'b0), .a(A[2]), .b(B[2]), .sel(SEL), .c_in(c2) );
alu1bit a4( .c_out(c4), .out(SUM[3]), .less(1'b0), .a(A[3]), .b(B[3]), .sel(SEL), .c_in(c3) );
alu1bit a5( .c_out(c5), .out(SUM[4]), .less(1'b0), .a(A[4]), .b(B[4]), .sel(SEL), .c_in(c4) );
alu1bit a6( .c_out(c6), .out(SUM[5]), .less(1'b0), .a(A[5]), .b(B[5]), .sel(SEL), .c_in(c5) );
alu1bit a7( .c_out(c7), .out(SUM[6]), .less(1'b0), .a(A[6]), .b(B[6]), .sel(SEL), .c_in(c6) );
alu1bit a8( .c_out(c8), .out(SUM[7]), .less(1'b0), .a(A[7]), .b(B[7]), .sel(SEL), .c_in(c7) );
alu1bit a9( .c_out(c9), .out(SUM[8]), .less(1'b0), .a(A[8]), .b(B[8]), .sel(SEL), .c_in(c8) );
alu1bit a10( .c_out(c10), .out(SUM[9]), .less(1'b0), .a(A[9]), .b(B[9]), .sel(SEL), .c_in(c9) );
alu1bit a11( .c_out(c11), .out(SUM[10]), .less(1'b0), .a(A[10]), .b(B[10]), .sel(SEL), .c_in(c10) );
alu1bit a12( .c_out(c12), .out(SUM[11]), .less(1'b0), .a(A[11]), .b(B[11]), .sel(SEL), .c_in(c11) );
alu1bit a13( .c_out(c13), .out(SUM[12]), .less(1'b0), .a(A[12]), .b(B[12]), .sel(SEL), .c_in(c12) );
alu1bit a14( .c_out(c14), .out(SUM[13]), .less(1'b0), .a(A[13]), .b(B[13]), .sel(SEL), .c_in(c13) );
alu1bit a15( .c_out(c15), .out(SUM[14]), .less(1'b0), .a(A[14]), .b(B[14]), .sel(SEL), .c_in(c14) );
alu1bit a16( .c_out(c16), .out(SUM[15]), .less(1'b0), .a(A[15]), .b(B[15]), .sel(SEL), .c_in(c15) );
alu1bit a17( .c_out(c17), .out(SUM[16]), .less(1'b0), .a(A[16]), .b(B[16]), .sel(SEL), .c_in(c16) );
alu1bit a18( .c_out(c18), .out(SUM[17]), .less(1'b0), .a(A[17]), .b(B[17]), .sel(SEL), .c_in(c17) );
alu1bit a19( .c_out(c19), .out(SUM[18]), .less(1'b0), .a(A[18]), .b(B[18]), .sel(SEL), .c_in(c18) );
alu1bit a20( .c_out(c20), .out(SUM[19]), .less(1'b0), .a(A[19]), .b(B[19]), .sel(SEL), .c_in(c19) );
alu1bit a21( .c_out(c21), .out(SUM[20]), .less(1'b0), .a(A[20]), .b(B[20]), .sel(SEL), .c_in(c20) );
alu1bit a22( .c_out(c22), .out(SUM[21]), .less(1'b0), .a(A[21]), .b(B[21]), .sel(SEL), .c_in(c21) );
alu1bit a23( .c_out(c23), .out(SUM[22]), .less(1'b0), .a(A[22]), .b(B[22]), .sel(SEL), .c_in(c22) );
alu1bit a24( .c_out(c24), .out(SUM[23]), .less(1'b0), .a(A[23]), .b(B[23]), .sel(SEL), .c_in(c23) );
alu1bit a25( .c_out(c25), .out(SUM[24]), .less(1'b0), .a(A[24]), .b(B[24]), .sel(SEL), .c_in(c24) );
alu1bit a26( .c_out(c26), .out(SUM[25]), .less(1'b0), .a(A[25]), .b(B[25]), .sel(SEL), .c_in(c25) );
alu1bit a27( .c_out(c27), .out(SUM[26]), .less(1'b0), .a(A[26]), .b(B[26]), .sel(SEL), .c_in(c26) );
alu1bit a28( .c_out(c28), .out(SUM[27]), .less(1'b0), .a(A[27]), .b(B[27]), .sel(SEL), .c_in(c27) );
alu1bit a29( .c_out(c29), .out(SUM[28]), .less(1'b0), .a(A[28]), .b(B[28]), .sel(SEL), .c_in(c28) );
alu1bit a30( .c_out(c30), .out(SUM[29]), .less(1'b0), .a(A[29]), .b(B[29]), .sel(SEL), .c_in(c29) );
alu1bit a31( .c_out(c31), .out(SUM[30]), .less(1'b0), .a(A[30]), .b(B[30]), .sel(SEL), .c_in(c30) );
alu1bit a32( .c_out(C_OUT), .out(SUM[31]), .less(1'b0), .set(set), .a(A[31]), .b(B[31]), .sel(SEL), .c_in(c31) );

//assign LESS[0] = C_OUT;
//assign SUM = (LESS == 32'd0) SUM : B; 

endmodule