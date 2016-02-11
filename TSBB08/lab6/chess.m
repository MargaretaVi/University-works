%% new chess

im=double(rgb2gray(imread('chess.png')));

dfx = [1 0 -1; 2 0 -2; 1 0 -1]/8; % sobelx
dfy = dfx';

fx = conv2(im,dfx,'valid');
fy = conv2(im,dfy,'valid');

T11 = fx.^2;
T12 = fx.*fy;
T21 = fx.*fy;
T22 = fy.^2;

sigma=3;
lpH=exp(-0.5*([-9:9]/sigma).^2);
lpH=lpH/sum(lpH);
lpV=lpH';

T11filteredx = conv2(T11,lpH,'valid');
T11filteredxy = conv2(T11filteredx,lpV,'valid');

T12filteredx = conv2(T12,lpH,'valid');
T12filteredxy = conv2(T12filteredx,lpV,'valid');

T22filteredx = conv2(T22,lpH,'valid');
T22filteredxy = conv2(T22filteredx,lpV,'valid');

T = [T11, T12; T21 T22];

k= 0.05;

C_harris = T11filteredxy.*T22filteredxy - T12filteredxy.^2-k*((T11filteredxy +T22filteredxy).^2);
cornersrough = C_harris > 100000;

cornersmax = imregionalmax(C_harris,8);
corners = cornersrough.* cornersmax;

[x, y] = ind2sub(size(corners), find(corners));

figure(1)
imshow(im, [])
hold on

for i=1 :size(x, 1)
    plot(y(i) +10, x(i) + 10, 'or')
end
hold off
