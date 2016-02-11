% TSKS10 laboration 1
%clear all
%load data
%load fs

%% Assignment 1
% plotting data in time domain
n = length(data);
time = ((1:n)/fs);
figure(1)
plot(time,data) %signal in time domain
xlabel('tid [s]')

%% plotting data in transform domain
% Fouriertransform and signal spectra
DATA = fft(data);
DATAabs = abs(DATA);
Ts = 1/fs;
xaxis = (0:n-1)/(n*Ts); %frequency
figure(2)
plot(xaxis(1:n/2),DATAabs(1:n/2))
xlabel('Frekvens [Hz]')
title('Amplitudspektrum för y(t)')

%% filtering the signal, first part
[b,a] = butter(7, [5*10^4/(fs/2),6.5*10^4/(fs/2)]);
datafilt1 = filter(b,a,data);

%% filtering the signal, second part
[b,a] = butter(7, [8.5*10^4/(fs/2),10.5*10^4/(fs/2)]);
datafilt2 = filter(b,a,data);

%% filtering the signal, third part
[b,a] = butter(7, [14.8*10^4/(fs/2),15.6*10^4/(fs/2)]);
datafilt3 = filter(b,a,data);

%% plotting the signals in time domain
figure(3)
subplot(3,1,1)
plot(time,datafilt1)% seems like this part could be it
xlabel('tid [s]')
title('Signalen efter filtrering mha de tre olika bärfrekvenserna')
subplot(3,1,2)
plot(time,datafilt2)% doesn't seem to be what we seek
xlabel('tid [s]')
subplot(3,1,3)
plot(time,datafilt3)% contains only (white) noise
xlabel('tid [s]')

%% the chosen signal in the frequency domain
DATAfilt1 = abs(fft(datafilt1));
figure(4)
plot(xaxis(1:n/2),DATAfilt1(1:n/2))

% fc is found through looking at the spectrum
fc = 5.7*10^4 % Hz

%% Assignment 2
Z = xcorr(datafilt3,datafilt3);
n = length(datafilt3);
xaxis2 = ((-n+1:n-1)*(Ts));
figure(5)
plot(xaxis2,abs(Z))
xlabel('tid [s]')
title('Korrelationen för vitt brus från signalen')

deltatau = 0.37 % in seconds

%% Assignment 3
%extracting x from y
% hur får man till tidsfördröjningen på y/data??
tausample = deltatau*fs;
for i = 1:n
    if i <= tausample
        x(i) = data(i);
    else
        x(i) = data(i) - 0.9*x(i-tausample);
    end
end

%% I/Q Demodulation
[b,a]= butter(8,0.008,'low');%filter for noise

phi = 2*pi*fc*deltatau;

xi = 2*x.*cos(2*pi*fc*time+phi);
xq = -2*x.*sin(2*pi*fc*time+phi);

%low pass filtering
xI = filter(b,a,xi);
xQ = filter(b,a,xq);

%sample down for listening
XI = downsample(xI,10);
XQ = downsample(xQ,10);
%%
%soundsc(XI,fs/10)% Det som inte dödar härdar
%soundsc(XQ,fs/10)% Vart man än vänder sig så har man ändan bak

