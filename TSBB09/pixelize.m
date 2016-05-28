function phm = pixelize(E, xVec, yVec)

[xGrid, yGrid] = meshgrid(xVec, yVec);
phm = zeros(size(xGrid));

for i = 1 : size(E, 1)        
   x0 = E(i, 1);          % x offset
   y0 = E(i, 2);          % y offset
   a = E(i, 3);           % radius a
   b = E(i,4);             % radius b 
   alpha = E(i, 5)*pi/180; % rotation
   dens = E(i, 6);        % density  ,  6 for normal 
   x = xGrid - x0;
   y = yGrid - y0;
   %idx = find(x.^2 + y.^2 < a^2);  % for a circle
  idx = find( ((cos(alpha)*x+sin(alpha)*y) / a).^2 + ((cos(alpha)*y-sin(alpha)*x)/b).^2 <= 1); % for an elipse
  phm(idx) = phm(idx) + dens;
end
