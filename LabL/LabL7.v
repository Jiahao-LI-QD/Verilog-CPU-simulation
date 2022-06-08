module LabL;
reg signed [31:0] a, b, expect;
wire signed [31:0] z;
wire cout;
reg cin, ok;

yAdder my_adder(z, cout, a, b, cin); 
 
initial 
begin
  repeat (10)
  begin
  a = $random;
  b = $random;
  cin = $random;
  #1 expect = a + b + cin;
  ok = expect === z ? 1 : 0;
  if (ok)
  $display("pass %d+%d+%b=%d", a, b, cin, z);
  else
  $display("fail %b+%b+%b=%b", a, b, cin, z);
  end
end

endmodule