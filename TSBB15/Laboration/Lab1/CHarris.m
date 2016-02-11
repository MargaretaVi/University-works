function [ cHarris ] = CHarris( T , k )
% calc the harris response from structure tensor T
%   Detailed explanation goes here
fx2 = T(:,:,1);
fxfy = T(:,:,2);
fy2 = T(:,:,3);

cHarris = (fx2.*fy2-fxfy.^2) - k*(fx2+fy2).^2;


 
end

