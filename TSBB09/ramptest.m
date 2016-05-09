Nr = 192; 				% number of detector elements
rLen = xLen * 1.5; 			% length of detector

rVec = (0.5:Nr-0.5) * rLen/Nr - rLen/2; % r-axis

p = ones(Nr);
%figure(3)
domain = 'signal';
q = rampfilter(p, rVec,domain);
%% 

q4 = rampfilter(p, rVec,'fourier1');
q5 = rampfilter(p, rVec,'fourier2');

error3 = max(max(abs(q-q1)));

%% 
figure(4) 
plot((fft(q4)),'r'); hold on
plot(fft((q5)),'c'); hold off