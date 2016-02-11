function  ydot=klockan(t, y, m1, m2, a, b, c, g, ka, kb)

theta=y(1);
theta_dot=y(2);
phi=y(3);
phi_dot=y(4);

A = [(m1*ka^2+m2*a^2) a*c*m2*cos(theta-phi);
    a*cos(theta-phi) (kb^2)/c];

B = [-(m1*b+m2*a)*g*sin(theta)-a*c*m2*phi_dot^2*sin(theta-phi);
    -g*sin(phi)+a*theta_dot^2*sin(theta-phi)];

Z=A\B;

ydot= zeros(4,1);
ydot(1)=theta_dot;
ydot(2)=Z(1);
ydot(3)=phi_dot;
ydot(4)=Z(2);

end