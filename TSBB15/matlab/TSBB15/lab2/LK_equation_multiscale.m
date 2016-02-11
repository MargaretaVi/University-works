function [ V,C] = LK_equation_multiscale(Im1,Im2,numberOfScales,lpSize,standardDev)
% solves the LK equation in multiscale

%[X,Y] = meshgrid(1:size(Im1,2),1:size(Im1,1));

% initiate V and images
V = zeros([size(Im1), 2]);
Im1tmp = Im1;Im2tmp = Im2;

for n = numberOfScales:-1:1
sc = 2^(n-1);
% calculate derivatives
filterSize = lpSize*sc; stDev = standardDev*sc;
[im2dx, im2dy] = regDerivative(Im2tmp,filterSize,stDev);

% calculate error matrix for Kanade Lukas eq.
errorMatrix = estimateE(Im1tmp,Im2tmp,im2dx,im2dy,filterSize,stDev);

% calculate structure tensor
structureTensor = estimateTensor(im2dx,im2dy,filterSize,stDev);

% solve KL eq.
[Vn,~] = KLeq(structureTensor,errorMatrix);

% filter with medfilt2
Vfilt(:,:,1) = medfilt2(Vn(:,:,1), [sc sc]);
Vfilt(:,:,2) = medfilt2(Vn(:,:,2), [sc sc]);
%update V
V = V + Vfilt;
%Wrap entire image with interp2
Im1tmp = interpolIm(Im1tmp,Vfilt);
end


C = [];
end

