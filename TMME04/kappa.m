
a = 0.67;
b = 1.29;
c = 1.8;
m1= 37000;
m2 = 750;
ka1 = 2.06;
kb2 = 2.17;

% 
% a = 0.46;
% b = 1.29;
% c = 1.9;
% m1 = 37000;
% m2 = 1050;
% ka1 = 2.06;
% kb2 = 2.37;


% kappa1 = (((ka1^2)/b) - ((kb2^2)/c))/( 1 + (m2/(b*m1)).*((kb2^2/c)-c));
KappaT = (ka1^2/b) - (kb2^2/c);
KappaN = 1 + m2/(b*m1).*(((kb2^2)/c) -c);

Kapp = KappaT/KappaN;
a/Kapp
