function [th] = rekid_kalman(s,M,Q,theta0,P0)
if nargin < 5
    theta0 = [0;0];
    P0 = 100*eye(2);
end
N = max(size(s));
R = 1;
P = P0;
th = [theta0; zeros(2,1)];
for t = 1:N
    phi = [M(t); 1];
    K = P*phi/(R + phi'*P*phi);
    P = P - P*phi*phi'*P/(R+phi'*P*phi) + Q;
    th(:,t+1) = th(:,t) + K*(y-phi'*th(t));
end
th = th';
end

