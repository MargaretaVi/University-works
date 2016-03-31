%% 2.25
close all
clear all

T=1;
N=60;
n=0:1:N-1;
x=sin(2*pi/5*n);
X=T*fft(x);
w=(0:N-1)*2*pi/(N*T);

p=7;
x_hat=x(1:p:end);
X_hat=p*T*fft(x_hat);
w_hat=(0:ceil(N/p-1))*2*pi/(N/p*p*T);

figure
stem(w,abs(X))
figure
stem(w_hat,abs(X_hat))
axis tight

%% 3.2
close all
clear all
load sig30


T=1;
N=100;
n=0:1:N-1;

Y=T*fft(y);
w=(0:N-1)*2*pi/(N*T);
p=100;
Y_z=T*fft(y,p*N);
w_z=(0:ceil(N*p-1))*2*pi/(N*p*T);


figure
plot(w,abs(Y))
axis tight
figure
plot(w_z,abs(Y_z))
axis tight


%% 4.16
close all
clear all
load sig40

N=200;
n=0:1:N-1;
T=1;

[b,a]=butter(15,0.3*T/pi,'low');        % Bandpass digital filter design   

s_hat_1=filtfilt(b,a,s);
s_hat_2=s-s_hat_1;

S_1=T*fft(s1);
S=T*fft(s);
S_2=T*fft(s2);
S_hat_1=T*fft(s_hat_1);
S_hat_2=T*fft(s_hat_2);
w=(0:N-1)*2*pi/(N*T);

figure
plot(n,s_hat_1,n,s1)
axis tight
figure
plot(n,s_hat_2,n,s2)
axis tight
figure
plot(w,abs(S_hat_1),w,abs(S_1))
axis tight
figure
plot(w,abs(S_hat_2),w,abs(S_2))
axis tight
figure
plot(w,abs(S),w,abs(S_2)+abs(S_1))
axis tight