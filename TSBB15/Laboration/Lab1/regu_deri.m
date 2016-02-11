function [fx, fy] = regu_deri(img, filtersize, std)
%UNTITLED3 Summary of this function goes here
%   takes a filter size and std as input and returns the regularized
%   derivatives for an image 

x = floor(-filtersize/2+1):floor(filtersize/2);
lp=exp(-0.5*(x/std).^2);
lp=lp/sum(lp(:));
df=-1/std^2*x.*lp;

fx=conv2(lp,df',img,'same');
fy=conv2(df,lp',img,'same');


end

