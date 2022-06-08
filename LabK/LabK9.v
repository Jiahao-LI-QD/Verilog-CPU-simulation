module LabK;
reg a, b, c, flag;
reg [1:0] expect;
wire z, cout, xorin, xor1, xor2in, and1, and2, orin1, orin2;
integer i, j, k;

and (and1, a, b);
assign orin1 = and1;
xor (xor1, a, b);
assign xor2in = xor1;
and (and2, c, xor2in);
assign orin2 = and2;
or (cout, orin1, orin2);
xor (z, c, xor2in);

/*
initial
begin
  for (i = 0; i < 2; i++) begin
  a = i;
    for (j = 0; j < 2; j++) begin
	b = j;
	  for (k = 0; k < 2; k++) begin
	  c = k;
	    #1 $display("a=%b b=%b c=%b z=%b cout=%b", a, b, c, z, cout);
	  end
	end
  end
  $finish;
end 
*/

/*
initial begin
flag = $value$plusargs("a=%b", a);
flag = $value$plusargs("b=%b", b);
flag = $value$plusargs("c=%b", c);
#1 $display("a=%b b=%b c=%b z=%b cout=%b", a, b, c, z, cout);
end
*/


initial
begin
  for (i = 0; i < 2; i++) begin
  a = i;
    for (j = 0; j < 2; j++) begin
	b = j;
	  for (k = 0; k < 2; k++) begin
	  c = k;
	  expect = a + b + c;
	  #1 flag = expect[0] === z & expect[1] === cout ? 1 : 0;
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