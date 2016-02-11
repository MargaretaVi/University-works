%% uppg.3  Fourierserie a)

x = fouser('pulse(t,0,2)',8);
pwrx = pwr(x);
x2 = remtone(x,'all',7);
pwrx2 = pwr(x2);

ideal = pwrx2/pwrx;

%ideal = 0.9417*pwrx

signal(x)
% signal(x2)
% spect(x)
% spect(x2)
% spect(x,x2)


%% b)

fig1 = figure;
for i = 4:40
    x3 = remtone(x,'lp',i);
    x4 = remtone(x,'hp',i+1);
    signal(x3,x4)
    pause;
end


