%% TSRT78 TENTOR
load('/edu/marvi154/Documents/matlab/TSRT78/Tentor/Apr11.mat')
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
% figure(1);clf
% plot (Fs1*(0:1:N1-1)/N1, Y1,'linewidth',2 ); hold on;
% plot (Fs1*(0:1:N3-1)/N3, Y3, 'linewidth',2); hold off
% xlabel('Frequency [Hz]')
% legend('Y_3','Y_1','location','best')


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
load('/edu/marvi154/Documents/matlab/TSRT78/Tentor/Aug11.mat')
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
load('/edu/marvi154/Documents/matlab/TSRT78/Tentor/Dec11.mat')
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
%  load('/edu/marvi154/Documents/matlab/TSRT78/Tentor/blickdata.mat')

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

est = y(1:N/2);
Ne= length(est);
val = y(N/2+1:end);
Nv = length(val);

for ii = 1:15
    artmp = ar(est,ii);
    lossest(ii) = 1/Ne*sum(pe(est,artmp).^2);
    lossval(ii) = 1/Ne*sum(pe(val,artmp).^2);
end

figure(2); clf
plot(0:length(lossest)-1,lossest,'-',0:length(lossval)-1,lossval,'--')

% detrend the DC component to get good results, the model order is 6 which
% can be obtained from the loss function or by just looking at the fft, 3
% peaks means order 6