%% lab2
x = [1 1.5 2];
y = [2.7 3.4 0.7];

c = polyfit(x,y,3);

xx = [1.0:0.5:2.5];

yy = polyval(c,xx);

y2 = polyval (c2,xx);
plot(xx,y2,x,y,'*')

%%
n = 16;
x = -1:2/n:1;
y = 1./(1+25*x.^2);

c = polyfit(x,y,n+1);
xx = -1:0.05:1;
yy = polyval(c,xx);
plot(xx,yy,x,y,'*');

%%
h = (1/8);
x = [1-h/2 1+h/2 1+3*h/2];
y = 1./(1+25*x.^2);
n1=2;
c=polyfit(x,y,n1);
polyval(c,1)-1/26

xx = 1-h/2:0.05:1+3*h/2;
yy = polyval(c,xx);
plot(xx,yy,x,y,'*');

%% 5.1
n = 64;
x = -1:2/n:1;
y = 1./(1+25*x.^2);

c = csape(x,y);
xx = -1:0.05:1;
yy = fnval(c,xx);
plot(xx,yy,x,y,'*');

%% 5.2

x = [0 1 2 1 0 1 2];
y = [1 0 1 2 3 4 3];

t = 1:7;
px = csape(t,x);
tt = 1:0.1:7;
py = csape(t,y);
plot(fnval(px,tt),fnval(py,tt)), axis equal;