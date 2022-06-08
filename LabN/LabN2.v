module labM;
reg [31:0]  entryPoint;
reg RegWrite, clk, ALUSrc, Mem2Reg, MemRead, MemWrite, INT; 
reg [2:0] op;
wire [31:0] wd, wb, rd1, rd2, imm, ins, PCp4, z, branch, memOut, PC;
wire [31:0] jTarget, PCin;
wire zero, isStype, isRtype, isItype, isLw, isbranch, isjump;
wire [6:0] opCode;
assign opCode = ins[6:0];
yC1 myc1(isStype, isRtype, isItype, isLw, isjump, isbranch, opCode);

yPC myPC(PCin,PC,PCp4,INT,entryPoint,branch,jTarget, zero, isbranch, isjump);
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
RegWrite = 1; ALUSrc = 0; MemWrite = 0; MemRead = 0; Mem2Reg = 0;
  if (ins[14:12] == 3'b000) // add
  op = 3'b010;
  else                      // or
  op = 3'b001;
end
else if (ins[6:0] == 7'h6F) //UJ-Type jal
begin
RegWrite = 1; ALUSrc = 1; MemWrite = 0; MemRead = 0; Mem2Reg = 0; 
end
else if (ins[6:0] == 7'h3)  //I-Type lw
begin
RegWrite = 1; ALUSrc = 1; MemWrite = 0; MemRead = 1; Mem2Reg = 1; 
op = 3'b010;
end
else if (ins[6:0] == 7'h13) //I-Type addi
begin
RegWrite = 1; ALUSrc = 1; MemWrite = 0; MemRead = 0; Mem2Reg = 0; 
op = 3'b010;
end
else if (ins[6:0] == 7'h23) //S-Type sw
begin
RegWrite = 0; ALUSrc = 1; MemWrite = 1; MemRead = 0; Mem2Reg = 0;
op = 3'b010;
end
else if (ins[6:0] == 7'h63) //SB-Type beq
begin
RegWrite = 0; ALUSrc = 0; MemWrite = 0; MemRead = 0; Mem2Reg = 0; 
op = 3'b001;
end
//---------------------------------Execute the ins
clk = 0; #1;
//---------------------------------View results
$display("%b %b %b %b %b %b",isStype, isRtype, isItype, isLw, isjump, isbranch);
 $display("%h: rd1=%2d rd2=%2d z=%3d zero=%b wb=%2d", ins, rd1, rd2, z, zero, wb);

//---------------------------------Prepare for the next ins
//if (ins[6:0] == 7'h63)
//if (INT)
//PCin = entryPoint;
//else if ((ins[6:0] == 7'h63) && (zero == 1))
//PCin = PCin + (branch << 2);
//else if (ins[6:0] == 7'h6F)
//PCin = PCin + (jTarget << 2);
//else
//PCin = PCp4;

end

$finish;
end
endmodule