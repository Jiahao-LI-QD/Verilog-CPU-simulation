module labM;
reg [31:0] expect, wd;
reg [4:0] rs1, rs2, wn; 
reg w, clk, flag;
//reg [31:0] arr [1:31];
wire [31:0] rd1, rd2, rd3, rd4;
integer i;
rf myRF(rd1, rd2, rs1, rs2, wn, wd, clk, w);

rf myRF2(rd3, rd4, rs1, rs2, wn, expect, clk, w);

initial
begin
flag = $value$plusargs("w=%b", w);
for (i = 0; i < 32; i = i + 1)
begin
clk = 0;
wd = i * i;
expect = wd *2;
wn = i;
clk = 1;
#1;
end





 repeat (10)
 begin
    rs1 = $random%32;
	rs2 = $random%32;
	clk = 0;
	wn = 1;
	expect  = 0;
	clk = 1;
	#5 $display(" rs1 ==> %0d\n rs2 ==> %0d\n rd1 ==> %0d\n rd2 ==> %0d\n rd3 ==> %0d\n rd4 ==> %0d\n", rs1, rs2, rd1, rd2, rd3, rd4);	

 end
$finish;
end

endmodule