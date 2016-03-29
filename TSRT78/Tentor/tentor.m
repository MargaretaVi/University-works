%% TSRT78 TENTOR
load Apr11.mat
%%

% --------------------------------- April 11-----------------------------

% 1a)

f0=128;                      % Signal frequency [Hz]
Fs1=8192;                    % Sampling frequency [Hz]
Ts1=1/Fs1;                   % Sampling interval [s]
t1=0:Ts1:1-Ts1;              % 1s time vector
y1=sin(2*pi*f0*t1);
decfactor=8;                 % Decimation factor
t2=t1(1:decfactor:end);
y2=y1(1:decfactor:end);
y3=kron(y2,ones(1,decfactor));

Y1 = abs(fft(y1));
Y3 = abs(fft(y3));
N1 = length(y1);
N3 = length(y3);
Fs3 = Fs1;
Ts3 =1/Fs1;
figure(1);clf
stem(Fs1*(0:1:N1-1)/N1, Y1,'linewidth',2 ); hold on;
stem(Fs1*(0:1:N3-1)/N3, Y3, 'linewidth',2); hold off
xlabel('Frequency [Hz]')
legend('Y_3','Y_1','location','best')


% b) Improve the reconstruction using filtering.
% all distorsion are above the the frequency 128Hz, which are the one we
% want. Thus lowpass filtering will help
%
[b,a] = butter(8,2*f0/(Fs3/2));
filteredy3 = filter(b,a,y3);
% figure(2); clf
% plot(t1,y1,'-',t1,filteredy3,'-.');

% c) downsample y3

y3down = y3(1:decfactor:end);
y4 = kron(y3down,ones(1,decfactor));
Y4 = abs(fft(y4));
N4 = length(y4);
Fs4 = Fs1;
Ts4 = 1/Fs4;
% figure(3);clf
% plot(Fs1*(0:1:N1-1)/N1, Ts1*Y1,Fs4*(0:1:N4-1)/N4, Ts4*Y4,'linewidth',2 );

% This is easy to understand, since decimation of y3 by a factor of 8 will return a signal identical to y2.
% Since y2 was a sampling, at sampling frequency 8192/8 = 1024 Hertz, of a signal with frequency 128 Hertz,
% there is no folding since 1024/2 = 512>128


%%


% --------------------------------- April 11-----------------------------
%% 2
clearvars
load Aug11.mat
%%
% a)
A = eye(2);
B = eye(2);
R = 1;
Q = 1e-7*eye(2);
x0 =[0;0];
xt = x0;
P0 = eye(2);
P = P0;
N = length(ykf);
yhat = zeros(1,N);
for t = 1:N
    C = [1 t];
    S = C*P*C' + R;
    K = P*C'*inv(S);
    %P = A*(P - K*C*P)*A' + Q;
    P = P - K*S*K';
    xt = A*xt + K*(ykf(t)-C*xt);
    yhat(t) = C*xt;
    xt = A*xt;
    P = A*P*A' + Q;
end

% Plot the results
figure(4)
plot(1:N,ykf,1:N,yhat,'linewidth',2)
xlabel('Time')

%% 3)

figure(5)
plot(1:length(ymodel),ymodel)

% look on how many ups it has and multiply with 2 due to complex conjugate
% pairs.
YMODEL = abs(fft(ymodel));
% figure(6)
% plot(YMODEL)

N = length(ymodel);
est = ymodel(1:N/2);
val = ymodel(N/2 +1: N);
Ne = length(est);
Nv = length(val);
for k = 1:10
    modelorder = ar(est,k);
    lossest(k) = 1/Ne*sum(pe(modelorder,est).^2);
    lossval(k) = 1/Ne*sum(pe(modelorder,val).^2);
end

figure(7); clf
plot(1:length(lossest),lossest,'-',1:length(lossval),lossval,'--')
% the knee appears at n = 4, so the model order is 4;

%% --------------------------------- Dec 11-----------------------------
clearvars
load Dec11.mat
%%
% 1)
% a)
f0=30;
N=500;
t=(0:N-1)';
T=1/1000;
s=sin(2*pi*f0*t*T)+0.5*sin(2*pi*0.95*f0*t*T);
y=s+0.1*randn(N,1);

Y = abs(fft(y));

figure(8);clf
plot((0:length(Y)-1)/(T*length(Y)),Y)
xlabel('Frequency  [Hz]')

% we cannot recover both frequencies due to the spearation between them are
% smaller than the frequency resolution

%% b)
B = 1;
A = [1 0.3 -0.4 0.25 0.2];
s2 = 0.5;                     % Noise variance
e = sqrt(s2)*randn(1000,1);
y = filter(B,A,e);

Y =abs(fft(y));
figure(9); clf
% plot(0:length(Y)-1,Y)
bode(etfe(y))

%% 2 b)

numerator = [0 1.5 -0.6];
denominator = [1 -1 0.16];

G = tf(numerator,denominator,'Ts',1,'Variable', 'z^-1'); % transfer function

stateG = ss(G); %state space model
A = stateG.a; B = stateG.b; C= stateG.c; Q = 1;

pi_bar = dlyap(A,B*Q*B');

R_yy = C*A*pi_bar*C'; % covariance function???

%% 4
b = [1 -5.2 1];
a = [1 -3.1 1 0];
[R,P,K] = residue(b,a);

%% ---------------------------------Aug 12----------------------------
load blickdata.mat
%%
% 1)

t=(0:999)';
y=1./(sin(0.1*t)+2)+0.01*randn(size(t));

