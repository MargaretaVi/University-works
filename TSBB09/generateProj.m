function p = generateProj(E, rVec, phiVec, oversampling)

Nr = length(rVec) * oversampling;
rLen = (rVec(2) - rVec(1)) / oversampling * Nr;
rVec = (0.5 : Nr - 0.5) * rLen / Nr - rLen / 2;

x0 = E(:, 1);
y0 = E(:, 2);
a = E(:, 3);
b = E(:,4);             % radius b 
alpha = E(:, 5)*pi/180; % rotation
dens = E(:, 6);

p = zeros(length(rVec), length(phiVec));

for phiIx = 1:length(phiVec)
  phi = phiVec(phiIx);
  for i = 1:length(x0)    
    %aSqr = a.^2;
    r0Sqr = a.^2.*cos(phi-alpha).^2 + b.^2.*sin(phi-alpha).^2;
    r1Sqr = (rVec' - x0(i) * cos(phi) - y0(i) * sin(phi)).^2;
    ind = find(r0Sqr(i) > r1Sqr);   
    p(ind, phiIx) = p(ind, phiIx) + 2*dens(i)*sqrt(r0Sqr(i) - r1Sqr(ind))/r0Sqr(i)*a(i)*b(i);
  end
end

p = conv2(p, ones(oversampling, 1) / oversampling, 'same');
p = p(round(oversampling/2):oversampling:end, :);
