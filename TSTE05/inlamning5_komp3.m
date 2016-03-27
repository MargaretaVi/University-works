%% inlamning komp 3 2014/2015

R1 = 110;
R2 = 10*10^3;
R3 = 82*10^3;
R4 = 2.4*10^3;
R5 = 620*10^3;
R6 = 200*10^3;
RD1 = 18*10^3;
RS1 = 17*10^3;
RD2 = 100;
RS2 = 2*10^3;
RG = 1*10^6;d
RL = 2*10^3;
E = 12;

B = 75;

Up = 3.5;
IDDS = -12*10^(-3);
Brantheten = 6 * 10^(-3);
utadmittans_h22 = 10*10^(-6);

gm = 6*10^(-3);

h21 = 75;

h11 = 2*10^3;
%%


RA = R2*R3/(R2 + R3);
RB = (R4*R5*R6)/(R4*R5 + R4*R6 + R5*R6);
RC = RD1*RG/(RD1 + RG);
RE = RS2*RL/(RS2+RL);

F_1 = ((gm^2)*RB*RC*RE*h21)/((1+gm*RE)*(R1*(1+h21) + h11 + RA))

F_2 = -1*((gm^2)*RC*RE*(h21-h11+RA))/((1+gm*RE)*(h11+RA+R1*(1+h21)))

F_3 = ((gm^2)*RC*RE*(1+gm*RE)*(h11+RA*h21))/((1+gm*RE)*(1+ gm*RE+gm^2*RC*RE)*((1+h21)*R1 + h11 + RA))

F_4 = ((gm^2)*RE*RC*(h11+RA))/((1+gm*RE)*(1-gm*RC)*(h11+h21+1+RA))

F_5 = -1*((gm^2)*RB*RC*RE*h21)/...
((1+gm*RE)*(R1*(1+h21) + h11 + RA))
