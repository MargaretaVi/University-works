function [x, P ] = tw_qw(x,P,T, Rw,omega)
%time update fucntion with quaternions, dynamic model
if nargin < 5
    P = T^2/4*Sq(x)*Rw*Sq(x)' + P;
    
    
else
    I = eye(length(x));
    x = (I + 1/2*Somega(omega)*T)*x;
    % s 197 i boken EKF (8.3f), TT1

    P = T^2/4*Sq(x)*Rw*Sq(x)' + (I + 1/2*Somega(omega)*T)*P*(I + 1/2*Somega(omega)*T)';
   
end
[x, P] = mu_normalizeQ(x, P);
end

