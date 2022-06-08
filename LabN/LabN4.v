module labM;
reg [31:0]  entryPoint;
reg clk, INT; 
wire [2:0] op, funct3;
wire [31:0] wd, wb, rd1, rd2, imm, ins, PCp4, z, branch, memOut, PC;
wire [31:0] jTarget, PCin;
wire zero, isStype, isRtype, isItype, isLw, isbranch, isjump, RegWrite, ALUSrc, Mem2Reg, MemRead, MemWrite;
wire [6:0] opCode;
wire [1:0] ALUop;


assign opCode = ins[6:0];
assign funct3 = ins[14:12];
yC1 myC1(isStype, isRtype, isItype, isLw, isjump, isbranch, opCode);
yC2 myC2(RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg, isStype, isRtype, isItype, isLw, isjump, isbranch);
yC3 myC3(ALUop, isRtype, isbranch);
yC4 myC4(op, ALUop, funct3);

yPC myPC(PCin,PC,PCp4,INT,entryPoint,branch, jTarget, zero, isbranch, isjump);
yIF myIF(ins,PC, PCp4, PCin, clk);
yID myID(rd1, rd2, imm, jTarget, branch, ins, wd, RegWrite, clk);
yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite);
yWB myWB(wb, z, memOut, Mem2Reg);
assign wd = wb;
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