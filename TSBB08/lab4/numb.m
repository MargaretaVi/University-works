function [ number ] = numb( skeleton )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[big_obj, num_obj]= labeling(skeleton, 4); %conn=?
if num_obj >= 1
    big_obj = ocrextract(big_obj, 0); %obj=??
end
number = ocrdecide(big_obj,4);

end

