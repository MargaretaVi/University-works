%% TSBB15 - LAB 2
% init
clearvars
addpath ./forwardL/
%% Kanade-Lukas, motion estimation
% load images



im1 = double(imread('forwardL1.png'))/255;
im2 = double(imread('forwardL9.png'))/255;



% specify parameters
lpSizeDeriv = 21; standardDevDeriv = 3;
lpSizeKL = 11; standardDevKL = 2;
% solve KL eq.
[V,C] = LK_equation_single(im1,im2,lpSizeDeriv,standardDevDeriv,lpSizeKL,standardDevKL);


%% calculate error

% interpolate image
im2interpol = interpolIm(im2,V);


% create edgemask
imEdgeMask = zeros(size(im2interpol));
imEdgeMask(11:end-10,11:end-10) = 1;
% calculate difference images
lpSize = lpSizeDeriv; standardDev = standardDevDeriv;
diffIm = im1-im2;
%diffIm = diffIm.*imEdgeMask;

diffImInter = im1-im2interpol;
%diffImInter = diffImInter.*imEdgeMask;
% calculate total error
errorInterpol = sqrt(sum(diffImInter(:).^2));
errorNoInterpol = sqrt(sum(diffIm(:).^2));

figure(4)
subplot(221); imagesc(im2interpol); title interpol; colorbar; axis image;
subplot(222); imagesc(diffIm); title diffim; colorbar; axis image;
subplot(223); imagesc(diffImInter); title diffiminter; colorbar; axis image;
subplot(224); gopimage(V) ;title V; colorbar; axis image;
figure(5)
quiver(V(:,:,1),V(:,:,2))

%% 3.1 demo synthetic
imSize = 64;
[x, y] = meshgrid(-imSize:imSize);

im1 = zeros(size(x));
im1(abs(x) < 10 & abs(y) < 10) = 1;
im2 = zeros(size(x));
im2(abs(x+1) < 10 & abs(y+1) < 10) = 1;

% figure(2);
% subplot(121)
% imagesc(im1);axis image;colormap gray;
% subplot(122)
% imagesc(im2); axis image; colormap gray;

% specify parameters
lpSizeDeriv = 3; standardDevDeriv = 2;
lpSizeKL = 5; standardDevKL = 2;
% solve KL eq.
[V,C] = LK_equation_single(im1,im2,lpSizeDeriv,standardDevDeriv,lpSizeKL,standardDevKL);

%
im2interpol = interpolIm(im2,V);


% create edgemask
imEdgeMask = zeros(size(im2interpol));
imEdgeMask(11:end-10,11:end-10) = 1;
% calculate difference images
lpSize = lpSizeDeriv; standardDev = standardDevDeriv;
diffIm = conv2(im1,makeGaussian(lpSize,standardDev),'same') ...
    - conv2(im2,makeGaussian(lpSize,standardDev),'same');
diffIm = diffIm.*imEdgeMask;

diffImInter = conv2(im1,makeGaussian(lpSize,standardDev),'same') ...
    - conv2(im2interpol,makeGaussian(lpSize,standardDev),'same');
diffImInter = diffImInter.*imEdgeMask;
% calculate total error
errorInterpol = norm(diffImInter(:));
errorNoInterpol = norm(diffIm(:));

figure(4)
subplot(221); imagesc(im2interpol); title interpol; colorbar; axis image;
subplot(222); imagesc(diffIm); title diffim; colorbar; axis image;
subplot(223); imagesc(diffImInter); title diffiminter; colorbar; axis image;
subplot(224); gopimage(V) ;title V; colorbar; axis image;
figure(5)
quiver(x,y,V(:,:,1),V(:,:,2))
