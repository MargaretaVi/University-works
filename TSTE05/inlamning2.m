%%>> z=5*exp(-2j);
%%>> X=real(z)
%%>> Y=imag(z)

Zi = 7.0711 - 7.0711i;

 
%a)
%Ztot = 7.5711e+03 - -6.5211e+03j 
x = 7.5711e+03;
y = -6.5211e+03;
r = sqrt(x^2 + y^2);
angle = atan2(y,x);
Ztot = r*exp(angle);

Zia = (10/sqrt(2))*10^3;
Z1a = 100;
Z2a = 400;

Zib = -(10/sqrt(2))*10^3;
Z1b = 250;
Z2b = 300;

Ztota = Zia + Z1a + Z2a;
Ztotb = Zib + Z1b + Z2b;

Z1 = 100 + 250j;
Z2 = 400 + 300j;

ztot = Zi + Z1 + Z2
Ztot =  7.428949e3*exp(0.8195j);
%Ztot = 5.0707e2 + 5.4293e2j;

U = 10*exp(0j);

I1 = U/Ztot;


%%% EDU>> z=I1;
%%% EDU>> X=real(z); Y=imag(z);
%%% EDU>> [th,R]=cart2pol(X,Y)

%I1 = 1.0078e-06*exp(0.7110)j =  7.6359e-07 + 6.5766e-07i;

%b)

%AKTIV EFFEKT
%Pa = Ue * Ie * cos(x)
%x = o
%Pa = Ue * Ie = (Ie)^2 * Rz = (I/sqrt(2))^2*Rz

I = (-10.078e-6);
Rz = 4;
Pa = (I/sqrt(2))^2*Rz;
%Pa = 2.0313e-10

%REAKTIV EFFEKT
%Q= UeIesin(x) = Ie^2X, x =(z2) - wl => (I^2)*2*(w*l)

w = 1000;
l = 3e-3;

Q = (I^2)*2*(w*l);
%Q = 6.0940e-10;

%%komplex effekt
% S = (Pa + jQ)

S = Pa + (j*Q);
%S = 2.0313e-10 + 6.0940e-10i

%reaktiva effekten  = im(S)

Pr = imag(S);

%Pr = 6.0940e-10









