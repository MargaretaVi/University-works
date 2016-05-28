%% TANA21 miniprojekt2

%% LU uppdelning

A = [ 1 0 -1; -2 1 0; 1 -2 -2];
b = [1;2;3];

[L,U,p] = mylu(A);
y = forward(L,b);
x = backward(U,y);
display(x);
