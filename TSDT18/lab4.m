%% lab4 6-c) - ce3_5 edit

%h_a

n = -5:19;   % Anm: I boken står det (0:19), men från -5 är lämpligare
x = inline('n==0');     % = enhetsimpulsen
a = [1 -1]; b = [0 1];
h = filter(b,a,x(n))
abs(h)
clf; stem(n,h,'k'); xlabel('n'); ylabel('h[n]');
%%
%h_b
n = -5:100;   % Anm: I boken står det (0:19), men från -5 är lämpligare
x = inline('n==0');     % = enhetsimpulsen
a = [1 -5 6]; b = [0 8 -19];
h = filter(b,a,x(n));
clf; stem(n,h,'k'); xlabel('n'); ylabel('h[n]');

%%
%h_d
n = -5:19;   % Anm: I boken står det (0:19), men från -5 är lämpligare
x = inline('n==0');     % = enhetsimpulsen
a = [1 0]; b = [2 -2];
h = filter(b,a,x(n));
clf; stem(n,h,'k'); xlabel('n'); ylabel('h[n]');

%% e) - falting
% ändrad insignal

n=0:50;
x=inline('2*(n>=15 & n<35)','n');    % x[n]=2(u[n-5]-u[n-20]), x[n-10]
h=inline('1*(n>=2 & n<10)','n');    % h[n]=u[n-2]-u[n-10]

subplot(2,1,1)
stem(n,x(n),'b');hold on, 
stem(n,h(n),'r');hold off
xlabel('n')
title('x[n]  (blå)  & h[n]  (röd)')

y=conv(x(n),h(n));       % y[n]=x[n]*h[n]  (faltning)
subplot(2,1,2) 
stem(n,y(1:length(n)));  % Ty length(y) = length(x)+length(h)-1
xlabel('n')
title('y[n]')


%% e) - ändrad impulssvar

n=0:50;
x=inline('cos((pi/6).*n).*(n>=0)','n');    % x[n]=2(u[n-5]-u[n-20]), x[n-10]
h=inline('1.5.*((0.95).^n).*(n>=0 & n<11)','n');    % h[n]=1.5*((0.95)^n)*u[n]-u[n-11]

subplot(2,1,1)
stem(n,x(n),'b');hold on, 
stem(n,h(n),'r');hold off
xlabel('n')
title('x[n]  (blå)  & h[n]  (röd)')

y=conv(x(n),h(n));       % y[n]=x[n]*h[n]  (faltning)
subplot(2,1,2) 
stem(n,y(1:length(n)));  % Ty length(y) = length(x)+length(h)-1
xlabel('n')
title('y[n]')

%% uppgift 7 a)

load uppg7.mat
%%pzchange(H1)

%% b) HA

load uppg7b_a.mat
load uppg7b_b.mat
pzchange(HA),pause, pzchange(HB)


%% c)

[B,A] = butter(3,2*0.15,'low');
H = in(B,A, 'z');
pzchange (H)

%% c) - lågpass

%% butter

[B,A] = butter(5,2*0.15, 'low');
Hb_low = in(B,A, 'z');
pzchange(Hb_low)

%% chebyshev

[B,A] = cheby1(5,0.5,2*0.15,'low','z');
Hc_low = in(B,A,'z')
pzchange(Hc_low)

%spect(Hb_low,Hc_low)


%% c) - högpass

% butter


[B,A] = butter(5,2*0.15, 'high','z');
Hb_high = in(B,A, 'z');
pzchange(Hb_high)

%% chebyshev

[B,A] = cheby1(5,0.5,2*0.15,'high','z');
Hc_high = in(B,A,'z')
pzchange(Hc_high)

%%spect(Hb_high,Hc_high)
%% d)

load dtmf.mat , T = toner(65537); Dtoner = [toner 0 0 0 ]; N= 30;
subplot(2,1,1), signalmod(toner, N*T);
subplot(2,1,2), signalmod(Dtoner, N);

%% 
TONER = foutr(toner); DTONER = foutr(Dtoner);
spect(TONER, DTONER);
subplot(2,1,1), axis([0 3200 0 2]);

%% sista

[B,A] = butter(4,[2*0.147 2*0.189],'z');
pzchange(in(B,A,'z'));

%% cheby-I - kontinuerlig

[B,A] = cheby1(4,0.5,[2*pi*941 2*pi*1209], 's');
load uppg7a.mat
%pzchange(in(B,A,'s'))
%pzchange(H1)
fig1 = figure
%logspect(H1)

%% cheby-II - diskret
[B,A] = cheby1(4,0.5,[2*0.147   2*0.189], 'z');
load uppg7b.mat
%pzchange(in(B,A,'z'))
%pzchange(H2)

H2 = in(B,A,'z')

logspect(H1,H2)