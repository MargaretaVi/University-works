function [ th] = rekid_rls2(s,M,lambda,theta0, P0 )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
if nargin < 5
    theta0 = [0; 0];
    P0 = 100*eye(2);
end
P = P0;
N = max(size(s)); % numbers of parameters
th = [theta0, zeros(2,N)];

for ii = 1:N
    phi = [M(t); 1];
    P = 1/lambda*(P - P*phi*phi'*P/(lambda + phi'*P'*phi));
    K = P*phi/(lambda + phi'*P*phi);
    th(:,t+1) = th(:,t) + K*phi*(s(t)-phi'*th(:,t));
end
th = th';

end

