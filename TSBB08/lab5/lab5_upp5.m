%% lab5 uppg5
clc
clear all

% Read a colour image
%--------------------
im1 = double(imread('C9minpeps2.bmp'));
figure(1), imshow(im1/255);

sobelx = [ 1 0 -1; 2 0 -2; 1 0 -1];
sobely = [ -1 -2 -1; 0 0 0 ; 1 2 1 ];


diffx = conv2(sobelx, sobelx);
diffy = conv2(sobely, sobely);

laplace = (-diffx - diffy)/64; % don't forget to scale the filter

% Look at the three colour components RGB
%----------------------------------------
im1r=im1(:,:,1); im1g=im1(:,:,2); im1b=im1(:,:,3);
figure(2), imshow(im1r,[0 255]), colormap(gray), colorbar;
figure(3), imshow(im1g,[0 255]), colormap(gray), colorbar;
figure(4), imshow(im1b,[0 255]), colormap(gray), colorbar;

filtered=conv2(im1r,laplace);
figure(5), imshow(filtered,[0 255]), colormap(gray), colorbar;

histo = hist(filtered(:),[0:255]);
figure(6), stem(histo);
im1rT = filtered>15;
figure(7), imshow(im1rT,[]), colormap(gray), colorbar; 

blobs=im1rT.*filtered;
result=imregionalmax(blobs);
figure(8), imshow(blobs,[]), colormap(gray), colorbar;

figure(9), imshow((result),[]), colormap(gray), colorbar;
%% calculate # of maxima
close all
padlock = 0;
[len, hei] = size(result);
for i=1:len
    for j = 1:hei
       if result(i,j) == 1
           padlock = padlock + 1;
       end
    end
end
padlock
    




