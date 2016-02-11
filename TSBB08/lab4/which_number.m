function [ result ] = which_number(in)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

histvect = histogram(in);
start =meanhist(histvect);
thres = ocrselectthresh1(histvect,start);
thres = ocrselectthresh2(histvect,thres);
%thres = least_error(histvect);

%open/close
%-----------------------------------
obj = threshold(in,thres, '<'); % < >

obj = expand(obj,4,1);
obj = contract(obj,4,2);
obj = expand(obj,4,1);

[big_obj, num_obj]= labeling(obj, 4); %conn=?
if num_obj >= 1
    big_obj = ocrextract(big_obj, 0); %obj=??
end

thin1=getmatch('thin1');
thin2=getmatch('thin2');
thin3=getmatch('thin3');
thin4=getmatch('thin4');

% shrink to skeleton
%skeleton=logop4(big_obj, 1, -1, 0, thin1, thin2, thin3, thin4);
skeleton=thin1(big_obj,4,0);

p1=getmatch('p1');
p2=getmatch('p2');
p3=getmatch('p3');
p4=getmatch('p4');

prune=logop4(skeleton, 1, -1, 0, p1, p2, p3, p4);
%prune=thin2(skeleton,4,1);

result=ocrdecide(prune, 4);



end