% a)
N = length(y);
Ts = 1;
ypadd = [y;zeros(7*1024-N,1)];
nonparm = abs(fft(ypadd));
figure(1); clf
Ylength = length(ypadd);
%plot((0:N-1)/(N*Ts),nonparm); xlabel('Frequency [Hz]'); %axis([-0.05 1 -10 300]);
plot((0:Ylength-1)/(Ylength*Ts),nonparm); xlabel('Frequency [Hz]'); axis([-0.05 1 -10 300]);

% b)  modelbased Ar(n)
y = detrend(y,'constant');
est = y(1:N/2);
Ne= length(est);
val = y(N/2+1:end);
Nv = length(val);

% for ii = 1:200
%     artmp = ar(est,ii);
%     lossest(ii) = 1/Ne*sum(pe(est,artmp).^2);
%     lossval(ii) = 1/Ne*sum(pe(val,artmp).^2);
% end

th = ar(y,2*30);
bode(th)
freqencies = angle(roots(th.a))/(2*pi*Ts);
figure(2); clf
plot(0:length(lossest)-1,lossest,'-',0:length(lossval)-1,lossval,'--')
legend('estimation', 'validation')

% detrend the DC component to get good results, the model order is 6 which
% can be obtained from the loss function or by just looking at the fft, 3
% peaks means order 6

%% 2)

% a) 
num = [0 0 1/2];
den = [1 5/2 1];
[r,p,k] = residue(num,den);

%% 4

load blickdata
plot(data2(:,2),data2(:,3))

%% ---------------------------------Dec 12----------------------------

% 1a)

% The forgetting factor balances the accuracy and the adaptation speed of the RLS algorithm. 
% This as the forgetting factor controls the number of observations to take into account. 
% So a large number of observations gives high static accuracy as it mitigates the noise but then fails to adapt to sudden parameter changes

% 1b)
% ccirc = ifft(fft(xpad).*fft(ypad));
 x = [0,0,1,0,1,0,0];
 y = [1,2,3,4,5,6,7];
ccirc = ifft(fft(x).*fft(y));

% ans = [10 12 7 9 4 6 8]

% 1d) 
Ts = 1;
Fs = 1/Ts;
y1 = kron((-1).^(1:20),ones(1,6))';
Y1 = abs(fft(y1));

figure(2);clf
subplot(3,1,1); plot(y1); xlabel('time'); ylabel('signal');
subplot(3,1,2); plot(Fs*(0:length(y1)-1)/length(y1),Y1); xlabel('freq. [Hz]'); ylabel('Amplitude');
[b,a ] = butter(2,[0.2250/(Fs/2) 0.2750/(Fs/2)], 'bandpass');
y1filtered = filter(b,a,y1);

subplot(3,1,3); plot(y1filtered);  xlabel('time'); ylabel('signal');
%% 2
a1=[1 -3.4 4.85 -3.4 1];
a2=conv([1 -1.4 0.999],[1 -1.8 0.999]);
N=10000;
y2=filter(1,a1,zeros(N,1),[1;0;0;0])+filter(1,a2,randn(N,1));
T = 1;
fs = 1/T;
% a) nonparametric

Y2 = abs(fft(y2));
figure(2);clf
plot(fs*(0:length(y2)-1)/length(y2),Y2);
% three peaks
% b) AR model

est = y2(1:2*N/3);
Ne = length(est);
val = y2(2*N/3+1:end);
Nv = length(val);
% lossfunction
% 
for ii = 1:20
    artmp = ar(est,ii);
    lossest(ii) = 1/Ne*sum(pe(est,artmp).^2);
    lossval(ii) = 1/Nv*sum(pe(val,artmp).^2);
end
lossfunc = [];
for p = 1:20
    m = arx(est,p);
    yp = predict(val,m,1);
    lossfunc(p) = mean((val-yp).^2);
end
figure(3); clf
plot(lossfunc); xlabel('modelorder (p)'); ylabel('loss function'); 
plot(0:length(lossest)-1,lossest,'-',0:length(lossval)-1,lossval,'--')

%% ---------------------------------------MAr13-------------------------
clearvars;
load Mar13.mat
%%

% 1)
Na = 150;
T = 0.2;
fs = 1/T;
t = 0:Na-1;
e = randn(1,Na)*0.1;
y = sin(t*T) + sin(1.2*t*T) + e;

Y = fft(y);
figure(1); clf
plot(fs*(0:Na-1)/Na, abs(Y));
xlabel('Frequency [Hz]');
title('Leakage casuse the two sinuses to look like one');

% b) 
Yb = fft([y zeros(1,1024-Na)]);
Nb = length(Yb);
figure(2)
plot(fs*(0:Nb-1)/Nb, abs(Yb)); xlabel('Frequency [Hz]');
title('Zero padd to make the two sinuses appear');

% %c)
% Nc = 400;
% t = 0:Nc-1;
% ec = randn(1,Nc)*0.1;
% yc = sin(t*T) + sin(1.2*t*T) + ec;
% data = iddata(y,[],T);
% per_data = etfe(data);
% figure(2)
% bode(per_data)

%% 2
% a)

[r,p,k] = residue([0 0 1],[-0.6 2.36 -0.6]);

%% 3

N = length(y);
theta = zeros(1,N);
Q = 0.001;
R = 1;
P = 1;
theta(:,1)=0;
%kalman adaptive

for i = 2:N
    phi = -y(i-1);
    K = P*phi./(R + phi'*P*phi);
    P = P - K*phi'*P+ Q;
    %P = P- P*phi*phi'*P/(R + phi'*P*phi) + Q;
    thetatmp = theta(:,i-1)+K*(y(i)-phi'*theta(:,i-1));
    theta(:,i) = thetatmp;
end

figure(1); clf;
plot(theta,'r'); title('Kalmanfiltering'); ylabel('theta'); xlabel('sample')


%% ---------------------------------------Jan14-------------------------
clearvars;
load Jan14.mat

%%

