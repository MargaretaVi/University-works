var x{1..2};

minimize obj:
 2*x[1]^2 + x[1]*x[2] + 3*x[1] + 4*x[2]^2;

subject to con1:
 x[1] + 2*x[2]^2 >= 3;

subject to con2:
 x[1] + 3*x[2] = 5;

data;    # Startpunkter
var x := 
 1  4
 2  5;

