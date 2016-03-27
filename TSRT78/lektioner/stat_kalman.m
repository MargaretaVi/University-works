function [ P, K, yhat, xhat ] = stat_kalman(A, B, C, Qtil, R,y)
% funciton stat_kalman calculates the stationary kalman 
% filter for one step ahead prediction 
[kbar, ppbar] = dlqe(A,B,C,Qtil,R);

K = real(A*kbar);
P = real(ppbar);
if nargin > 5
    D = zeros(size(A));
    [yhat, xhat] = dlsim(A-K*C,K,C,0,y);
end
   
end

