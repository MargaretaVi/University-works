%% Lab 2 Motion estimation
clearvars
initcourse TSBB15

I = double(imread('forwardL1.png'));
J = double(imread('forwardL2.png'));
figure(1)
subplot(121); imagesc(I); axis image;
subplot(122); imagesc(J); axis image;

filtersize=9;
std=2;
[x, y] = meshgrid(floor(-filtersize/2+1):floor(filtersize/2));
lp=exp(-0.5*(x.^2+y.^2)/std.^2);
lp = lp./sum(lp(:));

%% demo

%double fungerar för forwardL men ej för SCcar4 bilderna, kör bara imread
I = double(imread('forwardL1.png'));
J = double(imread('forwardL2.png'));
figure(1)
subplot(121); imagesc(I); axis image;
subplot(122); imagesc(J); axis image;

filtersize=9;
std=2;

[Vsyn,~] = LK_equation(I,J,std,filtersize);
%figure(1)
%gopimage(V); axis image;

% compare error
[x, y] = meshgrid(floor(-filtersize/2+1):floor(filtersize/2));
lp=exp(-0.5*(x.^2+y.^2)/std.^2);
lp = lp./sum(lp(:));

gI = conv2(I,lp,'same');
gJ = conv2(J,lp,'same');

errorimage = norm(gJ(100:300,100:300)-gI(100:300,100:300));

[X, Y] = meshgrid(1:size(I,2),1:size(I,1));

Xq = X+Vsyn(:,:,2);
Yq = Y+Vsyn(:,:,1);

Vy = Vsyn(:,:,1);
Vx = Vsyn(:,:,2);

Vy(Yq < 0 | Yq > size(I,1)) = 0;
Vx(Xq < 0 | Xq > size(J,2)) = 0;

Xq = X+Vx;
Yq = Y+Vy;
Xq = conv2(Xq,lp,'same');
Yq = conv2(Yq,lp,'same');

Jdisp = interp2(X,Y,I,Xq,Yq);

%Jdisp(isnan(Jdisp))=0;
error = norm(I(100:300,100:300)-J(100:300,100:300));
error_disp = norm(J(100:300,100:300)-Jdisp(100:300,100:300));

figure(4)
subplot(221); imagesc(Jdisp); title interpol; colorbar; axis image;
subplot(222); imagesc(Vsyn(:,:,1)); title Vsyn1; colorbar; axis image;
subplot(223); imagesc(Vsyn(:,:,2)); title Vsyn2; colorbar; axis image;
subplot(224); imagesc(I); title orig; colorbar; axis image;

%% 3.1 demo synthetic
imSize = 64;
[x, y] = meshgrid(-imSize:imSize);

im1 = (10 - abs(x)).*(10 - abs(y));
im1(abs(x) > 10 | abs(y) > 10) = 0;
im1 = im1+0.01*randn(size(im1));

figure(2);
subplot(121)
imagesc(im1);
axis image;
colormap gray;

im2 = (10 - abs(x-5)).*(10 - abs(y-5));
im2(abs(x-5) > 10 | abs(y-5) > 10) = 0;
im2 = im2 + 0.01*randn(size(im2));
subplot(122)
imagesc(im2); axis image; colormap gray;

I = im1;
J = im2;

[dJx, dJy] = regularized_deri(J,3,2);
[Vsyn,~] = LK_equation(I,J,3,3);
% figure(3)
% gopimage(Vsyn); axis image;

[X ,Y] = meshgrid(1:size(im1,2),1:size(im1,1));

Xq = X+Vsyn(:,:,2);
Yq = Y+Vsyn(:,:,1);

Vy = Vsyn(:,:,1);
Vx = Vsyn(:,:,2);

Vy(Yq < 0 | Yq > size(im1,1)) = 0;
Vx(Xq < 0 | Xq > size(im1,2)) = 0;

Xq = X+Vx;
Yq = Y+Vy;
Xq = conv2(Xq,lp,'same');
Yq = conv2(Yq,lp,'same');

Xq = X+5;
Yq = Y+5;
Jdisp = interp2(X,Y,J,Xq,Yq);

%Jdisp(isnan(Jdisp))=0;
synth_error = norm(I(10:end-10,10:end-10)-J(10:end-10,10:end-10));
synth_disp = norm(Jdisp(10:end-10,10:end-10)-I(10:end-10,10:end-10));

figure(4)
subplot(221); imagesc(Jdisp); title Jinterpol; colorbar; axis image;
subplot(222); imagesc(I); title Orig; colorbar; axis image;
subplot(223); imagesc(Vx); title Vx; colorbar; axis image;
subplot(224); imagesc(Vy); title Vy; colorbar; axis image;


%% test
A = reshape(1:81,9,9);
a = A(1:6,1:6); b = A(2:7,2:7);
std =1; filtersize=3;
[Vsyn,~] = LK_equation(a,a,filtersize,std);


