function [axis, al] = find_nalpha( R )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

n_hat = liu_crossop(R);

% nn = n_hat*n_hat';
% absN= sqrt(diag(nn));

al = asin(norm(n_hat));

axis=n_hat/sin(al);
end

