module labM;
reg [31:0] PCin;
reg RegWrite, clk, ALUSrc, Mem2Reg, MemRead, MemWrite; 
reg [2:0] op;
wire [31:0] wd, wb, rd1, rd2, imm, ins, PCp4, z, branch, memOut;
wire [31:0] jTarget;
wire zero;
yIF myIF(ins, PCp4, PCin, clk);
yID myID(rd1, rd2, imm, jTarget, branch, ins, wd, RegWrite, clk);
yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite);
yWB myWB(wb, z, memOut, Mem2Reg);
assign wd = wb;
assign wd = z;
initial
begin
//------------------------------------Entry point
PCin = 16'h28;
//------------------------------------Run program
repeat (11)
begin
//---------------------------------Fetch an ins
clk = 1; #1;
//---------------------------------Set control signals
RegWrite = 0; ALUSrc = 1; op = 3'b010;
// Add statements to adjust the above defaults
if (ins[6:0] == 7'h33) // R-Type
begin
RegWrite = 1; ALUSrc = 0; MemWrite = 0; MemRead = 0; Mem2Reg = 0;
  if (ins[14:12] == 3'b000)
  op = 3'b010;
  else 
  op = 3'b001;
end
else if (ins[6:0] == 7'h6F) //UJ-Type
begin
RegWrite = 1; ALUSrc = 1; MemWrite = 0; MemRead = 0; Mem2Reg = 0;
end
else if (ins[6:0] == 7'h3) //I-Type
begin
RegWrite = 1; ALUSrc = 1; MemWrite = 0; MemRead = 1; Mem2Reg = 1;
end
else if (ins[6:0] == 7'h13)
begin
RegWrite = 1; ALUSrc = 1; MemWrite = 0; MemRead = 0; Mem2Reg = 0;
op = 3'b010;
end
else if (ins[6:0] == 7'h23) //S-Type
begin
RegWrite = 1; ALUSrc = 1; MemWrite = 1; MemRead = 0; Mem2Reg = 0;
end
else if (ins[6:0] == 7'h63) //SB-Type
begin
RegWrite = 0; ALUSrc = 0; MemWrite = 0; MemRead = 0; Mem2Reg = 0;
end
//---------------------------------Execute the ins
clk = 0; #1;
//---------------------------------View results
 $display("%h: rd1=%2d rd2=%2d z=%3d zero=%b wb=%2d", ins, rd1, rd2, z, zero, wb);

//---------------------------------Prepare for the next ins
PCin = PCp4;
end
$finish;
end
endmodule