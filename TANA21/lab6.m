%% lab 6

% 2.1 - 2.2

n = -1074;

2^n;

%% 2.3

a = exp(1000);
a % inf
a + a % inf

1/a % 0

-a % -inf
a-a % NaN

%% 3.1
n = -51;
1 + 2^n;
eps(1);

%% 3.2

n = -51;
2 + 2^n;

eps(2)

%% 3.3

n = -50;
4 + 2^n;

%eps(2)

%% 4.1

s1 = 0; for k=1:100000, s1 = s1+1/k^4; end, p1=(90*s1)^(1/4);

s2 = 0; for k=100000:-1:1, s2 = s2+1/k^4; end, p2=(90*s2)^(1/4);

pi - p1;
pi - p2;
%% 4.3 
k=1:100000; p3=(90*sum(1./k.^4))^(1/4);
pi - p3

%% 5
x = [0:10^-11:10^-7];
y = sqrt(x.^2+1) - 1;
y2 = x.^2 ./(sqrt(x.^2 +1) +1);

figure
plot(x,y)
hold on
plot(x,y2, 'r')
hold off
