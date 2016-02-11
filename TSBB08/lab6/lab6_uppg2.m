%% lab6 2
initcourse('TSBB08');
clc;
clear all;
close all;

% %%
% execute('chooseobject','A1',16,30,24);
% %% 1.4
% execute('chooseobject','B1',159,2,22);
%%
struct=load('/site/edu/bb/mips/7.0/images/nuf0b.mat');
bild=struct.nuf0b;
histo = histogram(bild);
figure(1)
plot(histo)
T2  =150;
T1 = 125;
b =(bild<T1);
c =(bild<T2);
figure(2)
lower = imagesc(b); colormap('gray'); colorbar;
figure(3)
upper = imagesc(c); colormap('gray');colorbar;

e=logical(zeros(128));
count=0;

while  ~isequal(b,e) % if the two matrices are not equal return true
    close all;
    count=count+1;
    e=b;
    figure(3);imagesc(e);
    d=expand(b,4,1);
    b=d.*c;
    pause();
end

figure(4)
imagesc(e); colormap('gray');colorbar;

%% 3

%----- 
% correlation
clc
struct=load('/site/edu/bb/mips/7.0/images/blod256.mat');
blod256=struct.blod256;
figure(55)
imagesc(blod256);colormap('gray');
cell=chooseobject(blod256,159,2,22);

corrcblod=corrc(blod256,cell);
figure(5)
imagesc(corrcblod);colormap('gray');
%-----
%% hysters

histo = histogram(blod256);
% figure(6)
% plot(histo)
T2  =80;
T1 = 55;
c =(blod256>T1);
b =(blod256>T2);
figure(7)
lower = imagesc(b); colormap('gray'); colorbar;
figure(8)
upper = imagesc(c); colormap('gray');colorbar;

e=logical(zeros(128));
count=0;


while  ~isequal(b,e) % if the two matrices are not equal return true
    count=count+1;
    e=b;
    figure(9);imagesc(e);
    d=expand(b,8,1);
    figure(80)
    imagesc(d)
    b=d.*c;
    pause();
    figure(10)
    imagesc(b); colormap('gray');colorbar;
end

figure(11)  
imagesc(b); colormap('gray');colorbar;


% Perform labeling
%-----------------
labelstruct = bwconncomp(b,8);

% Make a labelimage to look at
%-----------------------------
NumObj = labelstruct.NumObjects;
labelim = zeros(labelstruct.ImageSize);
for no = 1:NumObj
    labelim(labelstruct.PixelIdxList{no}) = no;
end


figure(19), imshow(labelim,[],'InitialMagnification','fit');
title('Local mins');
colormap(jet), colorbar;

antal=NumObj