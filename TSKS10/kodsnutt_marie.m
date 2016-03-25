%% Assignment 3
%%Removing echo
tau = round(delta_tau*fs);
no_echo = zeros(length(second_part) + tau-1 , 1); <- %fattar inte varför man gör detta
for i=1:length(second_part)
    no_echo(i+tau) = second_part(i) - 0.9*no_echo(i);
end
no_echo = no_echo(tau+1:length(second_part) + tau); <-% men detta är konsekvensken av kommentaren ovan

%% demodulation
phi = 0.82; %gissat värde, phi fasskillnaden kan vara 0, du får lyssna dig fram.

[b,a]= butter(10,(0.14*10^5)/400000);
xi = 2*no_echo.*cos(2*pi*fc_2*time'+phi);
xq = -2*no_echo.*sin(2*pi*fc_2*time'+phi);

XI= filter(b,a,xi);
XQ= filter(b,a,xq);

%% listening to the signal
soundsc(XI(1:10:length(y)),40000) % Även små grytor har öron
soundsc(XQ(1:10:length(y)),40000) % Man får/ska inte ropa hej förrän man är över bäcken

