function e = estimateE(I, J,xmin, xmax, ymin, ymax, fx, fy)
e = (I(ymin:ymax,xmin:xmax)-J(ymin:ymax,xmin:xmax));
fxd = fx(ymin:ymax,xmin:xmax);
fyd = fy(ymin:ymax,xmin:xmax);


%figure(1);clf; imagesc(e);axis image;colorbar;
etmp2 = e.*fxd;%(ymin:ymax,xmin:xmax);
etmp1 = e.*fyd;%(ymin:ymax,xmin:xmax);


ex = (e(:)'*(fxd(:)))/((xmax-xmin)*(ymax-ymin));
ey = (e(:)'*(fyd(:)))/((xmax-xmin)*(ymax-ymin));

e = [mean(etmp1(:)); mean(etmp2(:))];
%e = [ey; ex];


end