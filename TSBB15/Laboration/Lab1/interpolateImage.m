function imout = interpolateImage(im,d)%,xmin,xmax,ymin,ymax,X,Y)

[X, Y] = meshgrid(1:size(im,2),1:size(im,1)); 
Xq = X+d(2);
Yq = Y+d(1);

imout = interp2(X,Y,im,Xq,Yq);
end