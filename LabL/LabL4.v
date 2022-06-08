module labL;
reg [31:0] a0, a1, a2, a3, expect;
reg [1:0] c;
wire [31:0] z;
integer i, flag;

//defparam my_mux.SIZE = 32;
yMux4to1 #(.SIZE(32)) my_mux(z, a0, a1, a2, a3, c);

initial
begin 
 repeat (10)
 begin
  a0 = $random;
  a1 = $random;
  a2 = $random;
  a3 = $random;
  c = $random % 4;
  #1 $display("%b %b %b %b %b %b", a0, a1, a2, a3, c, z);
 end   
end

initial 
begin
repeat(10)
begin
for (i = 0; i < 32; i++)
begin
expect[i] = ( ((a0[i] & ~c[0]) | (a1[i] & c[0]) ) & ~c[1] ) | 
( (( a2[i] & ~c[0]) | ( a3[i] & c[0])) & c[1]) ;
end
#1;
flag = expect === z ? 1 : 0;
if(flag)
$display("PASS");
else
$display("FAIL", "%b", expect);
end
end
endmodule