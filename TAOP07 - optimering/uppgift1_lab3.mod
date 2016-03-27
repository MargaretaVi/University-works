var x{1..2};

maximize uppgift1:
x[1] - 8*(x[1]-3)^2 + 2*x[2]-2*(x[2]-3)^2 +x[1]*x[2];

subject to con1:
x[1]^2 -x[2] <=1;

subject to con2:
2*x[1] - x[2] >=0;

data;    # Startpunkter
var x := 
 1  4
 2  5;

