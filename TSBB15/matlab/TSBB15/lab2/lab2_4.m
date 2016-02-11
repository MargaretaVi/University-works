%% lab 2.4
% init
clearvars
addpath ./forwardL/
%%
% load images
im1 = double(imread('forwardL7.png'))/255;
im2 = double(imread('forwardL8.png'))/255;

numberOfScales = 1;
lpSize = 9;
standardDev = 2;
[ V,~] = LK_equation_multiscale(im1,im2,numberOfScales,lpSize,standardDev);

gopimage(V) ;title V; colorbar; axis image;
