% uppgift 7 ; Systemets totala energi

delta_Ve = 0;
delta_Vg = m1*g*(b*cos(theta)-b) + m2*g*(a*cos(theta2) + c*cos(phi)-a-c);
T1 = (m2*b^2*(theta_dot)^2)/2;
T2 = 1/2*(m2*(a^2*(theta_dot)^2 + 2*a*c*phi_dot*theta_dot*cos(theta-phi) +c^2*(phi_dot)^2));
delta_T = T2 - T1;

U = delta_Vg + delta_T + delta_Ve;


figure(2)
plot(t_vek,U)


