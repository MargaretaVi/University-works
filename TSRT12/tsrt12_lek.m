%% lektion xx

%
s = tf('s');

ga = 1/(s^2 + 2*s + 1);
gc = 1/(s^2 + 5*s+ 1);
ge = 1/(s^2 + 2*s + 4);
gb = 1/(s^2 + 0.4*s + 1);
gd = 1/(s^2 + s + 1);

%bode(ga,gb,gc,gd,ge)

step(ga,gb,gc,gd,ge)

%% 3,24 a)

g = 0.4 /( (s^2 +s +1)*(s+0.2));
g_closed = g/(1+g);

%bode(g)

step(g_closed)

%% b)

g = 2.5* 0.4 /( (s^2 +s +1)*(s+0.2));
g_closed = g/(1+g);

bode(g)

%step(g_closed)

%% c)

s = tf('s');

g = 3*0.4 /( (s^2 +s +1)*(s+0.2));
g_closed = g/(1+g);

bode(g)

%step(g_closed)

%% 5.13

s = tf('s');
g = 725/((s+1)*(s+2.5)*(s+25));
tau_d =1/(5*sqrt(0.28));
beta = 0.27;
K = sqrt(beta);
f = K *( (tau_d * s +1 )/(beta*tau_d*s +1))
%bode (f*g)

step(f*g/(1+ f*g),50)