# uppgift 1 lp problem

var x {1..2} >=0

maximize z = 10*x[1] + 2*x[2]; 	#Målfunktion

subject to con1: x[1] + x[2] >= 3; #villkor 1
subject to con2: 5*x[1] + 2*x[2] >= 10; #villkor 2
subject to con3: 2*x[1] - x[2] <= 10;	#villkor 3
subject to con4: x[1] + x[2] <= 7; #villkor 4
subject to con5: -x[1] + 3*x[2] <=9 #villkor 5

