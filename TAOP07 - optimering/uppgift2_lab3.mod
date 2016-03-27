var x{1..2};

minimize uppgift2:
 x[1];

subject to con1:
(x[1]-1)^2 + (x[2]+2)^2 <=16;

subject to con2:
x[1]^2 + x[2]^2 >=13;

data;    # Startpunkter
var x := 
 1  3
 2  2;

