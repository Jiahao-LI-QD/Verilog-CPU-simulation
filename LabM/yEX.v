module yEX(z, zero, rd1, rd2, imm, op, ALUSrc);
output [31:0] z;
output zero;
input [31:0] rd1, rd2, imm;
input [2:0] op;
input ALUSrc;
wire [31:0] b;

yMux #(32) my_mux(b, rd2, imm, ALUSrc);
yAlu myAlu(z, zero, rd1, b, op);

endmodule