function [ L, U, p ] = mylu( a )
%LU-uppdelning av en nxn matris
n = 3;
p = 1:n;
for k =1:n-1
    %[a,p] = pivot(a,p,k);
    for i = k+1:n, a(i,k)/a(k,k); end
    for i = k+1:n
        for j = k+1:n
            a(i,j) = a(i,j)-a(i,k)*a(k,j);
        end
    end
end

U = triu(a);
L = eye(n)+tril(a,-1);