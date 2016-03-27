%% TSKS10 laboration
% Loading data
clear all;
file ='marvi154.wav';
[y,fs] = wavread(file); 
lenght_of_sample = length(y);
time=((0:lenght_of_sample-1)/fs);	

%% Assignment 1
% Fouriertransforming the signal and plotting
Y = fft(y);
absY = abs(Y);
%Scaling the x-axis so that we only work with the positive side of the
%spectra
frequency = (0:lenght_of_sample-1)*(fs/lenght_of_sample); % making sure that the unit is correct (Hz)

figure(1)
plot(frequency(1:lenght_of_sample/2),absY(1:lenght_of_sample/2))
xlabel('Frequency [Hz]')
title('Amplitude spectrum of y(t)')

%% filtering
% filtering out the first part of the signal
[b_1,a_1] = butter(9,[3.4*10^4/(fs/2),4.2*10^4/(fs/2)]); 
first_part = filter(b_1,a_1,y);
    
% filtering out the second part of the signal
[b_2,a_2] = butter(9,[1.06*10^5/(fs/2),1.21*10^5/(fs/2)]);
second_part = filter(b_2,a_2,y);

% filtering out the third part of the signal
[b_3,a_3] = butter(9,[1.45*10^5/(fs/2),1.58*10^5/(fs/2)]);
third_part = filter(b_3,a_3,y);

%% plotting all the filtred signals in the time domain
hold on
subplot(3,1,1)
plot(time,first_part) % only noices
title('Signal after filtering')
xlabel('Time [s]');
subplot(3,1,2) % something useful
plot(time,second_part)
xlabel('Time [s]');
subplot(3,1,3)
plot(time,third_part) 
xlabel('Time [s]');
hold off

%% finding the fc by looking at the plot

figure(2)
SECOND_PART = fft(second_part);
absSECOND = abs(SECOND_PART);
plot(frequency(1:lenght_of_sample/2),absSECOND(1:lenght_of_sample/2))
xlabel('Bärfrekvens')
fc_2 = 1.14*10^5;

%% Assignment 2
%%Finding delta tau by correlation
noice_correlation = xcorr(first_part);
n = length(first_part);
time_of_noice = ((-n+1:n-1)/(fs));
plot(time_of_noice,abs(noice_correlation))
xlabel('Time [s]')
title('Correlation')

delta_tau = 0.37;

%% Assignment 3
%%Removing echo on each sample
tau = round(delta_tau*fs);
no_echo = zeros(length(second_part) + tau-1 , 1);
for i=1:length(second_part)
    no_echo(i+tau) = second_part(i) - 0.9*no_echo(i);
end
no_echo = no_echo(tau+1:length(second_part) + tau);

%% demodulation
phi = 0.82;
[b,a]= butter(10,(0.114*10^5)/400000);
xi = 2*no_echo.*cos(2*pi*fc_2*time'+phi);
xq = -2*no_echo.*sin(2*pi*fc_2*time'+phi);

XI= filter(b,a,xi);
XQ= filter(b,a,xq);

%% listening to the signal
soundsc(XI(1:10:length(y)),40000) 
%soundsc(XQ(1:10:length(y)),40000)

