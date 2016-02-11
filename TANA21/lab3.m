%% lab3

x = [0.5:0.1:1.5];
y = funktion(x);
plot(x,y)

%% 2.2-2.4
h = 0.015*2.^-(0:13);
f_plus = (funktion(1+h)-funktion(1))./h;
f_minus = (funktion(1)-funktion(1-h))./h;
f_0 = (funktion(1+h)-funktion(1-h))./(2*h);
figure(1)
plot(h,f_plus);
figure(2)
plot(h,f_minus);
figure(3)
plot(h,f_0);

%% 2.5-2.6

h = 0.015*2.^-(0:13);
g_plus = (g(1+h)-g(1))./h;
g_minus = (g(1)-g(1-h))./h;
g_0 = (g(1+h)-g(1-h))./(2*h);
figure(1)
plot(h,g_plus);
%figure(2)
%plot(h,g_minus);
%figure(3)
%plot(h,g_0);


%% 3.1
x=[0:0.1:1];
plot(x, funktion(x));

%% 3.3
x=[0:0.1:1];
fun = @(x) exp(1+x.^2);
I = integral(fun,0,1,'AbsTol',1e-12);
I

%% 3.4
h = 1/8;
x=[0:h:1];
I_t = trapz(x,funktion(x));
I_t - I


