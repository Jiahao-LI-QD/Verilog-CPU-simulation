module LabK;
reg a, b, c, flag;
reg [1:0] expect;
wire z, cout;
integer i, j, k;

yAdder1 my_adder(z, cout, a, b, c);

initial
begin
  for (i = 0; i < 2; i++) begin
  a = i;
    for (j = 0; j < 2; j++) begin
	b = j;
	  for (k = 0; k < 2; k++) begin
	  c = k;
	  expect = a + b + c;
	  #1 flag = expect === {cout, z} ? 1 : 0;
	    if (flag)
	    $display("Pass: a=%b b=%b c=%b z=%b cout=%b", a, b, c, z, cout);
		else
		$display("Fail: a=%b b=%b c=%b z=%b cout=%b", a, b, c, z, cout);
	  end
	end
  end
  $finish;
end 

endmodule