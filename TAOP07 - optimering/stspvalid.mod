problem stspvalid;

set NODESP := {i in NODES: i != 1}; # Noder utom 1:an
set EDGESP within (NODESP cross NODESP) := 
  { (i,j) in EDGES: i != 1 && j != 1}; # Bågar utan de som ansluter till nod 1

param cx {EDGES}; # Målfunktionskoefficienter för w

param k; # Fixerad nod

var w {(i,j) in EDGESP} >= 0, <=1; # Beslutsvariabel
var z {i in NODESP} >= 0, <=1; # Beslutsvariabel


# Låt målfunktionsvärdet i separationsproblemet heta Slack

maximize Slack: 1 + sum {(i,j) in EDGESP} x[i,j]*w[i,j] - sum {i in NODESP} z[i];

subject to con {(i,j) in EDGESP}: w[i,j] <= z[i];
subject to con2 {(i,j) in EDGESP}: w[i,j] <=z[j];
subject to con3 {(i,j) in EDGESP}: w[i,j] >= z[i] + z[j] -1;
subject to con4: z[k] = 1;
# subject to con5: x[6,8] == 0; 

