function [ gray ] = imagebw( im, type )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    if (type == 0)
      imshow(im, [0 255]);
      colorbar; colormap gray;
    else
     imshow(im, [min(im(:)),max(im(:))]);
     colorbar; colormap gray;
    end
end

