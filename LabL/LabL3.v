module labL;
reg [31:0] a, b, expect;
reg c;
wire [31:0] z;
integer i, flag;

//defparam my_mux.SIZE = 32;
yMux #(.SIZE(32)) my_mux(z, a, b, c);

initial
begin 
 repeat (10)
 begin
  a = $random;
  b = $random;
  c = $random % 2;
  #1 $display("%b %b %b %b", a, b, c, z);
 end   
end

initial 
begin
repeat(10)
begin
for (i = 0; i < 32; i++)
begin
expect[i] = (a[i] & ~c) | (b[i] & c);
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