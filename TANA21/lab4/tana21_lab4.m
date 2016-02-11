%% lab4 

% 2.1
x = [0:0.1:1];
y = exp(-x.^2);
plot(x,y)

%% 2.2
z = -2.*x.*y;
plot(x,y)
hold on
plot(x,z);
hold off

%% 2.4

z =@(x,y) -2.*x.*y;
[tout, yout] = ode23(z, [0 1], 1);
figure(2)
plot(x,yout)
hold on
plot(x,y)
hold off

%% 2.5
plot(x,y'-yout);

%% 3.1
clc
kp = 0.1;
ki = 0.125;

A = [-5*10^-5 1 0 ; -kp -1 -ki; 1 0 0];
b = [-10^-3; 10^-3; 0];
p = @(t,v) A*v +b;

[tout, yout] = ode23(p, [0 40], [-1 0.001 0 ]);
figure(6)
plot(tout,yout)



