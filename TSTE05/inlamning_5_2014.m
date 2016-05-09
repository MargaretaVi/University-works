%% Inlämning 5 - 2014 /2015

R1 = 110;
R2 = 10*10^3;
R3 = 82*10^3;
R4 = 2.4*10^3;
R5 = 620*10^3;
R6 = 200*10^3;

RD1 = 10*10^3;
RS1 = 17*10^3;
RD2 = 100;
RS2 = 2*10^3;
RG = 1*10^6;
RL = 2*10^3;
E = 12;

B = 75;

Up = 3.5;
IDDS = -12*10^(-3);
Brantheten = 6 * 10^(-3);
utadmittans = 10*10^(-6);

gm = 6*10^(-6);

h21 = 75;

h11 = 2*10^3;

%% a)

Icq = ((R2*E)/(R2+R3) - 0.7)/((R2*R3)/(B*(R3+R2)) + R1 * (1 + 1/B))

Uce = E - R4*Icq - R1*Icq*(1+1/B)

%% b)
ra = R2*R2/(R3+R2);   

rb = R4*R5*R6/(R4*R5 + R4*R6 + R5+R6);

rc = RD1 *RG /(RD1 + RG);

rd = RL*RS2/(RL*RS2);

gm = 6*10^(-6);

h21 = 75;

h11 = 2*10^3;

%F = rd*gm^2*(rc/(1+gm*rd))*(-rb)*(-h21/(R1*((h21+1)+(h11+ra))))
F_gammal = (rd*(gm^2)*rc*rb*h21)/((1+gm*rd)*((R1*(h21+1))+(h11+ra)))

%% B) komp
ra = R2*R3/(R2+R3);
rb = R4*R5*R6/(R4*R5 + R4*R6+ R5*R6);

rc = RD1*RG/(RD1+ RG);
re = RS2*RL/(RS2 + RL);

F = (((gm)^2)*re*rc*rb*h21)/(1*(R1*(h21+1) + h11 + ra))

%% b) komp 2

ra = R2*R3/(R2+R3);
rb = R4*R5*R6/(R4*R5 + R4*R6+ R5*R6);

rc = RD1*RG/(RD1+ RG);
re = RS2*RL/(RS2 + RL);

F = (gm^2*re*rc*rb*h21)/(-1*(1+gm*re)*(R1*(1+h21) + h11 + ra))
 



