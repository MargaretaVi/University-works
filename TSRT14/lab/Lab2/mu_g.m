function [ x, P] = mu_g(x, P ,yacc, Ra,g0)
[h_derv1, h_derv2, h_derv3, h_derv4] = dQqdq(x);
h_derv = [h_derv1*g0, h_derv2*g0, h_derv3*g0, h_derv4*g0];
Q = Qq(x);

S = Ra + h_derv*P*h_derv';
K = P*h_derv'*inv(S);
epsil = yacc - Q*g0;

x = x + K*epsil;
P = P-P*h_derv'*inv(S)*h_derv*P;

[x, P ] = mu_normalizeQ(x, P);

end

