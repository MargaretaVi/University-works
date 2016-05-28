%% tenta 20150603
close all; clear all; clc

%% 1) fusion; WLS
xhat_0 = [0.1; -0.2];
P0 = 4*eye(2);
y1 = [0;0.1];
y2 = [-0.05;0];
R1 = [1 0 ; 0 4];
R2 = [4 0 ; 0 1];

% alternative 1
xhat1 = inv(inv(P0) + inv(R1))*(inv(P0)*xhat_0 + inv(R1)*y1);
xhat2 = inv(inv(P0) + inv(R2))*(inv(P0)*xhat_0 + inv(R2)*y2);

P1hat = inv(inv(P0) + inv(R1));
P2hat = inv(inv(P0) + inv(R2));

% alternative 2
x0 = ndist(xhat_0,P0);
y_1 = ndist(y1,R1);
y_2 = ndist(y2,R2);
x1 = fusion(x0,y_1);
x2 = fusion(x0,y_2);
%B) individual estimates x1,x2 derive combinded estimate x2
% since they are not independent, need to use safesusion

X1 = ndist(xhat1 , P1hat);
X2 = ndist(xhat2 , P2hat);
X3 = safefusion(X1,X2);

% c) compute an optimal estimate x4

x4hat = inv(inv(P0) + inv(R1) + inv(R2) )*(inv(P0)*xhat_0 + inv(R1)*y1 + inv(R2)*y2);
P1hat = inv(inv(P0) + inv(R1) + inv(R2));

X4 = ndist(x4hat, P1hat);
% d) 

figure;
plot2( x0,X1,X2,X3,X4);


%% 2
% TOA network 4 sensors

% a) sensormodel

sm = exsensor('toa',4,1);
R = 0.001;
sm.x0 = [-0.8, -1];
sm.th = [-1 -1 1 -1 1 1 -1 1];
sm.pe = R*eye(4);

figure;
plot(sm); title 'Sensor model'

% b)
mm = exmotion('ctpv2d');
mm.x0 = [sm.x0' 0.1 pi/2 -0.08];

mmsm = addsensor(mm,sm);
pv = mm.pv;
px0 = mm.px0;

mmsm.pv = [];
mmsm.px0 = [];
y = simulate(mmsm,20);

hold all;
xplot2(y)


% c) EKF
mmsm.pv = pv;
mmsm.px0 = px0/100;

EKF = ekf(mmsm,y);

xplot2(y,EKF,'conf',90);
hold all
plot (sm)
hold off

% d) PF

Pf = pf(mmsm,y, 'Np', 10000);

xplot2(y,[],Pf,'conf',90); % glöm inte tomma paranteser för färg
hold all
plot (sm)
hold all
xplot2(y,EKF,'conf',90);
hold off

%% 4
close all;clear all;clc
load ('data20150603.mat')
fs = 100;

% a) measurement model

h = inline('[-9.82*cos(x); 9.82*sin(x)]','t','x','u','th');
sm = sensormod(h,[1 0 2 0]);
sm.pe = 0.01*eye(2);
N = length(acc);
x = zeros(N,1);
for i = i:N
    xnls = estimate(sm,sig(acc(i,1:2)));
    x(i) = xnls.x0;
end

t = [0:0.01:N*0.01-0.01];
figure
plot(t,x)

%b ) motion model

xpred = zeros(N,1);
xpred(1) = x(1);

for i = 2:N
    xpred(i) = xpred(i-1) + 0.01*gyr(i,3);
end

figure
plot(t,x,t,xpred)

% c)  filter

% motion model

f = inline('x + 0.01*u','t','x','u','th');
% t = time, x = state, u = input, th = params
mms = nl(f,h,[1 1 2 0], 100);
y2 = sig(acc(:,1:2),100,gyr(:,3));
mms.x0 = 0;
mms.px0 = 0.1;
mms.pe = 0.01*eye(2);
mms.pv = 0.01;

EKF = ekf(mms,y2);
figure
plot(t,EKF.x)
hold on
plot(t,x,t,xpred)
