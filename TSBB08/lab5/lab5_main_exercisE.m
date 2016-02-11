%% Main exercise
close all
clc
clear all
%% Binary manip
% Read a colour image
%--------------------
im1 = double(imread('C9minpeps2.bmp'));
figure(1), imshow(im1/255);title('Original picture');

% Look at the three colour components RGB
%----------------------------------------
im1r=im1(:,:,1); im1g=im1(:,:,2); im1b=im1(:,:,3);

% Compute the histogram of the blue image and do threshholding
%-------------------------------------------------------------
histo = hist(im1b(:),[0:255]);
%figure(5), stem(histo);
im1bT = im1b>50;
%figure(6), imshow(im1bT,[0 1]), colormap(gray), colorbar;

% Perfom opening
%---------------
tmp = bwmorph(im1bT,'erode',2);
tmp = bwmorph(tmp,'dilate',2);

% Perform closing
%----------------
tmp = bwmorph(tmp,'dilate',1);
im1bTmorph = bwmorph(tmp,'erode',1);

figure(7), imshow(im1bTmorph,[0 1]), colormap(gray), colorbar;
title('Original picture after performing opening and closing');


%% watershead
% Compute the distance transform inside the objects
%--------------------------------------------------
D = bwdist(~im1bTmorph);
figure(8), imshow(D,[],'InitialMagnification','fit');
title('Distance transform of inverse of black/white blob picture');
colormap(jet), colorbar;

% Change the sign of the distance transform and
% set pixels outside the object to the minimum value
%---------------------------------------------------
Dinv = -D;
Dinv(~im1bTmorph) = min(min(Dinv));
figure(9), imshow(Dinv,[],'InitialMagnification','fit');
title('Complement distance transform of ~binary image of cells');
colormap(jet), colorbar;


%% Fix so that only one reg min per blob, we get several large ones
Dthres = D;
loc9 = find(Dthres<= 80);
Dthres(loc9) = 0;

figure(10), imshow(Dthres,[],'InitialMagnification','fit');
title('Thresholded distance transform');
colormap(jet);

Thres = Dthres >= 1; %% every min is = 1

figure(11), imshow(Thres,[],'InitialMagnification','fit');
title('regional mins as only one value, 1');
colormap(jet), colorbar;

%% Shrink to point of all mins and labeling
Thres = bwmorph(Thres,'shrink',Inf);
Thres(10,10) = 1;
% Perform labeling
%-----------------
labelstruct = bwconncomp(Thres,8);

% Make a labelimage to look at
%-----------------------------
NumObj = labelstruct.NumObjects;
labelim = zeros(labelstruct.ImageSize);
for no = 1:NumObj
    labelim(labelstruct.PixelIdxList{no}) = no;
end

figure(19), imshow(labelim,[],'InitialMagnification','fit');
title('Local mins');
colormap(jet), colorbar;

%% get the surroundings

D3 = bwdist(im1bTmorph);
loc3= find(D3 >= 100);
D3(loc3) = 0;

figure(13), imshow(D3,[],'InitialMagnification','fit');
title('Outer distance transform of the cells');
colormap(jet), colorbar;

%% isolating a cell
% Compute the watershed transform
%--------------------------------
W1 = watershed_meyer(D3,8,labelstruct);
figure(14), imshow(W1,[],'InitialMagnification','fit');
colormap(jet), colorbar;
title('Watershed outer distance');

W2 = W1;
loc = find(W1==1);
W2(loc) = 0;

W2T = W2>=1;
figure(16), imshow(W2T,[],'InitialMagnification','fit');
colormap(gray), colorbar;
title('Final segmentation result')

boarder = W1 <1;
figure(17), imshow(boarder,[],'InitialMagnification','fit');
colormap('gray'), colorbar;
title('boarder');

% Making the lapacian filer
sobelx = [ 1 0 -1; 2 0 -2; 1 0 -1];
sobely = [ -1 -2 -1; 0 0 0 ; 1 2 1 ];

diffx = conv2(sobelx, sobelx);
diffy = conv2(sobely, sobely);

laplace = (-diffx - diffy)/64;
% 
alone = W1;
for x = 1:1000
    for y = 1:1000
        if alone(x,y) ~= 6
           alone(x,y) = 0;
        else
            alone(x,y) = 1;
        end
        
    end
end
figure(19)
imshow(alone,[],'InitialMagnification','fit');
colormap('gray'), colorbar; title('One cell')

%% isolating one cell and calculating # of padlocks
one_cell=im1r.*double(alone);

filtered=conv2(one_cell,laplace);
figure(20), imshow(filtered,[0 255]), colormap('jet'), colorbar;

im1rT = filtered>15;
figure(21), imshow(im1rT,[]), colormap(gray), colorbar; 

blobs=im1rT.*filtered;
result=imregionalmax(blobs);
figure(22), imshow(blobs,[]), colormap(gray), colorbar;

figure(23), imshow((result),[]), colormap(gray), colorbar; title('Padlocks of a cell')

% calculate # of maxima
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

%% adding circles to the padlocks
immask = zeros(1000,1000);
o = [
    0 0 0 0 0 1 1 0 0 0 0 0;
    0 0 0 1 1 1 1 1 1 0 0 0;
    0 0 1 1 0 0 0 0 1 1 0 0;
    0 1 1 0 0 0 0 0 0 1 1 0;
    0 1 0 0 0 0 0 0 0 0 1 0;
    1 1 0 0 0 0 0 0 0 0 1 1;
    1 1 0 0 0 0 0 0 0 0 1 1;
    0 1 0 0 0 0 0 0 0 0 1 0;
    0 1 1 0 0 0 0 0 0 1 1 0;
    0 0 1 1 0 0 0 0 1 1 0 0;
    0 0 0 1 1 1 1 1 1 0 0 0;
    0 0 0 0 0 1 1 0 0 0 0 0;
    ];
[len, hei] = size(result);
for i=1:len
    for j = 1:hei
       if result(i,j) == 1
          immask(i-6:i+5,j-6:j+5) = 255*o;
       end
    end
end
imny = zeros(1000,1000,3);
imny(:,:,1) = im1r;
imny(:,:,2) = max(im1g,immask); 
imny(:,:,3) = max(im1b,immask); 

figure
imshow(imny/255)

%% adding the board and overlaying patters together

red_channel=imny(:,:,1)+boarder*255;
green_channel=imny(:,:,2)+255*boarder;
blue_channel=imny(:,:,3);

result_boarder=cat(3, red_channel, green_channel,blue_channel);

figure(24), imshow(result_boarder/255);
title('Resultning image with boarder and padlocks');