%% 2.25 a)
N = 60;
w0 = 2*pi/5;
n = 1:N;
T=1;

x(n) = sin(w0*n);
X = fft(x);

N2=N/2;
T2 = T*2;
x_dec = x(1:2:N);
X_dec = fft(x_dec);

figure(1)
subplot (2,1,1)
stem(2*pi/N*[0:N-1],abs(X));

subplot(2,1,2)
stem(2*pi/N2/T2*[0:N2-1],abs(X_dec))


%% b
N3=N/3;
T3 = T*3;

x_dec2 = x(1:3:N);
X_dec2 = fft(x_dec2);

figure(2)
subplot (2,1,1)
stem(2*pi/N*[0:N-1],abs(X));

subplot(2,1,2)
stem(2*pi/N3/T3*[0:N3-1],abs(X_dec2))

%% c
N7=ceil(N/7); 
T7 = T*7;
p=7;
x_dec7 = x(1:7:N);
X_dec7 = fft(x_dec7);
w_hat=(0:ceil(N/p-1))*2*pi/(N/p*p*T);

figure(3)
subplot (2,1,1)
stem(2*pi/N*[0:N-1],abs(X));

subplot(2,1,2)
stem(w_hat,abs(X_dec7));

%% 3.2

y = load ('sig30');
signal=y.y;
N=100;
T=1;
p=10;
w=(0:N-1)*2*pi/(N*T);
w_z=(0:ceil(N*p-1))*2*pi/(N*p*T);

z=zeros(200,1);
Y=fft(signal, p*N);
plot(w_z,abs(Y)) 

%% 4.16
signal=load ('sig40');
s=signal.s;
s1=signal.s1;
s2=signal.s2;
T=1;

w1 = 0.3;
w01 = w1*T/pi ;

[b1,a1]= butter(15,w01);
%[cheb, chea] = cheby1(15,w01);

filts1= filtfilt(b,a,s);
filters = filter(b,a,s);

figure(1)
subplot(3,1,1)
plot(s)
subplot(3,1,2)
plot(filts1)
subplot(3,1,3)
plot((s-filts1))

%% 4.18
clear all
close all
clc

data= load('soderasen');
signal=data.i4r;
T=1/1000;
N=length(signal);
I4r=fft(signal);
w=(0:N-1)'/(N*T);
[b,a]=butter(2,[40*2*T 60*2*T]);
i4rf=filtfilt(b,a,signal);
I4rf=fft(i4rf);
[c,d]=butter(2,[40*4*T 60*4*T]);
i4rF=filtfilt(c,d,signal);
I4rF=fft(i4rF);
plot(w,abs(I4r), '--', w, abs(I4rf), '-', w, abs(I4rF), '.');

%% 4.18 b
fund =sum(i4rf.^2)/N
orig =sum(signal.^2)/N
