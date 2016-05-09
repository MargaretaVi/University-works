function [x, P ] = tw_qw(x,P, omega, T, Rw)
%time update fucntion with quaternions, dynamic model
I = eye(length(x));
if (omega ~= [] || isnNan(omega))
    x = (I + 1/2*Somega(omega)*T)*x;
    % s 197 i boken EKF (8.3f), TT1
    P = Rw + (I + 1/2*Somega(omega)*T)*P*(I + 1/2*Somega(omega)*T)';
else
    P = Rw + P;
end
[x, P ] = mu_normalizeQ(x, P); 
end

