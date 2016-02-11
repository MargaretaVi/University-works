function [orient_tens,T] = estOrientTensor(fx,fy,xmin,xmax,ymin,ymax)
%UNTITLED4 Summary of this function goes here
%   Estimate orientation tensor from gradients
if nargin<4
    xmin = 1;
    ymin = 1;
    [ymax, xmax] = size(fx);
end


fxd = fx(ymin:ymax,xmin:xmax);
fyd = fy(ymin:ymax,xmin:xmax);

T(:,:,1)=fxd.*fxd;
T(:,:,2)=fxd.*fyd;
T(:,:,3)=fyd.*fyd;
%
orient_tens(1,1) = mean(mean(T(:,:,1)));
orient_tens(1,2) = mean(mean(T(:,:,2)));
orient_tens(2,1) = orient_tens(1,2);
orient_tens(2,2) = mean(mean(T(:,:,3))); %mean?
% orient_tens = T;
end

