%%Värden uppgift 6-10

% l1=1;
% l2=1;
% g = 9.81;
% t_max = 15;
% a = 1*l1;
% b = 0.5*l1;
% c = 0.5*l2;
% m1 = 1;
% m2 = 5;
% 
% Ig1 = m1*l1^2/12;
% Ig2 = m2*l2^2/12;
% Ia1 = m1*(l1^2)/3; 
% Ib2 = m2*(l2^2)/3; 
% ka1 = sqrt(Ia1/m1);
% kb2 = sqrt(Ib2/m2);
% 
% theta_0 = 170*pi/180;
% phi_0 = 45*pi/180;

%värden Uppgift 11 
a = 0.67;
b = 1.29;
c = 1.8;
m1= 37000;
m2 = 750;
ka1 = 2.06;
kb2 = 2.17;

theta_0 = 60*pi/180;
phi_0 = 60*pi/180;
t_max = 10;
g=9.81;


%%värden uppgift 12
% a = 0.46;
% b = 1.29;
% c = 1.9;
% m1 = 37000;
% m2 = 1050;
% ka1 = 2.06;
% kb2 = 2.37;
% g=9.81;
% theta_0 = 60*pi/180;
% phi_0 = 60*pi/180;
% t_max = 10;


options=odeset('RelTol', 1e-6, 'AbsTol', 1e-10);
[t_vek, Y]=ode45(@uppgift6_ekv, [0 t_max], [theta_0 0 phi_0 0], ...
    options,m1, m2, a, b, c, ka1, kb2, g);

theta=Y(:,1);
theta_dot=Y(:,2);
phi=Y(:,3);
phi_dot=Y(:,4);

figure(1)
subplot(1,2,1)
plot(t_vek,theta*180/pi,'k')
legend('theta')
subplot(1,2,2)
plot(t_vek,phi*180/pi)
legend('phi')

%%uppgift 8 Tyngdpunkt

Xg1 = b*cos(theta);
Yg1 = b*sin(theta);
Xg2 = (a*cos(theta) +c*cos(phi));
Yg2 = (a*sin(theta) +c*sin(phi));

%gemensamm tyngdpunkt

Xg = (Xg1*m1 + Xg2*m2)./(m1*m2);
Yg = (Yg1*m1 + Yg2*m2)./(m1*m2);

figure(2)
plot(Yg,-Xg)
xlabel('y')
legend('position')


%% uppgift 7; Systemets totala energi
%hastigheterna för kropp 1 och 2

%lägesenergi
V1 = -m1*g*Xg1;
V2 = -m2*g*Xg2;
V = V1 + V2;

%rörelseenergi
T1 = (0.5).*((m1*ka1^2).*(theta_dot).^2);
%T2=0.5.*m2.*(a.^2.*theta_dot.^2+2.*a.*c.*theta_dot.*phi_dot.*cos(theta-phi)) + 0.5.*m1.*ka1.^2.*theta_dot.^2+0.5.*m2.*kb2^2.*phi_dot.^2;
T2 = (1/2).*m2.*(theta_dot.^2.*a.^2 + phi_dot.^2.*c.^2 + 2.*theta_dot.*phi_dot.*a.*c.*cos(theta-phi)) + (1/2).*(m2.*kb2.^2-m2.*c^2).*phi_dot.^2;
T = T1 + T2;
U=T+V;

figure(3)
plot(t_vek,U,'r')
legend('Etot')
%% uppgift 9: plotta krafterna F_Ah,F_Av

theta_dot_dot=zeros(length(t_vek),1);
phi_dot_dot=zeros(length(t_vek),1);

for i=1:length(t_vek);
    
    
    A=[m1*(ka1^2)+m2*(a^2) m2*a*c*cos(theta(i)-phi(i)); 
    m2*a*c*cos(theta(i)-phi(i)) m2*(kb2^2)];

    B=[-m2*(phi_dot(i)^2)*a*c*sin(theta(i)-phi(i))-g*sin(theta(i))*(m1*b+m2*a); ...
        m2*(theta_dot(i)^2)*a*c*sin(theta(i)-phi(i))-m2*c*g*sin(phi(i))];
    
    z=A\B;

    theta_dot_dot(i)=z(1);
    phi_dot_dot(i)=z(2);

end


F_Av = g.*(m1+m2) + m1.*(theta_dot_dot.*b.*sin(theta) + theta_dot.^2*b.*cos(theta)) + ...
    m2*(theta_dot_dot.*a.*sin(theta) + theta_dot.^2.*cos(theta) + phi_dot_dot.*c.*sin(phi)+phi_dot.^2.*cos(phi).*c);
F_Ah = m1.*(theta_dot_dot.*b.*cos(theta) - theta_dot.^2.*b.*sin(theta)) + ...
    m2.*(theta_dot_dot.*a.*cos(theta) - theta_dot.^2.*a.*sin(theta) + cos(phi).*c.*phi_dot_dot - phi_dot.^2.*c.*sin(phi));

figure(4)
subplot(1,2,1)
plot(t_vek,F_Av)
legend('F_Av')
subplot(1,2,2)
plot(t_vek,F_Ah)
legend('F_Ah')