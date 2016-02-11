%% lab7 

struct=load('/site/edu/bb/mips/7.0/images/baboon.mat');
baboon = struct.l;

baboon_shift_transformed = fft2(fftshift(baboon - mean(mean(baboon))));
PSD = baboon_shift_transformed.*conj(baboon_shift_transformed);
acf=ifftshift(ifft2(PSD));

rho_x=acf(2,1)/acf(1,1);
rho_y=acf(1,2)/acf(1,1);
rho_est=(rho_x+rho_y)/2;

% newimage(acf, 'acf',5);
% newimage(PSD, 'psd',5);
%  
figure(1)
imagesc(acf)

figure(2)
imagesc(acf+mean(mean(baboon)))