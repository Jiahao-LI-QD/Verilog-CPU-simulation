module labL;
reg a, b;
reg c;
wire z;
integer i, j, k;

yMux1 sds(z, a, b, c);

initial
begin 
 for (i = 0 ; i< 2; i++)
 begin
 for (j = 0 ; j< 2; j++)
 begin
 for (k = 0 ; k < 2; k++)
 begin
 a=i; b=j; c= k;
 #1 $display("%b %b %b %b", a, b, c, z);
 end
 end
 end
end

endmodule

/*
module yMux1(z, a, b, c);
output z;
input a, b, c;
wire notC, upper, lower;
not my_not(notC, c);
and upperAnd(upper, a, notC);
and lowerAnd(lower, c, b);
or my_or(z, upper, lower);
endmodule
*/