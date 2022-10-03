module MUX2_1(out, in1, in0, sel);
output out ;
input in1,in0 ;
input sel ;
wire out ;

assign out = sel ? in0 : in1 ;
endmodule