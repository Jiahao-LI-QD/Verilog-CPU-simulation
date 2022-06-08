module labM;
reg [31:0]  entryPoint;
reg clk, INT; 
wire [2:0] op, funct3;
wire [31:0] wb, rd2, imm, ins, PCp4, z, branch, memOut, PC;

yChip myChip(ins, rd2, wb, entryPoint, INT, clk);

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

 $display("%h: rd2=%2d wb=%2d", ins, rd2, wb);

//---------------------------------Prepare for the next ins
end

$finish;
end
endmodule