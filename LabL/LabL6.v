module LabL;
reg [31:0] a, b, expect;
wire [31:0] z;
wire cout;
reg cin, ok;
integer seed;

yAdder my_adder(z, cout, a, b, cin); 
 
initial 
begin
  repeat (10)
  begin
  seed += 45;
  a = $random(seed);
  b = $random(seed);
  cin = $random(seed);
  #1 expect = a + b + cin;
  ok = expect === z ? 1 : 0;
  if (ok)
  $display("pass %b+%b+%b=%b", a, b, cin, z);
  else
  $display("fail %b+%b+%b=%b", a, b, cin, z);
  end
end

endmodule