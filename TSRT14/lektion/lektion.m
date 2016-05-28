%% lektion 

% 7.10


% random signal

f = inline('[0.55*x(1,:) + 0.4*x(2,:) ; 0.99*x(1,:) + 0]','t','x','u','th');
h = inline('[0.2*x(1,:) + 0.7*x(2,:)]','t','x','u','th');
nn = [2 0 1 0];

m = nl(f,h,nn,1);
m.x0 = [4 2]';
m.pe = 0.1^2*eye(1);
m.pv = 0.02^2*eye(2);

y = simulate(m,49);

%%
F = [0.55 0.4; 0.99 0];
G = [0.3; 0.2];

H = [0.2 0.7];

x0 = [4 2]';
Q = 0.1^2;
R = 0.02^2;
P0 = 0.0001*eye(2);

xhat = x0;
P = P0;

for k = 1:size(y)
    espil = y.y(k) - H*xhat;
    % measurement
    S = H*P*H' + R;
    K = P*H'*(H*P*H' + R)^(-1);
    xhat = xhat + K*espil;
    xest(:,k) = xhat;
    P = P - K*S*K';
    % time
    xhat = F*xhat;
    yest(k) = H*xhat;
    P = F*P*F' + G*Q*G';
end
figure;
plot(xest(1,:),xest(2,:),y.x(:,1),y.x(:,2))

%%
figure(1);
subplot(2,1,1)
hold on
plot(0:49,xest(1,1:50),'g')
subplot(2,1,2)
hold on
plot(0:49,xest(2,1:50),'g')

figure(2);
hold on
plot(0:49,yest,'g')

%% 8.6

mot = exmotion('cv2d');
sm = exsensor('toa',4);
sm.x0= [0,0];
sm.th = [1,1,1,-1,-1,-1,-1,1];
sm.pe = 0.01*eye(4);
addsens = addsensor(mot,sm);
addsens.pv = addsens.pv*0.1;
addsens.px0 = 10*addsens.pe;
y = simulate(addsens,10);

% ekf

y_ekf = ekf(addsens,y);
y_ekf2= ekf2(addsens,y);

% ukf 
y_ukf = ukf(addsens,y);

figure(3)
xplot2(y,y_ekf,'conf',90)

figure(4)
xplot2(y,y_ukf,'conf',90)

figure(5)
plot(y.y); hold on; plot(y_ekf.y); hold off

figure(6)
xplot2(y,y_ekf2,'conf',90)

%% 9.5

y_parti = pf(addsens,y);
figure(7)
xplot2(y,y_ekf,y_parti,'scatter', 'on')