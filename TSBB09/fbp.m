%%%
% GEOMETRY SETUP
%%%

Nx = 128; 				% number of grid points in x
Ny = 128; 				% number of grid points in y
Nr = 192; 				% number of detector elements
Nphi = 192;				% number of projection angles

xLen = 2.0; 				% side of reconstructed rectangle
yLen = 2.0; 				% side of reconstructed rectangle
phiLen = pi; 				% angular interval
rLen = xLen * 1.5; 			% length of detector

phiVec = (0 : Nphi - 1) * phiLen / Nphi;
rVec = (0.5 : Nr - 0.5) * rLen / Nr - rLen / 2;
xVec = (0.5 : Nx - 0.5) * xLen / Nx - xLen / 2;
yVec = (0.5 : Ny - 0.5) * yLen / Ny - yLen / 2;

%%%
% PHANTOM DEFINITION
%%%
% musse pig
% E = [ 0.0  -0.2  0.6  1.0; ...     
%       0.5  0.55  0.3  1.0; ...
%      -0.5  0.55  0.3  1.0];

% shepp-logan phantom
E = [0 0 0.69 0.92 0 2.00 1.0; ...
    0 -0.0184 0.6624 0.874 0 -0.98 -0.6; ...
    0.22 0 0.11 0.31 -18 -0.02 -0.2; ...
    -0.22 0 0.16 0.41 18 -0.02 -0.2; ...
    0 0.35 0.21 0.25 0 0.01 0.1; ...
    0 0.1 0.046 0.046 0 0.01 0.1; ...
    0 -0.1 0.046 0.046 0 0.01 0.1; ...
    -0.08 -0.605 0.046 0.023 0 0.01 0.1; ...
    0 -0.605 0.023 0.023 0 0.01 0.1;...
    0.06 -0.605 0.023 0.046 0 0.01 0.1];

phm = pixelize(E, xVec, yVec);
subplot(2,2,1); imagesc(yVec, xVec, phm); title('Phantom');
axis xy; axis image; colorbar; colormap gray; pause(0);
caxis([1 1.04]);
%%%
% SINOGRAM GENERATION
%%%

p = generateProj(E, rVec, phiVec,5);
subplot(2,2,2); imagesc(phiVec, rVec, p); title('Sinogram');
xlabel('\phi'); ylabel('r'); axis xy; colormap 'gray'; pause(0);


%%%
% RECONSTRUCTION
%%%
q = rampfilter(p, rVec, 'fourier2');
q1 = rampfilter(p, rVec, 'fourier1');

%q = p;
subplot(2,2,3); imagesc(phiVec, rVec, q);
axis xy; colorbar; title('Rampfiltered sinogram'); pause(0);

[f,M] = backproject(q, rVec, phiVec, xVec, yVec, 'linear');
subplot(2,2,4); imagesc(yVec, xVec, f);
axis xy; axis image; 
colorbar; title('Reconstructed image'); pause(0);
caxis([1 1.04])


