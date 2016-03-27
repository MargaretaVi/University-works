problem stsp;

set S4; # Mängden som beskriver en subtur, definieras i stsp.dat
set S2;
set S3;
set S5;
set NODES; # Antalet noder i handelsresandeproblemet (tsp)
set EDGES within (NODES cross NODES); # Mängden möjliga bågar

param c {EDGES}; # Bågkostnad (avstånd)
param Node_Pos{NODES, 1..2}; # Positioner för noder

var x {(i,j) in EDGES} >= 0, <=1; # Beslutsvariabler

minimize totallength: sum {(i,j) in EDGES } c[i,j]*x[i,j];

subject to valensvillkor {k in NODES}:
sum {(i,j) in EDGES: i==k || j==k} x[i,j] = 2;

subject to con1:
x[6,8] = 1;

# Modell för hur nya subtursförbjudande bivillkor kan adderas
subject to subtur1:
sum { i in S4, j in S4 : (i,j) in EDGES } x[i,j] <=  card(S4) - 1;

subject to subtur2:
sum { i in S2, j in S2 : (i,j) in EDGES } x[i,j] <=  card(S2) - 1;

subject to subtur3:
sum { i in S3, j in S3 : (i,j) in EDGES } x[i,j] <=  card(S3) - 1;

subject to subtur4:
sum { i in S5, j in S5 : (i,j) in EDGES } x[i,j] <=  card(S5) - 1;
