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

//
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

//
module yAdder(z, cout, a, b, cin);
output [31:0] z;
output cout;
input [31:0] a, b;
input cin;
wire [31:0] in, out;
yAdder1 mine[31:0](z, out, a, b, in);
assign in[0] = cin;
assign in[31:1] = out[30:0];
assign cout = out[31];
endmodule

//
module yAdder1(z, cout, a, b, cin);
input a, b, cin;
output cout, z;
xor xor1(or1, a, b);
xor xor2(z, or1, cin);
and and1(and1, a, b);
and and2(and2, or1, cin);
or or1(cout, and1, and2);
endmodule

//
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

//
module yMux(z, a, b, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a, b;
input c;
yMux1 mine[SIZE-1:0](z, a, b, c);
endmodule
//
module yMux1(z, a, b, c);
output z;
input a, b, c;
wire notC, upper, lower;
not my_not(notC, c);
and upperAnd(upper, a, notC);
and lowerAnd(lower, c, b);
or sd(z, upper, lower);
endmodule

//yIF

module yIF(ins, PCp4, PCin, clk);
input [31:0] PCin;
input clk;
output [31:0] PCp4, ins;

yAlu myAlu(PCp4, null ,PCin, 32'd4 ,3'b010);
mem myMem(ins, PCin, 32'b0, clk, 1'b1, 1'b0);

endmodule

//yID

module yID(rd1, rd2, immOut, jTarget, branch, ins, wd, RegWrite, clk);
output [31:0] rd1, rd2, immOut;
output [31:0] jTarget;
output [31:0] branch;
input [31:0] ins, wd;
input RegWrite, clk;
wire [19:0] zeros, ones; // For I-Type and SB-Type
wire [11:0] zerosj, onesj; // For UJ-Type
wire [31:0] imm, saveImm; // For S-Type
rf myRF(rd1, rd2, ins[19:15], ins[24:20], ins[11:7], wd, clk, RegWrite);
assign imm[11:0] = ins[31:20];
assign zeros = 20'h00000;
assign ones = 20'hFFFFF;
yMux #(20) se(imm[31:12], zeros, ones, ins[31]);
assign saveImm[11:5] = ins[31:25];
assign saveImm[4:0] = ins[11:7];
yMux #(20) saveImmSe(saveImm[31:12], zeros, ones, ins[31]);
yMux #(32) immSelection(immOut, imm, saveImm, ins[5]);
assign branch[11] = ins[31];
assign branch[10] = ins[7];
assign branch[9:4] = ins[30:25];
assign branch[3:0] = ins[11:8];
yMux #(20) bra(branch[31:12], zeros, ones, ins[31]);
assign zerosj = 12'h000;
assign onesj = 12'hFFF;
assign jTarget[19] = ins[31];
assign jTarget[18:11] = ins[19:12];
assign jTarget[10] = ins[20];
assign jTarget[9:0] = ins[30:21];
yMux #(12) jum(jTarget[31:20], zerosj, onesj, jTarget[19]);
endmodule

// yEX
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

// yDM
module yDM(memOut, exeOut, rd2, clk, MemRead, MemWrite);
output [31:0] memOut;
input [31:0] exeOut, rd2;
input clk, MemRead, MemWrite;
// instantiate the circuit (only one line)
mem myMem(memOut, exeOut, rd2, clk, MemRead, MemWrite);
endmodule

// yWB
module yWB(wb, exeOut, memOut, Mem2Reg);
output [31:0] wb;
input [31:0] exeOut, memOut;
input Mem2Reg;
// instantiate the circuit (only one line)
yMux #(32) myWB(wb, exeOut, memOut, Mem2Reg);
endmodule