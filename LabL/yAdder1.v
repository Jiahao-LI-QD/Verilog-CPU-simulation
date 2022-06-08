module yAdder1(z, cout, a, b, cin);
input a, b, cin;
output cout, z;

xor xor1(or1, a, b);
xor xor2(z, or1, cin);
and and1(and1, a, b);
and and2(and2, or1, cin);
or or1(cout, and1, and2);

endmodule