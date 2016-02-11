function [medel ] = medelvar( histo )
%UNTITLED3 Summary of this function goes here
%  calculate the mean of the whole histogram

num = length(histo); 
lowersum1 = histo(1:num)*[1:num]';
lowersum2 = sum(histo(1:num));

if lowersum2 ~= 0
medel = lowersum1/lowersum2;
else
medel = num;
 end;


end

