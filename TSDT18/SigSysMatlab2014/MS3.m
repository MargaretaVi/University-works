% MATLAB Session 3: Discrete-Time Signals and Systems
echo on

% Discrete-Time Functions and Stem Plots:
f = inline('exp(-n/5).*cos(pi*n/5).*(n>=0)','n');

n = (-10:10)';
stem(n,f(n),'k');
xlabel('n'); ylabel('f[n]');
pause; 

clf;

subplot(2,1,1); stem(n,f(-2*n),'k'); ylabel('f[-2n]');
subplot(2,1,2); stem(n,f(-2*n+1),'k'); ylabel('f[-2n+1]'); xlabel('n');
pause; 

clf;

% System Responses through Filtering
b = [1 0 0]; a = [1 -1 1];
n = (0:30)'; delta = inline('n==0','n');
h = filter(b,a,delta(n));
stem(n,h,'k'); axis([-.5 30.5 -1.1 1.1]);
xlabel('n'); ylabel('h[n]');
pause; 

clf;

x = inline('cos(2*pi*n/6).*(n>=0)','n');
y = filter(b,a,x(n));
stem(n,y,'k'); xlabel('n'); ylabel('y[n]');
pause; 

clf;

z_i = filtic(b,a,[1 2]);
y_0 = filter(b,a,zeros(size(n)),z_i);
stem(n,y_0,'k'); xlabel('n'); ylabel('y_{0} [n]'); 
axis([-0.5 30.5 -2.1 2.1]);
pause; 

clf;

y_total = filter(b,a,x(n),z_i);
sum(abs(y_total-(y + y_0)))
pause; 

clf;

% A Custom Filter Function
% (refer to function M-file MS3P1)
pause

% Discrete-Time Convolution
conv([1 1 1 1],[1 1 1 1])
pause; 

clf;

h = inline('(cos(pi*n/3)+sin(pi*n/3)/sqrt(3)).*(n>=0)','n');
y = conv(h(n),x(n));
stem([0:60],y,'k'); xlabel('n'); ylabel('y[n]');
pause; 

clf;

stem(n,y(1:31),'k'); xlabel('n'); ylabel('y[n]');
    
