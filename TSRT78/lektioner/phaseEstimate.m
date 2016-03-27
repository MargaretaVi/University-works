function [xhat,yhat,phihat] = phaseEstimate(y,w,R,Q,P0)
xhat =  []; yhat= [];
xt = zeros(2,1) + eps; % avoid dividing with zeros

A = eye(2); C= [1 0]; 
P = P0;
Ndata = size(y);
for t =1:Ndata
 yhat = [yhat;C*xt];
 xhat = [xhat;xt'];
 C= [cos(w*t) sin(w*t)];
 S = inv(C*P*C'+R);
 K = A*P*C'*S;
 P = A*P*A' - A*P*C'*S*C*P*A' + Q;
 xt = (A-K*C)*ct+K*y(t);

end

