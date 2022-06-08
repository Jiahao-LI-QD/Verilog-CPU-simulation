module yIF(ins, PCp4, PCin, clk);
input [31:0] PCin;
inout clk;
output [31:0] PCp4, ins;
reg [31:0] four;
assign four = 32'h0004;

always @(posedge clk) begin
Alu myalu(PCp4, null ,PCin, 32'd4 ,3'b010)
mem data(ins, PCin, 32'b0, null, 1, 0);;
end
endmodule
