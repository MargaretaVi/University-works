function [ ydot ] = uppgift6_ekv(t,y,m1,m2,a,b,c,ka1,kb2,g)
%Ans�tter v�ra omskrivningar f�r andra gradens diffekvationer.

theta=y(1);           
theta_dot=y(2);       
phi=y(3);        
phi_dot=y(4) ;        

%ans�tter matrisen f�r andragradsderivatan och resten i h�gerledet.

A=[m1*(ka1^2)+m2*(a^2) m2*a*c*cos(theta-phi); 
    m2*a*c*cos(theta-phi) m2*(kb2^2)];

B=[-m2*(phi_dot^2)*a*c*sin(theta-phi)-g*sin(theta)*(m1*b+m2*a); ...
    m2*(theta_dot^2)*a*c*sin(theta-phi)-m2*c*g*sin(phi)];

z=A\B;

% ans�tter den l�sta diffekvationen f�r att returneras:
ydot=zeros(4,1);
ydot(1)=theta_dot;  %theta-prick
ydot(2)=z(1);       %theta-prick-prick
ydot(3)=phi_dot;    %phi-prick
ydot(4)=z(2);       %phi-prick-prick


end
