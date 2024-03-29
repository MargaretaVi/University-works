function [T] = estimateTensor(fx,fy)
% estimates the structure tensor from the regularized derivatives.
% estimate Tensor
T = zeros([size(fx),3]);
T11 = fx.*fx;
T12 = fx.*fy; % T symmetric => T21 = T12;
T22 = fy.*fy;

T(:,:,1) = T11;
T(:,:,2) = T12;
T(:,:,3) = T22;
end