var x {1..2} >=0;

maximize z: 10*x[1] + 2*x[2];

subject to con1: -x[1] - x[2] <=-3;
subject to con2: -5*x[1] - 2*x[2] <=-10;
subject to con3: 2*x[1] - x[2] <=10;
subject to con4: x[1] * x[2] <=7;
subject to con5:-x[1] + 3*x[2] <= 9;



