a = getactive;
histvect = histogram(a);
meanvalue = meanhist(histvect);
T = ocrselectthresh2(histvect,meanvalue);
b = threshold(a, T, '<'); %type: < >
b = expand(b, 8, 1);
b = contract(b, 8, 2);
b = expand(b, 8, 1);
[c, num_obj]= labeling(b, conn); %conn=?
if num_obj > 1
    c = ocrextract(c, 0); %obj=??
end
%thinning/shrining to skeleton, pruning

ps1=getmatch('ps1');
ps2=getmatch('ps2');
ps3=getmatch('ps3');
ps4=getmatch('ps4');

d = logop4(c, 0, -1, 0, ps1,ps2,ps3,ps4);
%d=thin1(8);
num = ocrdecide(d, conn) %conn???

