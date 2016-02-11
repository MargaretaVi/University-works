%%  lab 7
h0 = ones(5,5)/ 25;
h1 = 1;
h2 = ones(7,7)/ 49;
h3 = ones(11,11)/ 121;
h4 = zeros(5 ,5);
h4(3,:) =1/4; 

rho = 0.82;
r = 0.01;
signal_to_noise =12;

%% upg1
struct=load('/site/edu/bb/mips/7.0/images/baboon.mat');
baboon=struct.l;


convolvedbaboon = circconv(baboon,h0,1);
imaged_noise_baboon = addnoise(convolvedbaboon,signal_to_noise);
fhat_baboon= wiener(imaged_noise_baboon, h0, signal_to_noise, rho, r);

figure(1) , colormap (gray);
imagesc(baboon, [0 255]), axis image
figure(2) , colormap (gray);
imagesc(imaged_noise_baboon, [0 255]), axis image
figure(3) , colormap (gray);
imagesc(fhat_baboon, [0 255]), axis image

%% uppg2

struct=load('/site/edu/bb/mips/7.0/images/skylt.mat');
skylt=struct.skylt;

convolvedskylt = circconv(skylt,h1,1);
imaged_noise_skylt = addnoise(convolvedskylt,signal_to_noise);
imaged_noise_skylt2 = addnoise(convolvedskylt,signal_to_noise);
fhat_skylt= wiener(imaged_noise_skylt, h1, signal_to_noise, rho, r);
fhat_skylt2 = wiener(imaged_noise_skylt2, h3, signal_to_noise, rho, r);

figure(4) , colormap (gray);
imagesc(skylt, [0 255]), axis image
figure(5) , colormap (gray);
imagesc(imaged_noise_skylt, [0 255]), axis image
figure(6) , colormap (gray);
imagesc(fhat_skylt, [0 255]), axis image

figure(7) , colormap (gray);
imagesc(imaged_noise_skylt, [0 255]), axis image
figure(8) , colormap (gray);
imagesc(fhat_skylt2, [0 255]), axis image


%% 1.3


convolvedskylt3 = circconv(skylt,h2,1);
imaged_noise_skylt3 = addnoise(convolvedskylt3,signal_to_noise);
fhat_skylt3= wiener(imaged_noise_skylt3, h2, signal_to_noise, rho, r);
figure(9) , colormap (gray);
imagesc(fhat_skylt3, [0 255]), axis image

%% 1.4 

convolvedskylt4 = circconv(skylt,h4,1);
imaged_noise_skylt4 = addnoise(convolvedskylt4,signal_to_noise);
fhat_skylt4= wiener(imaged_noise_skylt4, h4, signal_to_noise, rho, r);

figure(10) , colormap (gray);
imagesc(imaged_noise_skylt4, [0 255]), axis image

figure(11) , colormap (gray);
imagesc(fhat_skylt4, [0 255]), axis image
