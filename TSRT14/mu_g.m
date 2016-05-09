function [ x, P] = mu_g(x, P ,yacc, Ra,g0)
h_derv = dQqdq(x)*g0;
Q = Qq(q);

S = Ra + h_derv*P*h_derv';
K = P*h_derv'*inv(S);
epsil = yacc - Q;

x = x + K*epsil;
P = P-P*h_derv'*inv(S)*h_derv*P;

[x, P ] = mu_normalizeQ(x, P);

end

