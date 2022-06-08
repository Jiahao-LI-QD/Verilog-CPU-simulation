module labM;
reg [31:0] d, expect, pre;
reg clk, enable, flag;
wire [31:0] z;
register #(32) mine(z, d, clk, enable);

initial
begin
flag = $value$plusargs("enable=%b", enable);
clk = 0;
repeat (20)
begin
#2 d = $random;
end
$finish;
end

always
begin
#5 clk = ~clk;
end

always
begin
#1 expect = (enable == 1) && (clk == 1 && clk ^ pre == 1) ? d : expect;
pre = clk;
end

initial
$monitor("%5d: clk=%b,d=%d,z=%d,expect=%d", $time,clk,d,z, expect);

endmodule