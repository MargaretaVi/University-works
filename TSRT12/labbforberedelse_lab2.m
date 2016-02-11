%% labforberedelse 
s = tf('s');
w_c = 0.625; 
tau_d = 3.77;
tau_i = 10/w_c;

Tr = 2;
K = 0.8505;
beta= 0.17;
g_dubbel = 20/(10*s +1)^2;
gamma = 0.386;
F_lead = K*(tau_d*s+1)/(beta*tau_d*s +1);
F_lag = (tau_i*s +1) /(tau_i*s + gamma);

bodeplot (F_lead*F_lag*g_dubbel)

%% lab

s = tf('s');
w_c = 0.33;
beta = 0.10;
tau_d = 1/(w_c*sqrt(beta));
tau_i = 10/w_c;
T = 20;
Kd = 22;
g_dubbel = Kd/((s*T +1)^2);
K = 1/((abs(Kd/((T*i*w_c +1)^2))*abs((tau_d*i*w_c+1)/(beta*tau_d*i*w_c+1))));
%%1/((Kd/((w_c*T)^2+1)*((sqrt(1 + (tau_d*w_c)^2))/((sqrt(1 + (tau_d*w_c*beta)^2))))));

gamma = 0.05*Kd*K/(1-0.05);
F_lead = (tau_d*s+1)/(beta*tau_d*s +1);
F_lag = (tau_i*s +1) /(tau_i*s + gamma);

%bodeplot (F_lead*F_lag*g_dubbel)


step(feedback(F_lead*F_lag*g_dubbel,1))