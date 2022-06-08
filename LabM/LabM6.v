module labM;
reg clk, read, write;
reg [31:0] address, memIn;
wire [31:0] memOut;
mem data(memOut, address, memIn, clk, read, write);

initial
begin
address = 16'h28; write = 0; read = 1;
repeat (11) begin
#1;
if (memOut[6:0] === 7'h33) 
 $display("%h     %h %h %h  %h %h // R-Type", memOut[31:25], memOut[24:20], memOut[19:15],memOut[14:12] ,memOut[11:7],memOut[6:0] );
else if (memOut[6:0] == 7'h6F)
 $display("%h %h %h          // UJ-Type", memOut[31:8],memOut[11:7],memOut[6:0] );
else if (memOut[6:0] == 7'h3 || memOut[6:0] == 7'h13)
 $display("%h    %h %h  %h %h    // I-Type", memOut[31:20], memOut[19:15],memOut[14:12] ,memOut[11:7],memOut[6:0] );
else if (memOut[6:0] == 7'h23)
 $display("%h     %h %h %h  %h %h // S-Type", memOut[31:25], memOut[24:20], memOut[19:15],memOut[14:12] ,memOut[11:7],memOut[6:0] );
 else if (memOut[6:0] == 7'h63)
 $display("%h     %h %h %h  %h %h // SB-Type", memOut[31:25], memOut[24:20], memOut[19:15],memOut[14:12] ,memOut[11:7],memOut[6:0] );
 #1 address += 4;
end
end
endmodule