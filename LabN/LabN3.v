module labM;
reg [31:0]  entryPoint;
reg clk, INT; 
reg [2:0] op;
wire [31:0] wd, wb, rd1, rd2, imm, ins, PCp4, z, branch, memOut, PC;
wire [31:0] jTarget, PCin;
wire zero, isStype, isRtype, isItype, isLw, isbranch, isjump, RegWrite, ALUSrc, Mem2Reg, MemRead, MemWrite;
wire [6:0] opCode;
assign opCode = ins[6:0];
yC1 myC1(isStype, isRtype, isItype, isLw, isjump, isbranch, opCode);
yC2 myC2(RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg, isStype, isRtype, isItype, isLw, isjump, isbranch);

yPC myPC(PCin,PC,PCp4,INT,entryPoint,branch, jTarget, zero, isbranch, isjump);
yIF myIF(ins,PC, PCp4, PCin, clk);
yID myID(rd1, rd2, imm, jTarget, branch, ins, wd, RegWrite, clk);
yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite);
yWB myWB(wb, z, memOut, Mem2Reg);
assign wd = wb;
//assign wd = z;
initial
begin
//------------------------------------Entry point
entryPoint = 32'h28; INT = 1; #1;
//------------------------------------Run program
repeat (43)
begin
//---------------------------------Fetch an ins
clk = 1; #1; INT = 0;
//---------------------------------Set control signals

// Add statements to adjust the above defaults
if (ins[6:0] == 7'h33) // R-Type
begin
  if (ins[14:12] == 3'b000) // add
  op = 3'b010;
  else                      // or
  op = 3'b001;
end
else if (ins[6:0] == 7'h6F) //UJ-Type jal
begin
op = 3'b010;
end
else if (ins[6:0] == 7'h3)  //I-Type lw
begin
op = 3'b010;
end
else if (ins[6:0] == 7'h13) //I-Type addi
begin
op = 3'b010;
end
else if (ins[6:0] == 7'h23) //S-Type sw
begin
op = 3'b010;
end
else if (ins[6:0] == 7'h63) //SB-Type beq
begin
op = 3'b110;
end
//---------------------------------Execute the ins
clk = 0; #1;
//---------------------------------View results
$display("%b %b %b %b %b %b",isStype, isRtype, isItype, isLw, isjump, isbranch);
 $display("%h: rd1=%2d rd2=%2d z=%3d zero=%b wb=%2d", ins, rd1, rd2, z, zero, wb);

//---------------------------------Prepare for the next ins
end

$finish;
end
endmodule