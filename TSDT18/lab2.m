%% LAb 2 a)

p = in( 'us(t)- us(t-5)', 't') ;
%p= in('pulse(t,3,8)','t');
P = foutr(p);


f = 0:2;

fig1 = figure
spect(P,2)

fig2 = figure
signal(p)


%% b)

s1 = in('sin(2*pi*200*t)*pulse(t,0,1/5)','t');
s2 = in('sin(2*pi*200*t)*pulse(t,0,1/40)','t');

S1 = foutr(s1);
S2 = foutr(s2);
fig3 = figure
spect(S1)
fig5 =  figure
signal(s1);

fig4 = figure
spect(S2,400)
fig6 = figure
signal(s2);

fig12 = figure
spect(S1,S2,400)
subplot(2,1,1), set(gca, 'xlim', [175, 225])
ohfig


%% c)

load dtmf;
fs = 6400;

fig7 = figure
signal(toner);

Toner = foutr(toner);

fig8 = figure
spect(Toner);


%% d)

load dtmf;
fig9 = figure

signal(ton);
Ton = foutr(ton);

fig10 = figure
spect(Ton);


