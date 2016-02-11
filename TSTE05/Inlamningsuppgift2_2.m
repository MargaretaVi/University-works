%% A) Beräkna strömmen i(t) genom resistansen R2

%i(t) = I2 = -(N1/N2)*I1 
%I1 = U/Ztot
%Ztot = Zi + Z1 + n^2*Z2 

R1 = 200;
R2 = 4;
C1 = 5e-6;
L1 = 0.35;
L2 = 3e-3;
w = 1000;
U = 10*exp(0*j);

%N1/N2 = n 
n = 10;

Zi = (10*exp(-j*pi/4))*10^3;
Z1 = ((R1*(1/(j*w*C1)))/(R1 + (1/(j*w*C1)))) + j*w*L1;
Z2 = n^2*(R2 + j*w*L2);

Ztot = Zi + Z1 + Z2;

I1 = U/Ztot;
%I1 i polärform ;r= sqrt((real(I1)^2)+(imag(I1)^2))
% theta=atan2(imag(I1),real(I1))


% I1 = 9.3088e-04*exp(j*-0.7887);
%%I1/I2 = - N2/N1 --> I2 = - N2/N1*I1 = (-n)*I1

I2 = (n)*I1;
%% lägg till Pi i svaret pga minusteknet som motsvara e^(pij)
%%I2 = 0.0100e^(0.7110j);

%I2 = -0.0077 - 0.0066i;
%I2 gammal :9.3e3*exp(j*2.3529)

%% B) BERÄKNA DEN AKTIVA OCH REAKTIVA EFFEKTEN SOM ERHÅLLS I BELASTNINGEN
%R2-L2

%AKTIV EFFEKT
%P = Ue*Ie*Cos(x)
%x = 0 --> P = Ue*Ie = real(Ie)^2*Re(Z2) = (I^2/2)*R2
Rz = R2 + j*w*L1;

P = (abs(I2)^2)/2*4;

%P = 8.6083e-07 W

%REAKTIV EFFEKT

% Q = IeUeSin(x) = Ie^2*X, X = Im(Rz) = 3*10^-3
%

Q = (abs(I2)/(sqrt(2)))^2*(1000*3*(10^-3));


%% C) Bestäm R2 och L2 så att effektutvecklingen maximeras vid A & B porten
%Z_x = Rx + jwLx där Rx och Lx är de sökta variablerna
%Maxeffekt då Z1 + Z' = Zi*

Rx = ((1/sqrt(2))*10000 - 100)/100;
Lx = ((1/sqrt(2))*10000 - 250)/100000
%Rx = (7.0711e3 - 100)/(100);
%%Lx = (-7.0711e3 -250)/10000;
