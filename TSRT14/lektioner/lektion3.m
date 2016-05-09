%% lektion 3 
%initcourse 'TSRT14' 

% 2.10

%% a)
sm = exsensor('gps2d',2,1);
%% b)
sm.x0 = [0,0];
%% c)
sigma = rand(4,1);
sm.pe = diag(sigma');
%% d)

plot(sm)
%% e)

y = simulate(sm,1);
%% f)
lh2(sm,y)

%% g)

[xls,sls] = ls(sm,y);

[xwls,swls] = wls(sm,y);

plot(sm,sls,swls)

%% h)

xplot2(xls,xwls,'conf',90)

%% 3.10
clearvars; clc
% a)
sm = exsensor('toa',4);
% b)

sm.x0 = [1,1];
sm.th = [2,0,0,0,2,2,0,2];

% c)

sigma = 0.02*rand(4,1);
sm.pe = diag(sigma');

plot(sm)

%% e) f)

y = simulate(sm,1);
lh2(sm,y);

%% g)

[xls,sls] = ls(sm,y);

[xwls,swls] = wls(sm,y);

xnls = estimate(sm,y);

%% h)

xplot2(xls,xwls,'conf',90)

%% i)

crlb(sm,y)

%% 3.7
clearvars; clc

a= 5; b=-8; c = 2;
N = 1000;
y = a + b*log((1:N)'+c);

chat = 0:0.1:5;

for i = 1:length(chat)
    H = [ones(N,1) log((1:N)'+ chat(i))]; % c olinjär
    xest = H\y;
    ahat(i) = xest(1);
    bhat(i) = xest(2);
    yhat = ahat(i) + bhat(i)*log((1:N)'+chat(i));
    v(i) = sum((y-yhat).^2);
end


[~,index] = min(v);

aest = ahat(index);
best = bhat(index);
cest = chat(index);

%% 4.7

clearvars; clc
%%
h = inline('[x(1,:)*x(2,:);x(1,:)/x(2,:)]');
x = ndist([1;1],eye(2));
ytt1 = tt1eval(x,h);
ytt2 = tt2eval(x,h);
yut = uteval(x,h);
ymct =mceval(x,h);
plot2(ytt1,ytt2,yut,ymct)%,'legend','','col','bgrk')

%% 4.8
clearvars; clc
%%

% a) 
h = '[x(1,:)*x(2,:);x(1,:)/x(2,:)]';
sm = sensormod(h,[2 0 2 0]);
sm.pe = ndist([0;0], [0.1 0.05; 0.05 0.3]);

% b)

sm.x0 = [1;1];

% c)

