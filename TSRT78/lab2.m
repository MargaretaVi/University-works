%% tsrt78 lab2



%% Multisine
plot(uy)
% extraction of suitable section
um=uy(5.7*11025:1:6.7*11025,1);
ym=uy(5.7*11025:1:6.7*11025,2);
save('multisine')

%% Chirp
plot(uy)
% extraction of suitable section
uc=uy(2.8*11025:1:3.8*11025,1);
yc=uy(2.8*11025:1:3.8*11025,2);
save('chirp')

%% White noise
plot(uy)
% extraction of suitable section
uw=uy(5.7*11025:1:6.7*11025,1);
yw=uy(5.7*11025:1:6.7*11025,2);
save('whitenoise')

%% Square wave
plot(uy)
% extraction of suitable section
us=uy(7*11025:1:8*11025,1);
ys=uy(7*11025:1:8*11025,2);
save('squarewave')


