module yAlu(z, ex, a, b, op);
input [31:0] a, b;
input [2:0] op;
output [31:0] z;
output ex;
wire [31:0] a0, a1, a2, slt;
wire [15:0] z16;
wire [7:0] z8;
wire [3:0] z4;
wire [1:0] z2;
wire z1;
assign slt[31:1] = 0; // not supported
//assign ex = 0;// not supported

yArith cal[31:0](a2, cout, a, b, op[2]);
and Alu_and[31:0](a0, a, b);
or Alu_or[31:0](a1, a, b);

xor Alu_xor(xoro, a[31], b[31]);
yMux1 Alu_slt(slt[0],a[31], a2[31], xoro);

yMux4to1 #(32) select(z, a0, a1, a2, slt, op[1:0]); 

or or16[15:0](z16, z[15:0], z[31:16]);
or or8[7:0](z8, z16[7:0], z16[15:8]);
or or4[3:0](z4, z8[3:0], z8[7:4]);
or or2[1:0](z2, z4[1:0], z4[3:2]);
or or1(z1, z2[1], z2[0]);
not mynot(ex, z2);
endmodule


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


module yAdder(z, cout, a, b, cin);
output [31:0] z;
output cout;
input [31:0] a, b;
input cin;
wire [31:0] in, out;
genvar i;

generate 
for (i = 0; i < 32; i= i+1) begin
 if (i == 0) 
 yAdder1 mine(z[i], out[i], a[i], b[i], cin);
 else
 yAdder1 mine(z[i], out[i], a[i], b[i], out[i -1]);
end
endgenerate
assign cout = out[31];
endmodule


module yAdder1(z, cout, a, b, cin);
input a, b, cin;
output cout, z;
xor xor1(or1, a, b);
xor xor2(z, or1, cin);
and and1(and1, a, b);
and and2(and2, or1, cin);
or or1(cout, and1, and2);
endmodule


module yMux4to1(z, a0,a1,a2,a3, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a0, a1, a2, a3;
input [1:0] c;
wire [SIZE-1:0] zLo, zHi;
yMux #(SIZE) lo(zLo, a0, a1, c[0]);
yMux #(SIZE) hi(zHi, a2, a3, c[0]);
yMux #(SIZE) final(z, zLo, zHi, c[1]);
endmodule


module yMux(z, a, b, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a, b;
input c;
yMux1 mine[SIZE-1:0](z, a, b, c);
endmodule

module yMux1(z, a, b, c);
output z;
input a, b, c;
wire notC, upper, lower;
not my_not(notC, c);
and upperAnd(upper, a, notC);
and lowerAnd(lower, c, b);
or sd(z, upper, lower);
endmodule