function e = estiE(I, J,fx,fy)
% estimate error
e = zeros(size(I,1),size(I,2),2);

etmp = (I-J);

e(:,:,2) = etmp.*fx;
e(:,:,1) = etmp.*fy;
end