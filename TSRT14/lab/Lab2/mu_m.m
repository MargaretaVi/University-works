function [x, P ] = mu_m(x , P ,ymag, Rm , m0 )
[h_derv1, h_derv2, h_derv3, h_derv4] = dQqdq(x);
h_derv = [h_derv1*m0, h_derv2*m0, h_derv3*m0, h_derv4*m0];
Q = Qq(x);

S = Rm + h_derv*P*h_derv';
K = P*h_derv'*inv(S);
epsil = ymag - Q*m0;

x = x + K*epsil;
P = P-P*h_derv'*inv(S)*h_derv*P;

[x, P ] = mu_normalizeQ(x, P);
end

