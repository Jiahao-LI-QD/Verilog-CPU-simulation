module yArith(z, cout, a, b, ctr1);
output [31:0] z;
output cout;
input [31:0] a, b;
input ctr1;
wire [31:0] xorB, tmp;
wire cin;

xor my_xor[31:0](xorB, b, ctr1);
yAdder my_adder(z, cout, a, xorB, ctr1);

endmodule