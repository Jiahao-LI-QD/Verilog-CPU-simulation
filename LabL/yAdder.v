module yAdder(z, cout, a, b, cin);
output [31:0] z;
output cout;
input [31:0] a, b;
input cin;
wire [31:0] in, out;
//genvar i;

//generate 
//for (i = 0; i < 32; i= i+1) begin
// if (i == 0) 
// yAdder1 mine(z[i], out[i], a[i], b[i], cin);
// else
// yAdder1 mine(z[i], out[i], a[i], b[i], out[i -1]);
// end
// endgenerate
// assign cout = out[31];

yAdder1 mine[31:0](z, out, a, b, in);
assign in[0] = cin;
assign in[31:1] = out[30:0];
assign cout = out[31];

endmodule