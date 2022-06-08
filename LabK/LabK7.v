module LabK;
reg a, b, c, flag;
wire z, notc, out1, out2, in1, in2;
integer i, j;

assign notc =~ c;
and (out1, notc, a);
and (out2, b, c);
assign in1 = out1;
assign in2 = out2;
or (z, in1, in2);

initial
begin
 flag = $value$plusargs("a=%b", a);
 if (flag == 0)
 $display("no match value for a");
flag = $value$plusargs("b=%b", b);
if (flag == 0)
 $display("no match value for b");
flag = $value$plusargs("c=%b", c);
if (flag == 0)
 $display("no match value for c");
 #1 $display("a=%b, b=%b, c=%b, z=%b, flag=%b", a, b, c, z, flag);
end

endmodule