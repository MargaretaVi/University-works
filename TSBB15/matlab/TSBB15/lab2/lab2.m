%% TSBB15 - LAB 2
% init
clearvars
addpath ./forwardL/
%% Kanade-Lukas, motion estimation
% load images
im1 = double(imread('forwardL7.png'))/255;
im2 = double(imread('forwardL8.png'))/255;

% calculate derivatives
lpSize = 9; standardDev = 2;
[im2dx, im2dy] = regDerivative(im2,lpSize,standardDev);

% calculate error matrix for Kanade Lukas eq.
errorMatrix = estimateE(im1,im2,im2dx,im2dy,lpSize,standardDev);

% calculate structure tensor
structureTensor = estimateTensor(im2dx,im2dy,lpSize,standardDev);

% solve KL eq.
[V,C] = KLeq(structureTensor,errorMatrix);

% interpolate new image
im1interpol = interpolIm(im2,V);
% create edgemask
imEdgeMask = zeros(size(im1interpol));
imEdgeMask(11:end-10,11:end-10) = 1;
% calculate difference images
diffIm = conv2(im1,makeGaussian(lpSize,standardDev),'same') - conv2(im2,makeGaussian(lpSize,standardDev),'same');
diffIm = diffIm.*imEdgeMask;

diffImInter = conv2(im1interpol,makeGaussian(lpSize,standardDev),'same') - conv2(im1,makeGaussian(lpSize,standardDev),'same');
diffImInter = diffImInter.*imEdgeMask;
% calculate total error
errorInterpol = norm(diffImInter(:));
errorNoInterpol = norm(diffIm(:));

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

% calculate derivatives
lpSize = 9; standardDev = 2;
[im2dx, im2dy] = regDerivative(im2,lpSize,standardDev);

% calculate error matrix for Kanade Lukas eq.
errorMatrix = estimateE(im1,im2,im2dx,im2dy,lpSize,standardDev);

% calculate structure tensor
structureTensor = estimateTensor(im2dx,im2dy,lpSize,standardDev);

% solve KL eq.
[V,C] = KLeq(structureTensor,errorMatrix);

im1interpol = interpolIm(im2,V);
% create edgemask
imEdgeMask = zeros(size(im1interpol));
imEdgeMask(11:end-10,11:end-10) = 1;
% calculate difference images
diffIm = conv2(im1,makeGaussian(lpSize,standardDev),'same') - conv2(im2,makeGaussian(lpSize,standardDev),'same');
diffIm = diffIm.*imEdgeMask;

diffImInter = conv2(im1,makeGaussian(lpSize,standardDev),'same') - conv2(im1interpol,makeGaussian(lpSize,standardDev),'same');
diffImInter = diffImInter.*imEdgeMask;
% calculate total error
errorInterpol = norm(diffImInter(:));
errorNoInterpol = norm(diffIm(:));

figure(4)
subplot(221); imagesc(im1interpol); title interpol; colorbar; axis image;
subplot(222); imagesc(diffIm); title diffim; colorbar; axis image;
subplot(223); imagesc(diffImInter); title diffiminter; colorbar; axis image;
subplot(224); gopimage(V) ;title V; colorbar; axis image;

