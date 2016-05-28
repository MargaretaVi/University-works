% tenta 2015-08-19

% 1a 
xhat1 = [4;0.1];
xhat2 = [7;0.4];
P1 =  [ 10 0 ; 0 4];
P2 = [8 0; 0 8];
x1 = ndist(xhat1,P1);
x2 = ndist(xhat2,P2);

xa=safefusion(x1,x2);

% b)
x_b = inv(inv(P1) + inv(P2))*(inv(P1)*xhat1 + inv(P2)*xhat2);
p_b = inv(inv(P1)+inv(P2));

%c ) 
x0 = [0;0];
p0 = 100*eye(2);
pc = inv(inv(P1) + inv(P2) - inv(p0))
x_c = pc*((inv(P1) - inv(p0))*xhat1 + (inv(P2) - inv(p0))*xhat2)
x_c = pc*((inv(P1))*xhat1 + (inv(P2))*xhat2)

%% 2
clear all; load('data20150819')

% a) measurement model
sm = exsensor('radar');
sm.th = [0,0];
sm.pe = diag([100^2,0.1^2]);

% b) select motion model

motionModel = exmotion('ctcv2d');
xmeas = [radarmeas(:,1).*cos(radarmeas(:,2)),radarmeas(:,1).*sin(radarmeas(:,2))];
figure;
plot(xmeas(:,1),xmeas(:,2),'rx')
% c) EKF
motionModelS = addsensor(motionModel,sm);
motionModelS.x0 = [xmeas(1,:),0 0 0] ;
motionModelS.pv = diag([0 0 100 100 0].^2);

EFK = ekf(motionModelS, sig(radarmeas));
xplot2(EFK,'conf',90);
hold on;
plot(xmeas(:,1),xmeas(:,2),'rx')

% d) PF
Pf = pf(motionModelS, sig(radarmeas),'Np', 10000);
xplot2([],Pf,'conf',90);
hold on
plot(xmeas(:,1),xmeas(:,2),'rx')

%% 3
% a)
xhat_0 = [10000;7500];
P0 = [1000 500; 500 1000];
R = 100;

xbar = ndist([xhat_0;0], blkdiag(P0,R)); % Define xbar
g = @(x) [x(1:2,:);sqrt(x(1,:)^2 + x(2,:)^2)+ x(3,:)];
z = uteval(xbar,g); % Do unscented transform

% b)
y = 12000;
% obtain convariance matrix from z.cov and mean from z.mean
tmp = z.cov;
tmp2 = z.mean;
Pxx = tmp(1:2,1:2);
Pxy = tmp(1:2,3);
Pyx = Pxy';
Pyy = tmp(3,3);
yhat = tmp2(3);
% measurement update
K = Pxy*inv(Pyy);
xhat = xhat_0 + K*(y-yhat);
Pxx2 = Pxx - K*Pyy*K';


%% 4
clear all; close all; clc
load('data20150819.mat');
fs = 100;
% a) discrete state space model, with angle and angle velocity
% motion model
f = inline('[x(1,:) + 0.01*x(2,:); x(2,:)]','t','x','u','th');
% measurement model with only gyro
h = inline('x(2,:)','t','x', 'u', 'th');
mms = nl(f,h,[2 0 1 0],100);

% b) estimate x, the angle , ekf
x = -atan(acc(1,2)/acc(1,1));

mms.x0(1) = x;
mms.pv = 0.01*eye(2);
mms.px0 = 0.1*eye(2);
mms.pe = 0.01;
xhat = ekf(mms,sig(gyr(:,3)));

N = length(acc);
t = [0:0.01:N*0.01-0.01];

figure;
plot(t,xhat.x(:,1))
hold all;

%c) add acc to measurement model
h = inline('[x(2,:); -cos(x(1,:)); sin(x(1,:))]', 't','x','u','th');
mms = nl(f,h, [2 0 3 0], 100);

%d ) estimate x with the result from c
mms.x0(1) =  x;
mms.px0 = 0.1*eye(2);
mms.pe = blkdiag(0.01,eye(2)); % gyr and acc meas noises
mms.pv = diag([1E-5,0.001]);
xhat2 = ekf(mms,sig([gyr(:,3),acc(:,1:2)]));

plot(t,xhat2.x(:,1));
