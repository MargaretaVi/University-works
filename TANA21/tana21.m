% Tana21 lab1

%% uppgift 2    

A = [-1 2 1; 3 -3 3; 1 2 -2;]  ;

B = [2.1; 3; 1;];

xa = A\B;

A*xa;

xb = inv(A)*B;

xa-xb;

A1 = [0 0 1; 1 1 0; 1/10 0 1];
b1 = [1;2;1];
xa1 = A1\b1;

A2 = [1 1; 1 1];
b2 = [0;1];
xa2 = A2\b2;

A3 = [1;1];
b3 = [1;2];

xa3 = A3\b3;

A4 = [1 1];
b4 = 1;

xa4 = A4\b4
%% uppg 3
[L,U,P] = lu(A);

L*U - P*A;

y = L\(P*B);

x = U\y;

%% uppg 4

n=4*2000;A=triu(rand(n,n));b=rand(n,1);tic,inv(A)*b;toc

