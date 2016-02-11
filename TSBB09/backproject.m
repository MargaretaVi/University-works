function [f,M] = backproject(q, rVec, phiVec, xVec, yVec, intpol)

[xGrid, yGrid] = meshgrid(xVec, yVec);
f = zeros(size(xGrid));
Nr = length(rVec);
Nphi = length(phiVec);
deltaR = rVec(2) - rVec(1);

switch intpol
  case 'nearest'
    for phiIx = 1:Nphi
      phi = phiVec(phiIx);
      proj = q(:, phiIx); 
      r = xGrid * cos(phi) + yGrid * sin(phi);
      rIx = round(r / deltaR + (Nr + 1) / 2);
      f = f + proj(rIx);
      M(phiIx) = getframe;
    end
  case 'linear'
     % your code here
      for phiIx = 1:Nphi
          phi = phiVec(phiIx);
          proj = q(:, phiIx); 
          r = xGrid * cos(phi) + yGrid * sin(phi);
          rIx = r / deltaR + (Nr + 1) / 2; % no longer round (...)
          rIx1 = floor(rIx);
          rIx2 = rIx1 +1;
          w = rIx2 - rIx;
          f = f + proj(rIx1).*abs(w)+proj(rIx2).*abs(rIx-rIx1);
          %subplot(2,2,4); imagesc(f); axis xy; axis image; colorbar;
          M(phiIx) = getframe;
      end
  otherwise
    error('Unknown interpolation.');
end

f = f * pi / (Nphi*deltaR);
