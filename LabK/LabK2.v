module labK;
reg [31:0] x, y, z;
integer i;

initial
begin
#10 x = 5;
//$display("%2d: x=%1d y=%1d z=%1d", $time, x, y, z);
#10 y = x + 1;
//$display("%2d: x=%1d y=%1d z=%1d", $time, x, y, z);
#10 z = y + 1;
//$display("%2d: x=%1d y=%1d z=%1d", $time, x, y, z);
$finish;
end

always
begin
  #7 x= x+1;
end

initial
$monitor("%2d: x=%1d y=%1d z=%1d", $time,x, y, z);

/*
initial
begin
  for ( i = 0; i < 4; i++)
  
    #7 x = x + 1;
end
*/
endmodule