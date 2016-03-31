%% omtentap pluGG!!!

% 5.11
A= [0.5 0.8; 0 0.5];
B = [1;1];
C= [1 0];
Q = [1 0 ; 0 1];
pi_bar = dlyap (A,B*B');

R_yy1 =C*A*pi_bar*C'

%% lektion 6 wienerfilter

% 7.2 a
[r,p,k] = residue([0 0 1/2], [1 3 1])

% 7.7

[r,p,k] = residue([0 0 -0.45], [1-2.5 1])

%% 8.1

p = (-1+sqrt(5))/4;
kkk = p*1*inv(1*p*1 + 1)

(1/2-1/2*k*1)


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LEKTION 8

A = [0 1 ; 0 1];
b = [0 1]';
c = [1 0];
q = [0 0 ; 0 1];
Q = b'*q*b; % = 1;
R = 1;

% dlqe(a,g,c,q,r,nn)
[kbar,ppbar,pfbar] = dlqe(A, b , c , Q ,R );

% 7.8
% Använd filtfilt för icke kausala filter och filter för kausala
%load('/edu/marvi154/Documents/matlab/TSRT78/lektioner/sig70.mat')
% a)
variance = var(s-y);

% b) non causal wiener filter
shat_b = filtfilt([sqrt(9/40) 0], [1 -0.5], y);
varb = var(s-shat_b);

% c ) causal wiener filter

shatC = filter([3/8, 0], [1 -0.5], y);
varc = var(s-shatC);
% d) causal wiener filter one step head predictor

shatd = filter([0 0.3],[1 -0.5], y);
vard = var(s-shatd);

% e) causal wiener filter for one lag smoothing
shate = filter([0.188 0.225],[1 -0.5], y);
vare = var(s(1:end-1)-shate(2:end));

% f) the FIR wiener filter first order

shatf = filter([0.405 0.238],[1 0], y);
varf = var(s-shatf);

% g) the FIR wiener filter zero order

shatg = filter([0.5 0],[1 0], y);
varg = var(s-shatg);

%% 8.15

% load('/edu/marvi154/Documents/matlab/TSRT78/lektioner/lunarmodule.mat')
A = [1 1 ; 0 1];
B = [0.5;1];
C = [1 0];
% processed noise variance
Qtil = 1;
% Measurement noice variance
R = 500;

% a) estimate the velocity and postion using the stationary kalman filter
% for one step ahead prediction and compare to true signal

[~,xhat]=kalmanfilt(ylm,A,B,C,Qtil,R);
figure(1)
subplot (2,1,1)
plot(xhat(:,1)); hold on
plot(x(:,1), '--')
title('position');
subplot (2,1,2)
plot(xhat(:,2)); hold on
plot(x(:,2),'--')
title('Velocity')
xlabel ('Sample')
hold off

%  b) consider the optimal, time-invariant kalman filte rfor one-step ahead
%  prediction.

x0 = [0;0];
P0 = diag([1*10^6, 5]);
[~,xhatb]=kalmanfilt(ylm,A,B,C,Qtil,R,P0,x0);

figure(2)
subplot (2,1,1)
plot(xhatb(:,1)); hold on
plot(x(:,1), '--')
title('position');
subplot (2,1,2)
plot(xhatb(:,2)); hold on
plot(x(:,2),'--')
title('Velocity')
xlabel ('Sample')
hold off


%  c) consider the optimal, time-invariant kalman filte rfor one-step ahead
%  prediction., itital state is known
P0 = zeros(2,2);
x0 = x(1,:)';
[~,xhatc]=kalmanfilt(ylm,A,B,C,Qtil,R,P0,x0);
figure(3)
subplot (2,1,1)
plot(xhatc(:,1)); hold on
plot(x(:,1), '--')
title('position');
subplot (2,1,2)
plot(xhatc(:,2)); hold on
plot(x(:,2),'--')
title('Velocity')
xlabel ('Sample')
hold off

%  d) assume that the velocity is also observed. Modify the filter to
%  consider also this measurement.
Cd = [1 0; 0 1];
Rd = diag([500,2]);
P0 = zeros(2,2);
x0 = x(1,:)';
[~,xhatd]=kalmanfilt([ylm, yhm],A,B,Cd,Qtil,Rd,P0,x0);

figure(4)
subplot (2,1,1)
plot(xhatd(:,1)); hold on
plot(x(:,1), '--')
title('position');
subplot (2,1,2)
plot(xhatd(:,2)); hold on
plot(x(:,2),'--')
title('Velocity')
xlabel ('Sample')
hold off

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEKTION 9
% 8.3 a) write a funciton stat_kalman that calculates the stationary kalman
% filter for one step ahead prediction

% 8.3 b) use the function written in a for 8.1 , 8.2b

% 8.1
[P,K] = stat_kalman(-0.5,0.5,1,1,1);
%% 8.2b
A = [1 1 ; 0 1]; B = [0;1]; C = [1 0];
[P2,K2] = stat_kalman(A,B,C,1,1);



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEKTION 10
%load('/edu/marvi154/Documents/matlab/TSRT78/lektioner/sig92.mat')
% 9.4

%a) LMS
theta_hata = zeros(length(y),1);
theta_hata(1) = 0.01;
mu = 0.005/(0.1+(y(1)^2));
for i = 2:length(y)
    phi = -y(i-1);
    theta_hata(i) = theta_hata(i-1) + mu*phi*(y(i) - phi'*theta_hata(i-1));
end
figure(5)
plot([th theta_hata])

% b) RLS
theta_hatb = arrls(y,1);
figure(6)
plot([th theta_hatb']); axis([0 300 -0.1 0.8])

% c) kalman filter
theta_hatc = arkf(y,1);
figure(7)
plot([th theta_hatc'])

%% 9.7

%load('/edu/marvi154/Documents/matlab/TSRT78/lektioner/ekgdata.mat')
% a) suppress the disturbance by using a notch filter wit ha narrow stop
% band around 50 Hz. 

[b, a ] = butter(7, [45/(fsamp/2) 55/(fsamp/2)], 'stop');
estsigA = filter(b,a,ekg);
figure(8)
plot(estsigA)
hold on
plot(signal)
hold off

% b)
usig = 10*sin(2*pi*50*tsig+2*pi*rand(1));
figure(9)
[~,estsigB] = rekid_lms(ekg,usig,3,0.001);
plot(tsig,signal, tsig, ekg-estsigB','r--')

% c)
figure(10)
[~,estsigC] = rekid_lms(ekg,usig,4,0.0002);
plot(tsig,signal, tsig, ekg-estsigC','r--')

% d)
figure(11)
[~,estsigd] = rekid_rls(ekg,usig,3,0.95);
plot(tsig,signal, tsig, ekg-estsigd','r--')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEKTION 11

% 9.13
% DUNT WANNA DO IT!!