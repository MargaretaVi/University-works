%% laboration 1
clc; clearvars;
% initcourse TSBB15
%% 3.5
% init + preproc
[I0,J,dTrue]=getCameraman;
dTrue = dTrue';
std = 2; filtersize=9;
[x, y] = meshgrid(floor(-filtersize/2+1):floor(filtersize/2));
lp=exp(-0.5*(x.^2+y.^2)/std.^2);
lp = lp./sum(lp(:));
gI = conv2(I0,lp,'same');
gJ = conv2(J,lp,'same');
% compute derivatives
[dJx, dJy] = regu_deri(J,filtersize,std);
% [dJx, dJy] = regu_deri(J,filtersize,std);
% bounding box
height=70; width = 40;
xc =120;yc=85;
xmin = xc-width/2;
xmax = xc+width/2;
ymin = yc-height/2;
ymax = yc+height/2;
% estimate tensor
[Z,T] = estOrientTensor(dJx,dJy,xmin,xmax,ymin,ymax);
e = estimateE(gI,gJ,xmin,xmax,ymin,ymax,dJx,dJy);
d=Z\e;

J2 = J;
d0 = zeros(size(dTrue));
deltad=[0;0];
while(norm(dTrue-d0)>0.1)
    J2 = interpolateImage(J2,deltad);%,xmin,xmax,ymin,ymax);
    gJ2 = conv2(J2,lp,'same');
    [dJx, dJy] = regu_deri(J2,filtersize,std);
    [Z,~] = estOrientTensor(dJx,dJy,xmin,xmax,ymin,ymax);
    e = estimateE(gI,J2,xmin,xmax,ymin,ymax,dJx,dJy);
    deltad=Z\e;
    d0 = d0+deltad;
end

%% 4.2
im1 = double(imread('cornertest.png'));
[dim1x, dim1y] = regu_deri(im1,5,3);
[~,T] = estOrientTensor(dim1x,dim1y);
T(:,:,1) = conv2(T(:,:,1),lp,'same');
T(:,:,2) = conv2(T(:,:,2),lp,'same');
T(:,:,3) = conv2(T(:,:,3),lp,'same');
k = 0.05;
cHarris = CHarris(T,k);
thres = .5*max(cHarris(:));
C = (cHarris > thres);
C2 = ordfilt2(C,1,ones(3));
[row,col] = find(C2 == C);
figure(1)
imagesc(im1); colorbar; colormap gray;  axis image;
figure(2)
imagesc(C2); axis image; colorbar; colormap gray;

%% chess
% init find harris features
std = 2; filtersize=9;
[x, y] = meshgrid(floor(-filtersize/2+1):floor(filtersize/2));
lp=exp(-0.5*(x.^2+y.^2)/std.^2);
lp = lp./sum(lp(:));
for ii = 1:10
    I{ii} = double(imread(sprintf('chessboard_%d.png',ii)));
end;
[dim1x, dim1y] = regu_deri(I{1},5,3);
[~,T] = estOrientTensor(dim1x,dim1y);
T(:,:,1) = conv2(T(:,:,1),lp,'same');
T(:,:,2) = conv2(T(:,:,2),lp,'same');
T(:,:,3) = conv2(T(:,:,3),lp,'same');
k = 0.05;
cHarris = CHarris(T,k);
cHarris(1:20,:)=0;cHarris(end-20:end,:)=0;cHarris(:,1:20)=0;cHarris(:,end-20:end)=0;
thres = .7*max(cHarris(:));
C = (cHarris > thres);
C2 = ordfilt2(C,1,ones(3));[row,col] = find(C2 == C);
C3 = bwmorph(C2,'shrink',Inf);
C4 = cHarris.*C3;
[~, chind] = sort(C4(:));
%chind = chind(end-4:end);
[rows, cols] = ind2sub([size(C4)],chind);
%%
height=40; width = 40;
%I = double(imread('chessboard_1.png'));
%J = double(imread('chessboard_2.png'));

%gI = conv2(I,lp,'same');
markerVector = {'rx', 'cx', 'bx', 'yo', 'mo'};

figure(98);
imagesc(I{1});
colormap gray; axis image; axis off;
hold on;
for pointnum=1:5
    plot(cols(pointnum),rows(pointnum),markerVector{pointnum});
end;
hold off;
    
figure(99);
for picnum=1:9
    subplot(3,3,picnum); 
    imagesc(I{picnum+1});
    colormap gray; axis image; axis off;
    hold on;
end;


%% 
figure(99);
for ii = 1:5
    %read initial coordinates for points to track
    prev_d = zeros(2,1);
    di = zeros(2,9);
    xmin = cols(ii)-width/2; 
    xmax = cols(ii)+width/2; 
    ymin = rows(ii)-height/2;
    ymax = rows(ii)+height/2;
    
    for jj = 1:9
        % update coordinates for each loop
        xmin = round(xmin+prev_d(2));
        xmax = round(xmax+prev_d(2));
        ymin = round(ymin+prev_d(1));
        ymin = round(ymin+prev_d(1));
        % read images
        I0 = I{jj};
        J = I{jj+1};
        [dJx, dJy] = regu_deri(J,filtersize,std);
        gI = conv2(I0,lp,'same');
        gJ = conv2(J,lp,'same');
        % init d0+deltad
        d0 = zeros(2,1);
        deltad=[0;0];
        for ppp = 1:10
            J = interpolateImage(J,deltad);%,xmin,xmax,ymin,ymax);
            dJx=interpolateImage(dJx,deltad);
            dJy =interpolateImage(dJy,deltad);
            [Z,~] = estOrientTensor(dJx,dJy,xmin,xmax,ymin,ymax);
            gJ = conv2(J,lp,'same');
            e = estimateE(gI,gJ,xmin,xmax,ymin,ymax,dJx,dJy);
            deltad=Z\e;
            d0 = d0+deltad;
        end
        d0;
        di(:,jj)=d0;
        prev_d = d0;
        figure(99);
        subplot(3,3,jj);
        plot(cols(ii)+sum(di(2,:)),rows(ii)+sum(di(1,:)),markerVector{ii});
        drawnow;
    end
    %pause;
end

