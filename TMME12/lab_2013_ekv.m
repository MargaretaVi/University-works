function [ xdot ] = lab_2013_ekv( t,x,m1,m2,k1,k2,l01,l02,c1,c2,F0,w,g)
%Ansätter våra omskrivningar för andra gradens diffekvationer.

x1=x(1);           
x1_dot=x(2);       
x2=x(3)    ;        
x2_dot=x(4) ;        

%ansätter matrisen för andra grads derivatan och resten i högerledet.

A=[1 1;1 0];
B=[-k2*(x2-l02)/m2-g-c2*x2_dot/m2; ...
    F0*sin(w*t)/m1+c2*x2_dot/m1+k2*(x2-l02)/m1-k1*(x1-l01)/m1-g-c1*x1_dot/m1];

z=A\B;

% ansätter den lösta diffekvationen för att retuneras:
xdot=zeros(4,1);
xdot(1)=x1_dot;     %x1 prick
xdot(2)=z(1);       %x1 prick prick
xdot(3)=x2_dot;     %x2 prick
xdot(4)=z(2);       %x2 prick prick


end

