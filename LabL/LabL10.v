module labL;
reg signed [31:0] a, b;
reg [31:0] expect;
reg [2:0] op;
wire ex;
wire [31:0] z;
reg ok, flag;

yAlu mine(z, ex, a, b, op);

initial
begin
repeat (10)
begin
a = $random;
b = $random;
flag = $value$plusargs("op=%d", op);
// The oracle: compute "expect" based on "op"
#1;
// Compare the circuit's output with "expect"
// and set "ok" accordingly
if (op[1] == 0 && op[0] == 0)
expect = a & b;
else if (op[1] == 0 && op[0] == 1)
expect = a | b;
else if (op[2] == 0)
expect = a + b;
else if (op[0] == 0)
expect = a - b;
else
expect = (a < b) ? 1:0;

if (z === expect)
ok = 1;
if (ok)
$display("Pass: a=%b, b=%b, z=%b, op=%b", a, b, z, op);
else
$display("Fail: a=%b, b=%b, z=%b, op=%b, expcet=%b", a, b, z, op, expect);
// Display ok and the various signals
end
$finish;

end
endmodule