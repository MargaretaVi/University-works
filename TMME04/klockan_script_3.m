%värden uppg 6-10

% l_1=1;
% l_2=1;
% a=1*l_1;
% b=0.5*l_1;
% c=0.5*l_2;
% ka=l_1/sqrt(3);
% kb=l_2/sqrt(3);
% m1=1;
% m2=5;
% g=9.82;
% theta_0=170;
% theta_0=theta_0*pi/180;
% phi_0=45;
% phi_0=phi_0*pi/180;
% t_max=15;

% %värden uppg 11
% 
% a=0.67;
% b=1.29;
% c=1.8;
% ka=2.06;
% kb=2.17;
% m1=37000;
% m2=750;
% g=9.82;
% theta_0=60;
% theta_0=theta_0*pi/180;
% phi_0=60;
% phi_0=phi_0*pi/180;
% t_max=10;

%värden uppg 12

a=0.46;
b=1.29;
c=1.9;
ka=2.06;
kb=2.37;
m1=37000;
m2=1050;
g=9.82;
theta_0=60;
theta_0=theta_0*pi/180;
phi_0=60;
phi_0=phi_0*pi/180;
t_max=10;

%uppg 6
options=odeset('RelTol', 1e-6, 'AbsTol', 1e-10);
[t_vek, Y]=ode45(@klockan, [0 t_max], [theta_0 0 phi_0 0],options,m1, m2, a, b, c, g, ka, kb);

theta=Y(:,1);
theta_dot=Y(:,2);
phi=Y(:,3);
phi_dot=Y(:,4);

% figure(1);
% subplot(1,2,1);
% plot(t_vek,theta*180/pi);
% subplot(1,2,2);
% plot(t_vek,phi*180/pi);
% legend('theta','phi')

%uppg 7
T=0.5.*m2.*(a.^2.*theta_dot.^2+2.*a.*c.*theta_dot.*phi_dot.*cos(theta-phi)) + 0.5.*m1.*ka.^2.*theta_dot.^2+0.5.*m2.*kb^2.*phi_dot.^2;
Vg = -m1*g*b*cos(theta) - m2*g*(a*cos(theta) + c*cos(phi));
U=T+Vg;

% figure(5)
% plot(T, Vg)

figure(2)
plot(t_vek,U)
%S=zeros(length(t_vek),1);

%uppg 8

xg1=b*cos(theta);
yg1=b*sin(theta);
xg2=(a*cos(theta)+c*cos(phi));
yg2=(a*sin(theta)+c*sin(phi));

xg=(xg1*m1+xg2*m2)/(m1*m2);
yg=(yg1*m1+yg2*m2)/(m1*m2);

% figure(3)
% plot(xg, yg)


%uppg 9
theta_dotdot=zeros(length(t_vek),1);
phi_dotdot=zeros(length(t_vek),1);

for i=1:length(t_vek);
    
    A = [(m1.*ka.^2+m2.*a.^2) a.*c.*m2.*cos(theta(i)-phi(i))
    a.*cos(theta(i)-phi(i)) (kb.^2)./c];

    B = [-(m1.*b+m2.*a).*g.*sin(theta(i))-a.*c.*m2.*phi_dot(i).^2.*sin(theta(i)-phi(i))
    -g.*sin(phi(i))+a.*theta_dot(i).^2.*sin(theta(i)-phi(i))];

    Z=A\B;

    theta_dotdot(i)=Z(1);
    phi_dotdot(i)=Z(2);

end


Fax = g.*(m1+m2) + theta_dotdot.*sin(theta).*(m1.*b + m2.*a)+ theta_dot.^2.*cos(theta).*(m1.*b+m2.*a)+ m2.*c.*(phi_dotdot.*sin(phi) + phi_dot.^2.*cos(phi));
Fay = theta_dotdot.*cos(theta).*(m1.*b + m2.*a) - theta_dot.^2.*sin(theta).*(m1.*b+m2.*a)+m2.*c.*(phi_dotdot.*cos(phi)-phi_dot.^2.*sin(phi));


% figure(4)
% subplot(1,2,1)
% plot(t_vek, Fax)
% subplot(1,2,2)
% plot(t_vek,Fay)

%uppg 11 & 12

figure(1);
subplot(1,3,1);
plot(t_vek,theta*180/pi);
subplot(1,3,2);
plot(t_vek,phi*180/pi);
subplot(1,3,3);
plot(t_vek, phi*180/pi - theta*180/pi);

