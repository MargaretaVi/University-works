%struct=load('/site/edu/bb/mips/7.0/images/hus.mat');
hus=getactive;

%% canny

% [cannyim1, tc]=edge(hus, 'canny');
% tc
% newimage(cannyim1, 'canny1',5);

T=0.25;
cannyim2=edge(hus, 'canny', [0.4*T T], 1);
newimage(cannyim2, 'canny1',5);