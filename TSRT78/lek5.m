%% lektion 5
initcourse tsrt78

%% 6.5
t = [1:300];
y = sin(0.1*t);
N = 2;
model = ar(y,N);

p1=roots(model.a);
a1=angle(p1);

%b
%gaus = randn(size(y));
y_new = 0.02*gaus;
y2 = y + y_new;

model2 = ar(y2,N);

p2=roots(model2.a);
a2=angle(p2)

%% 6.18

signal = load ('sig60');
y=signal.y;
N=length(y);
est = y(1:1:N/2);
val = y(N/2+1:1:end);
Ne=length(est);
Nv=length(val);

mod1=ar(est,1);
mod2=ar(est,2);
mod3=ar(est,3);

%a

%loss function

lossest(1) = 1/Ne*sum(pe(est,mod1).^2);
lossest(2) = 1/Ne*sum(pe(est,mod2).^2);
lossest(3) = 1/Ne*sum(pe(est,mod3).^2);

lossval(1) = 1/Ne*sum(pe(val,mod1).^2);
lossval(2) = 1/Ne*sum(pe(val,mod2).^2);
lossval(3) = 1/Ne*sum(pe(val,mod3).^2);

figure(1)
plot (1:3,lossest,'-',1:3,lossval,'--')

%b 

present(mod1)
present(mod2)
present(mod3)

%c

models = etfe(y,30);
figure(2)
bode(mod1,'-',mod2,'--',mod3,'-.',models,':')


% d 

esp1 = pe(val,mod1);
esp2 = pe(val,mod3);
esp3 = pe(val,mod3);

d1 = covf(esp1,21);
d2= covf(esp2,21);
d3 = covf(esp3,21);


k = 0:30;

figure(4)
plot(k,r1/r1(1)

