module LabL;
reg signed [31:0] a, b, expect;
wire signed [31:0] z, xorb;
wire cout;
reg ctr1, ok;

yArith my_arith(z, cout, a, b, ctr1); 

initial 
begin
  repeat (10)
  begin
  a = $random;
  b = $random;
  ctr1 = $random;
  #1 ;
  if (ctr1) begin
  expect = a - b;
  ok = expect === z ? 1 : 0;
  if (ok)
  $display("pass %d-%d+%b=%d", a, b, ctr1, z);
  else
  $display("fail %d-%d+%b=%d", a, b, ctr1, z, expect, xorb);
  end
  else begin
  expect = a + b; 
  ok = expect === z ? 1 : 0;
  if (ok)
  $display("pass %d+%d+%b=%d", a, b, ctr1, z);
  else
  $display("fail %d+%d+%b=%d", a, b, ctr1, z, expect);
  end
  end
end

endmodule