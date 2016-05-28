%% Tenta 2015-10-21

% 1

F = [1 1; 0 1];
P0 = eye(2);
Q = eye(2);

% 2 
x_est = [1;1];
p_est = [6 1; 1 5];
H1 = [1,2];
H2 = [2,1];
R1 = 1;
R2 = 1;
y1 = 4;
y2 = 3.5;
x_1 = x_est + p_est*H1'*(H1*p_est*H1'+R1)^(-1)*(y1-H1*x_est);
x_2 = x_est + p_est*H2'*(H2*p_est*H2'+R2)^(-1)*(y2-H2*x_est);

P1 = p_est - p_est*H1'*(H1*p_est*H1'+R1)^(-1)*H1*p_est;
P2 = p_est - p_est*H2'*(H2*p_est*H2'+R1)^(-1)*H2*p_est;

%% 2
% clear all; close all; clc;
% load('data20151021.mat')
R = 100; %sigma^2, measurement noise covariance

% a) sensor network     
% Toa model with 4 sensors

sm= exsensor('toa',4,1);
sm.th = [-500 -500 500 -500 500 500 -500 500];
sm.pe = R*eye(4);
figure;
plot(sm)
hold on
title 'uppgift2'

%b) motorcycles drives fairly straigth -> cv2d
T = ex2_t(2) - ex2_t(1);
motionModel = exmotion('cv2d',T);

%c)  estimate the trajectory of motocycle with EKF
motionModelAdd = addsensor(motionModel,sm);
posNLS=[];
% initialize with the first two measurements
for i = 1:2
    xhat = estimate(sm,sig(ex2_y(i,:)),'thmask',zeros(8,1));
    %'thmask' gör så att vi inte predicterar sensorpostion
    posNLS(i,:) = xhat.x0;
end
% position, velocity
x0 = [posNLS(1,:), posNLS(2,:) - posNLS(1,:)]';
motionModelAdd.x0 = x0;
motionModelAdd.px0 = diag([100 100 10 10]);
motionModelAdd.pv = motionModelAdd.pv*5; % add process noise, why?
EKF = ekf(motionModelAdd,sig(ex2_y));

xplot2(EKF,'conf',90);

% d) PF

PF = pf(motionModelAdd,sig(ex2_y),'Np',100000);
xplot2([],[],PF,'conf',90);

%% 3


%b) ROC plot
x = 2; H = 1; R = 1;
lambda1 = x*H'*inv(R)*H*x;

figure;
N=1;
roc(chi2dist(N),lambda1)
hold all;
%c)
N =3; x = 2; H = ones(N,1); R = eye(N);
lambda2 = x*H'*inv(R)*H*x;
hold all
roc(chi2dist(N),lambda2);

% e)

H = ones(3,1);
R = eye(3);
lambda3 = x*H'*inv(R)*H*x;
hold all
roc(chi2dist(1),lambda3);

%% 4

h = inline('[-cos(x);sin(x)]','t','x','u','th');

%sensormodel
sm = sensormod(h, [1 0 2 0]); % one state, two measurements x,y
sm.pe = 0.1*eye(2);

% estimate orientation, NLS

N = length(acc);
x_a = zeros(N,1);
for ii = 1:15
    xnls = estimate(sm,sig(acc(:,1:2)));
    x_a(ii) = xnls.x0;
end

% Plot results
t = [0:0.01:5*0.01-0.01];
figure
plot(x_a(1:5,:))

x_a2 = x_a(1:5,:);

%b) 
xpred = zeros(5,1);
xpred(1) = x_a2(1);
for i = 2:5
   xpred(i) = xpred(i-1) + 0.01*gyr(i,3); 
end
figure
plot(t,x_a2)
hold on
plot(t,xpred)