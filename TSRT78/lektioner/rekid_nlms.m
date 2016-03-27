function [th ] = rekid_nlms( s,M,mu,theta0 )
if nargin < 4
    theta0 = [0;0];
end

N = max(size(s));
th = [theta0, zeros(2,N)];
for ii = 1:N
    phi = [M(t); 1];
    alpha = eps;
    mu = mu/(phi'*phi + alpha);
    th(:,t+1) = th(:,t) + mu*phi*(s(t)-phi'*th(:,t));
end
th = th';
end

