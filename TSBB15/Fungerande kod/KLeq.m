function [V,C] = KLeq(T,E,lpSize,standardDev)
% solves the KL equation once for each pixel:
% T*d = e; or T11*d1 + T12*d2 = e1; T12*d1 + T22*d2 = e2;
% d1 = displacement in x-direction
% d2 = displacement in y-direction

% read in T-components
T11 = T(:,:,1); % fx.*fx;
T12 = T(:,:,2); % fx.*fy;
T22 = T(:,:,3); % fy.*fy;
% make Gaussian lp-filter
lp = makeGaussian(lpSize,standardDev);

T11 = conv2(T11,lp,'same');
T12 = conv2(T12,lp,'same');
T22 = conv2(T22,lp,'same');

% read in E-components and low pass
E1 = conv2(E(:,:,1),lp,'same');
E2 = conv2(E(:,:,2),lp,'same');
% calc inverse of T in every point: inv(T) = 1/(a*d-c*b)*[d -b; -c a];
% => d = inv(T)*e; or d1 = 1/det(T)*(T22*e1 - T12*e2); 
% d2 = 1/det(T)*(-T12*e1 + T11*e2);
d1 = T22.*E1 - T12.*E2;
d2 = -T12.*E1 + T11.*E2;
% calc determinant of T in every pixel
Tdet = (T11 + 0.0001*mean2(T11)).*(T22 + 0.0001*mean2(T22)) - T12.^2; %*mean2(T11) *mean2(T22)

% normalize displacement with determinant
d1 = d1./Tdet;
d2 = d2./Tdet;
%d1 = medfilt2(d1, [lpSize lpSize]);
%d2 = medfilt2(d2, [lpSize lpSize]);
% put in return matrix
V = zeros([size(T11),2]);
V(:,:,1) = d1;
V(:,:,2) = d2;
C = Tdet;
end


