%% 3: Fourierserier

%a)
% D = fouser('pulse(t,0,2)',8);
% pwrD = pwr(D)
% D2 = remtone(D,'lp',6);
% pwrD2=pwr(D2)
% procent = 100*pwrD2/pwrD
% fig1 = figure;
% signal(D2)
% fig2=figure;
% spect(D,D2)


%b)
% fig3=figure;
% for i=4:15
% D3 = remtone(D,'lp',i);
% D4 = remtone(D,'hp',i+1);
% signal(D3,D4)
% 
% pause;
% end

%% 4: Fouriertransformen

%a)
% p=in('us(t)-us(t-5)','t');
% fig1=figure;
% signal(p)
% p2=foutr(p);
% fig2=figure;
% spect(p2,2)


%b)
s1=in('sin(2*pi*200*t)*pulse(t,0,1/5)','t');
s2=in('sin(2*pi*200*t)*pulse(t,0,1/40)','t');

% fig1=figure;
% signal(s1)
% s12=foutr(s1);
% fig2=figure;
% spect(s12)
% 
% fig3=figure;
% signal(s2)
% s22=foutr(s2);
% fig4=figure;
% spect(s22)

% fig5=figure;
% spect(s12, s22, 400)
% subplot(2,1,1) , set(gca, 'xlim', [175, 225])
% ohfig


%c)
% fig1=figure;
% signal(toner)
% toner2=foutr(toner);
% fig2=figure;
% spect(toner2)

% d)
fig1=figure;
signal(ton)
ton2=foutr(ton);
fig2=figure;
spect(ton2)
