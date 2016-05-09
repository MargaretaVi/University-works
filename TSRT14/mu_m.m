function [x, P ] = mu_m(x , P ,ymag,Rm, m0 )
h_derv = dQqdq(x)*m0;
Q = Qq(q);

S = Rm + h_derv*P*h_derv';
K = P*h_derv'*inv(S);
epsil = ymag - Q;

x = x + K*epsil;
P = P-P*h_derv'*inv(S)*h_derv*P;

[x, P ] = mu_normalizeQ(x, P);
end

