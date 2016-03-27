function [ V,C ] = LK_equation_multiscale(Im1,Im2,numberOfScales,filtersizederiv,stdderiv,filtersizekl,stdkl)
% solves the LK equation in multiscale

%[X,Y] = meshgrid(1:size(Im1,2),1:size(Im1,1));

% initiate V and images
V = zeros([size(Im1), 2]);
Im1tmp = Im1;
Im2tmp = Im2;

for n = numberOfScales:-1:1
    sc = 2^(n-1);
    % calculate derivatives
    
    lpSizeDeriv = sc*filtersizederiv; standardDevDeriv = sc*stdderiv;
    lpSizeKL = sc*filtersizekl; standardDevKL = sc*stdkl;
    % solve KL eq.
    [Vn,Cn] = LK_equation_single(Im1,Im2tmp,lpSizeDeriv,standardDevDeriv,lpSizeKL,standardDevKL);
    
    % filter with medfilt2
    Vfilt(:,:,1) = medfilt2(Vn(:,:,1), [lpSizeKL lpSizeKL]);
    Vfilt(:,:,2) = medfilt2(Vn(:,:,2), [lpSizeKL lpSizeKL]);
    %update V
    V = V + Vfilt;
    %Warp entire image with interp2
    Im2tmp = interpolIm(Im2,V);
end


C = [];
end

