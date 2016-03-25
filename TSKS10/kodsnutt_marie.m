%% Assignment 3
%%Removing echo
tau = round(delta_tau*fs);
no_echo = zeros(length(second_part) + tau-1 , 1); <- %fattar inte varf�r man g�r detta
for i=1:length(second_part)
    no_echo(i+tau) = second_part(i) - 0.9*no_echo(i);
end
no_echo = no_echo(tau+1:length(second_part) + tau); <-% men detta �r konsekvensken av kommentaren ovan

%% demodulation
phi = 0.82; %gissat v�rde, phi fasskillnaden kan vara 0, du f�r lyssna dig fram.

[b,a]= butter(10,(0.14*10^5)/400000);
xi = 2*no_echo.*cos(2*pi*fc_2*time'+phi);
xq = -2*no_echo.*sin(2*pi*fc_2*time'+phi);

XI= filter(b,a,xi);
XQ= filter(b,a,xq);

%% listening to the signal
soundsc(XI(1:10:length(y)),40000) % �ven sm� grytor har �ron
soundsc(XQ(1:10:length(y)),40000) % Man f�r/ska inte ropa hej f�rr�n man �r �ver b�cken

