module labK2;
reg a, b; // reg without size means 1-bit
wire notOutput, lowerInput, tmp, z;

initial
begin
a = 1; b = 1;
end

not my_not(notOutput, b);
assign lowerInput = notOutput;
and my_and(z, a, lowerInput);

always
begin
#1 $display("a=%b b=%b z=%b", a, b, z);
$finish;
end
//initial
//$monitor("a=%b b=%b z=%b", a, b, z, " %2d", $time);
endmodule