problem setcover;

param n; # Storleken p� cellprovet
param d; # Storleken p� mikroskopbilden

set B := 1..n-d+1;
set P := 1..n;

param b{k in P,l in P}; # De pixlar som ska �vert�ckas

var x{i in B, j in B} binary; # Anger om bildposition anv�nds

# m�lfunktionsv�rdet ska d�pas till antal_mikroskopbilder

minimize antal_mikroskopbilder: sum {i in B, j in B} x[i,j];

subject to con {k in P,l in P: b[k,l]==1}: sum {i in B, j in B: k-d<i<=k && l-d<j<=l} x[i,j] >= 1;

