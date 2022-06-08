module labK;
reg [31:0] x = 32'hffffffef; // a  32-bit initial
reg one;
reg [1:0] two;
reg [2:0] three;
initial
begin
one = &x; // and reduction
two = x[1:0]; // part-select
three = {one, two}; // concatenate
  $display("%b", one, " %b", two, " %b", three);
  $finish;
end

endmodule