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

%% 2

