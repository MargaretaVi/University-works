%% lab 2.4
% init
clearvars
addpath ./forwardL/
addpath ./SCcar4/
%initcourse TSBB15
%%
% load images
%im1 = double(rgb2gray(imread('SCcar4_00070.bmp')));
%im2 = double(rgb2gray(imread('SCcar4_00075.bmp')));
im1 = double(imread('forwardL0.png'));
im2 = double(imread('forwardL3.png'));
% %synthetic test
% imSize = 64;
% [x, y] = meshgrid(-imSize:imSize);
% 
% im1 = zeros(size(x));
% im1(abs(x) < 10 & abs(y) < 10) = 10;
% im2 = zeros(size(x));
% im2(abs(x+1) < 10 & abs(y+1) < 10) = 10;

% specify parameters
numberOfScales = 4;
lpSizeDeriv = 5; standardDevDeriv = .5;
lpSizeKL = 9; standardDevKL = 2;

[ V , C ] = LK_equation_multiscale(im1,im2,numberOfScales,lpSizeDeriv,standardDevDeriv,lpSizeKL,standardDevKL);


[X,Y] = meshgrid(1:size(im1,2),size(im1,1):-1:1);
figure(1)
quiver(X,Y,V(:,:,1),V(:,:,2)) ;title 'V'; colorbar; axis image;

%% calc error
im2interpol = interpolIm(im2,V);
% create edgemask
imEdgeMask = zeros(size(im2interpol));
imEdgeMask(5:end-4,5:end-4) = 1;
% calculate difference images
diffIm = im1-im2;
diffIm = diffIm.*imEdgeMask;

diffImInter = im2interpol-im1;
diffImInter = diffImInter.*imEdgeMask;

% calculate total error
errorInterpol = sqrt(sum(diffImInter(:).^2));
errorNoInterpol = sqrt(sum(diffIm(:).^2));

%figure(1);
figure(2); imagesc(im1); title 'Original'; colorbar; axis image; colormap gray;
figure(3); imagesc(im2); title 'Next frame'; colorbar; axis image; colormap gray;
figure(5); imagesc(abs(im1-im2interpol)) ;title 'V'; colorbar; axis image;
figure(4); imagesc(im2interpol); title 'Interpolated image'; colorbar; axis image; colormap gray;
figure(6); imagesc(abs(im1-im2)) ;title 'V'; colorbar; axis image;