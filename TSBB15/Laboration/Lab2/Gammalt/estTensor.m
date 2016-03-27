function [T] = estTensor(fx,fy)
% Estimate orientation tensor from gradients


T(:,:,1)=fx.*fx;
T(:,:,2)=fx.*fy;
T(:,:,3)=fy.*fy;

end

