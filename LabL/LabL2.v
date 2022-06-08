module labL;
reg [1:0] a, b;
reg c;
wire [1:0] z;
integer i, j, k;

yMux2 sds(z, a, b, c);

initial
begin 
 for (i = 0 ; i< 4; i++)
 begin
   for (j = 0 ; j< 4; j++)
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