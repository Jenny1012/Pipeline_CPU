`timescale 1ns/1ns
module HiLo( clk, MulAns, HiOut, LoOut, reset, MULSignal );
input clk ;
input reset ;
input [5:0] MULSignal;
input [63:0] MulAns ;
output reg [31:0] HiOut ;
output reg [31:0] LoOut ;

reg [63:0] HiLo ;

/*
=====================================================
下面為模擬範例，程式撰寫請遵照老師上課說明的方法來寫
=====================================================
*/
always@( posedge clk or reset or MULSignal )
begin
  if ( reset )
  begin
    HiLo = 64'b0 ;
  end
/*
reset訊號 如果是reset就做歸0
*/
  else if ( MULSignal == 6'b111111 )
  begin
    HiLo = MulAns ;
	HiOut = HiLo[63:32] ;
	LoOut = HiLo[31:0] ;
  end
  else 
    HiLo = MulAns ;	
/*
把傳入的乘法答案存起來
*/
end
/*
=====================================================
上面為模擬範例，程式撰寫請遵照老師上課說明的方法來寫
=====================================================
*/
endmodule