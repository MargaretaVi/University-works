%% TSRT12 lektion 3

%% a)
s = tf('s');
ga = 1/(s^2 + 2*s + 1);
%step(ga); grid

gb = 1/(s^2 + (0.4)*s + 1);
%step(gb); grid

gc = 1/(s^2 + 5*s + 1);
%step(gc); grid

gd = 1/(s^2 + s + 1);
%step(gd); grid

ge = 1/(s^2 + 2*s + 4);
step(ge); grid

%% b)
pole (ga)
pole (gb)
pole(gc)
pole(gd)
pole (ge)

%% 3.5 a)

s = tf('s');
k = 3;
g = 0.2/((s^2 + s + 1)*(s+0.2));

y = k*g/(1 + k*g);
step (y)

%% b)
s = tf('s');
kp = 1;
ki = 1;

F = kp + ki/s;
g = 0.2/((s^2 + s + 1)*(s+0.2));

Y = feedback (F*g, 1);
step (Y,50); grid 

%% c) 
ki = 1;
kp = 1;
T = 0.1;
s = tf('s');
kd = 2;
F = kp + ki/s + kd*s/(s*T +1);
g = 0.2/((s^2 + s + 1)*(s+0.2));

Y = feedback (F*g, 1);
step (Y,50); grid 


%% 2.7 
s = tf('s');
 a = -0.1;
o = (a *s + 1)/ (s^2 + s*2 + 1) 

step (o, 50) ; grid 
