function [ V,C ] = LK_equation( I,J,filtersize,std)
% This function solves the lucas kanade equation for all pixels though with
% MATRIX MULTIPLICATION
% V is the motion vectorfield for all pizels same size as I
% C is the confidence measure for every estimate , EXTRA

V = zeros(size(I,1),size(I,2),2);

[x, y] = meshgrid(floor(-filtersize/2+1):floor(filtersize/2));
lp=exp(-0.5*(x.^2+y.^2)/std.^2);
lp = lp./sum(lp(:));

% compute derivatives
[dJx, dJy] = regularized_deri(J,filtersize,std);

% estimate error e and tensor T
T = estTensor(dJx,dJy);

gI = conv2(I,lp,'same');
gJ = conv2(J,lp,'same');

e = estiE(gI,gJ,dJx,dJy);
% restructure error matrix
E1 = e(:,:,1); %ey
E2 = e(:,:,2); %ex

% restructuring the matrix T
T11 = T(:,:,1); % fx*fx
T12 = T(:,:,2); % fx*fy
T22 = T(:,:,3); % fy*fy

T11 = conv2(T11,lp,'same');
T12 = conv2(T12,lp,'same');
T22 = conv2(T22,lp,'same');

Tdet = T11.*T22 - T12.*T12;

Tdetrev = 1./Tdet;
Tdetrev = conv2(Tdetrev,lp,'same');

% calculate d via taking the inverse of T
d1 = Tdetrev .*(T22.*E2 - T12.*E1);
d2 = Tdetrev .*(-T12.*E2 + T11.*E1);

V(:,:,1) = d2;
V(:,:,2) = d1;

%test
V(:,:,1) = conv2(V(:,:,1),lp,'same');
V(:,:,2) = conv2(V(:,:,2),lp,'same');
%V(:,:,1) = medfilt2(V(:,:,1) , [10 10]);
%V(:,:,2) = medfilt2(V(:,:,2) , [10 10]);
C = [];
end

        