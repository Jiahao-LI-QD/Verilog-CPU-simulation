module LabK;
reg a, b, c;
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
  for (i = 0; i < 2; i ++)
  begin
    for (j = 0; j < 2; j++)
    begin
    a = i; b = j; c = 0;
    #1 $display("a=%b, b=%b, c=%b, z=%b", a, b, c, z);
    end
  end
end

endmodule