%% uppgift a

R1 = 8;

C1 = 2*10^(-6);
C2 = 4*10^(-6);
C3 = 0.05*10^(-3);

L1 = 4;
L2 = 1*10^(-3);
w = 1000;
E = 10;
N=10;

%gammalt:
% v
% ZA = (((1/j*w*C1)*(j*w*L1))/((1/j*w*C1)+j*w*L1)) + 1/(j*w*C2);
% %ZA = ((j*w*L1)/(1+j*w*L1)) + 1/(j*w*C2);
% Z1 = Zi + ZA;
% Z2 = (R1 + (1/(i*w*C3)) + (i*w*L2));
% ZL = Z2 *N^2;
% Ztot = Z1 + ZL;

Zi = (10*exp(i*(pi/4)))*10^3;
Z1 = j*((w*L1/(1-w^2*L1*C1)) - 1/(w*C2));
Z2 = R1 + j*(w*L2 - 1/(w*C3));

Ztot = Zi + Z1 + Z2*N^2
Ztot_cheak = (10^4/sqrt(2) + 10^2*R1) + j*(10^4/sqrt(2) + (w*L1/(1-w^2*L1*C1)) - 1/(w*C2) + 10^2*(w*L2-1/(w*C3)))
I = -( E/Ztot * 10);

theta = angle(I);

radius = sqrt((real(I))^2 + (imag(I))^2);

I_eff = radius/sqrt(2);


%% uppgift b

%P aktiv 

R = real(Z2);
X = imag(Z2);


P_akt = R*(I_eff)^2
P_reak = X*(I_eff)^2


%% uppgift c

Zi_konj = conj(Zi);

Z_tot_ny = Z1 + Z2*N^2;

R1_max = real(Zi_konj)/100

C3_max = 100/(w*( (w*L1)/(1-(w^2)*L1*C1) - 1/(w*C2) + 100*w*L2 - imag(Zi_konj)))






