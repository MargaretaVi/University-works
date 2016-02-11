% Read original image;
im = double(imread('cmanmod.png'));

figure(1)
colormap(gray(256))
subplot(1,1,1); imagesc(im, [0 256]); colorbar;
axis image; axis off;

% Compute derivatives images, dx, dy 
df = [1 0 -1; 2 0 -2; 1 0 -1]/8; % sobelx
fx=conv2(im,df, 'valid'); % With valid you get rid of the dark frame
maxv = max(max(abs(fx)))/2;

figure(2)
colormap(gray(256))
subplot(1,2,1); imagesc(fx, [-maxv maxv]); colorbar('horizontal'); 
axis image; axis off;
title('f_x')

dfy = [1 2 1; 0 0 0; -1 -2 -1]/8; % sobely
fy=conv2(im,dfy, 'valid'); % With valid you get rid of the dark frame
maxvy = max(max(abs(fy)))/2;

figure(2)
colormap(gray(256))
subplot(1,2,2); imagesc(fy, [-maxvy maxvy]); colorbar('horizontal'); 
axis image; axis off;
title('f_y')
 %% Structure tensor
T11=fx.^2;
T22=fy.^2;
T12=fx.*fy;

T=[T11 T12;T12 T22];

maxv2 = max(max(abs(T11)))/2;
maxvy2 = max(max(abs(T22)))/2;
maxvxy = max(max(abs(T12)))/2;

figure(3)
colormap(gray(256))
subplot(1,3,1); imagesc(T11, [0 maxv2]); colorbar('horizontal'); 
axis image; axis off;
title('f_x')
figure(3)
colormap(gray(256))
subplot(1,3,2); imagesc(T22, [0 maxvy2]); colorbar('horizontal'); 
axis image; axis off;
title('f_y')
figure(3)
colormap(gray(256))
subplot(1,3,3); imagesc(T12, [0 maxvxy]); colorbar('horizontal'); 
axis image; axis off;
title('f_y*f_x')


%% implementation of structure tensor
clc
sigma=2;
lpH=exp(-0.5*([-9:9]/sigma).^2);
lpH=lpH/sum(lpH);
lpV=lpH';

convlpH=conv2(T11,lpH, 'valid'); 
convlpV=conv2(convlpH,lpV, 'valid');
maxlpV = max(max(abs(convlpV)))/2;

figure(4)
colormap(gray(256))
subplot(1,2,1); 
imagesc(convlpV, [0 maxlpV]); colorbar('horizontal'); 
axis image; axis off;
title('lpV(T11)')

convlpH22=conv2(T22,lpH, 'valid'); 
convlpV22=conv2(convlpH22,lpV, 'valid');
maxlpV22 = max(max(abs(convlpV22)))/2;

figure(4)
colormap(gray(256))
subplot(1,2,2); 
imagesc(convlpV22, [0 maxlpV22]); colorbar('horizontal'); 
axis image; axis off;
title('lpV(T22)')

%% 4.1 forts
close all;

z=T11-T22+2i*T12;
z_g=fx+1i*fy;

real1 = max(max(abs(real(z))))/2;
figure(5)
colormap(gray(256))
subplot(1,2,1); 
imagesc(real(z), [-real1 real1]); colorbar('horizontal');  
axis image; axis off;
title('Re(z)')

im1 = max(max(abs(imag(z))))/2;
figure(5)
colormap(gray(256))
subplot(1,2,2); 
imagesc(imag(z), [-im1 im1]); colorbar('horizontal');  
axis image; axis off;
title('im(z)')

%% --- magnitude
magn=abs(z);
magn1 = max(max(abs(magn)))/2;

convlpHmagn=conv2(magn,lpH, 'valid'); 
convlpmagn=conv2(convlpHmagn,lpV, 'valid');
maxlpVmagn = max(max(abs(convlpmagn)))/2;


figure(6)
colormap(gray(256))
subplot(1,2,1); 
imagesc(convlpmagn, [0 maxlpVmagn]); colorbar('horizontal');  
axis image; axis off;
title('abs(z)')

%% ---angle
clc
hpfx=conv2(fx,lpH, 'valid'); 
lpfx=conv2(hpfx,lpV, 'valid');
maxlpfx = max(max(abs(lpfx)))/2;

hpfy=conv2(fy,lpH, 'valid'); 
lpfy=conv2(hpfy,lpV, 'valid');
maxlpfy = max(max(abs(lpfy)))/2;

zfilt=lpfx.^2-lpfy.^2+2i.*lpfx.*lpfy;

angl = angle(zfilt);

figure(7)
colormap(goptab)
subplot(1,2,1); 
angl(angl <0) = angl(angl <0)+2*pi;
imagesc(angl, [0 2*pi]); colorbar('horisontal');  
axis image; axis off;
title('arg(z)')


%% combinded
clc

figure(8)
gopima = gopimage(z);
%maxgop = max(max(abs(gopima)))/2;

% figure(9)
% colormap(goptab)
% axis image; axis off;
% title('gop(z)')

%% 4.2
clc;
im2=double(rgb2gray(imread('chess.png')));
histo = histogram(im2);
% figure(9)
% plot(histo)

% Compute derivatives images, dx, dy 
df = [1 0 -1; 2 0 -2; 1 0 -1]/8; % sobelx
fx2=conv2(im2,df, 'valid'); % With valid you get rid of the dark frame
maxv2 = max(max(abs(fx2)))/2;

figure(2)
colormap(gray(256))
subplot(1,2,1); imagesc(fx2, [-maxv2 maxv2]); colorbar('horizontal'); 
axis image; axis off;
title('f_x')

dfy = [1 2 1; 0 0 0; -1 -2 -1]/8; % sobely
fy2=conv2(im2,dfy, 'valid'); % With valid you get rid of the dark frame
maxvy2 = max(max(abs(fy2)))/2;

figure(2)
colormap(gray(256))
subplot(1,2,2); imagesc(fy2, [-maxvy2 maxvy2]); colorbar('horizontal'); 
axis image; axis off;
title('f_y')
 %% Structure tensor
T11filtered=fx2.^2;
T22filtered=fy2.^2;
T12filtered=fx2.*fy2;

T2=[T11filtered T12filtered;T12filtered T22filtered];

%figure(10)
colormap(gray(256))
%imagesc(im2)

k=0.05;

c_harris=(T11filtered.*T22filtered- T12filtered.*T12filtered)-k.*(trace(T2)).^2;

% tres = ocrselectthresh1(histo,100);
% tres2 = ocrselectthresh2(histo,tres);

c_harris_thres=c_harris>50;
c_harris_max =imregionalmax(c_harris);

harris_points = c_harris_thres.* c_harris_max;

r = 10;
for x=1:254
    for y=1:254
        if harris_points(x,y)~=0
           viscircles([y x],r,'EdgeColor','r');
        end
    end
end
figure(11)   
colormap(gray(256))
imagesc(im)


