%% 4
%%%%
fpath = '/site/edu/bb/Bildsensorer/H-RangeCamera/';

fp = fopen([fpath 'handran'],'r');
a = fscanf(fp,'%d',[500,256]); % image size:  500* 256
figure(1)
imagesc(a);
axis image; colorbar;
colormap([(0:255)'/255,(0:255)'/255,(0:255)'/255]);
imagesc(a,[0,100]); axis image;
colorbar;
%%
fp = fopen([fpath 'handint'],'r');
b = fscanf(fp,'%d',[500,256]); % image size:  500*256
figure(2)
imagesc(b);
axis image; colorbar;
colormap([(0:255)'/255,(0:255)'/255,(0:255)'/255])
%%
figure(3)
T = 35;
c = a.*(b>T);%+255*(a>200);
imagesc(c);
colormap gray; colorbar; axis image;

rainbow = jet;
rainbow(1,:) = [1 1 1]/3;
colormap(rainbow);

%%
figure(4)
fp=fopen([fpath 'musran'],'r');
b = fscanf(fp,'%d',[250,256]); % image size:  250*256
imagesc(b); axis image;

figure(5)
fp = fopen([fpath 'wood'],'r');
g = fscanf(fp,'%d',[512,512]); % image size:  512*512
imagesc(g);
%%
figure(10)
%g(g<255)=0;
imagesc(g);
[y1, i1] = max(g,[],1);
[y2, i2] = max(g,[],2);
%y1(y1<255)=0;
%y2(y2<255)=0;
%g2 = zeros(size(g));
%g2(i2,i1)=1;

figure(6)
%imagesc(g2);
%figure(7)
%plot(i1,y1)

%% Trapez
figure(7)
imagesc(trapez);
figure(8)
imagesc(notrapez);

x1 = [73 175 1; 136 123 1; 389 140 1; 473 206 1; 73 175 1]';
y1 = inv(C)*x1;
y1 = [y1(1,:)./y1(3,:) ; y1(2,:)./y1(3,:)];
circ_area = sum(norm(y1(:,1)-y1(:,2))+norm(y1(:,2)-y1(:,3))+norm(y1(:,3)-y1(:,4))+norm(y1(:,4)-y1(:,5)))

%% 6.5 
load cardim;
tick_divide = 5;
 r = rangeim.range;
 y = rangeim.x;
 x = repmat(double(rangeim.prof_id)/tick_divide,[size(y,1),1]);
imsz = size(r);
R1 = zeros([imsz 3]);
R1(:,:,1) = double(y);
R1(:,:,2) = double(x);
R1(:,:,3) = double(r);
cert = (r == 0);
R1c = repmat(cert,[1 1 3]);
R1(R1c) = NaN;

R1tmp(:,:,1) = detrend(R1(:,:,1));
R1tmp(:,:,2) = detrend(R1(:,:,2));
R1tmp(:,:,3) = detrend(R1(:,:,3));


%mesh(R1(:,:,3)); axis equal

mesh(R1(:,:,1),R1(:,:,2),R1tmp(:,:,3).*(R1tmp(:,:,3)>0.1)); axis equal

%% letter
load letter.mat;
tick_divide = 1;
 r = rangeim.range;
 y = rangeim.x;
 x = repmat(double(rangeim.prof_id)/tick_divide,[size(y,1),1]);
imsz = size(r);
R1 = zeros([imsz 3]);
R1(:,:,1) = double(y);
R1(:,:,2) = double(x);
R1(:,:,3) = double(r);
cert = (r == 0);
R1c = repmat(cert,[1 1 3]);
R1(R1c) = NaN;

 R2tmp(:,:,1) = detrend(R1(:,:,1));
 R2tmp(:,:,2) = detrend(R1(:,:,2));
 R2tmp(:,:,3) = detrend(R1(:,:,3));


%mesh(R1(:,:,3)); axis equal

mesh(R1(:,:,1),R1(:,:,2),R2tmp(:,:,3)); axis equal

%% 6.6
load 'vit_vaggkontakt.mat'

tick_divide =  4.1417;
 r = rangeim.range;
 y = rangeim.x;
 x = repmat(double(rangeim.prof_id)/tick_divide,[size(y,1),1]);
imsz = size(r);
R1 = zeros([imsz 3]);
R1(:,:,1) = double(y);
R1(:,:,2) = double(x);
R1(:,:,3) = double(r);
cert = (r == 0);
R1c = repmat(cert,[1 1 3]);
R1(R1c) = NaN;


R2 = R1(401:700,201:700,:);
Intens = rangeim.intens(401:700,201:700);
figure(1)
meshc(R2(:,:,1),R2(:,:,2),R2(:,:,3))
figure(2)
subplot(2,2,1), imagesc(R2(:,:,1)), title('y image'); axis image;
subplot(2,2,2), imagesc(R2(:,:,2)), title('x image'); axis image;
subplot(2,2,3), imagesc(R2(:,:,3)), title('r image'); axis image;
subplot(2,2,4), imagesc(Intens(:,:)), title('i image'); axis image;
figure(3)
subplot(2,2,1), plot(R2(:,320,1)), title('vert, y');
subplot(2,2,2), plot(R2(150,:,2)), title('horiz, x');
subplot(2,2,3), plot(R2(:,320,3)), title('vert, r');
subplot(2,2,4), plot(R2(150,:,3)), title('horiz, r');

%%
tick_divide =  4.1417;
load hus0.mat

 r = rangeim.range;
 y = rangeim.x;
 x = repmat(double(rangeim.prof_id)/tick_divide,[size(y,1),1]);
imsz = size(r);
R1 = zeros([imsz 3]);
R1(:,:,1) = double(y);
R1(:,:,2) = double(x);
R1(:,:,3) = double(r);
cert = (r == 0);
R1c = repmat(cert,[1 1 3]);
R1(R1c) = NaN;


R2 = R1(401:700,201:700,:);
Intens = rangeim.intens(401:700,201:700);
figure(1)
meshc(R2(126:198,111:362,1),R2(126:198,111:362,2),R2(126:198,111:362,3)-400)
figure(2)
subplot(2,2,1), imagesc(R2(:,:,1)), title('y image'); axis image;
subplot(2,2,2), imagesc(R2(:,:,2)), title('x image'); axis image;
subplot(2,2,3), imagesc(R2(:,:,3)), title('r image'); axis image;
subplot(2,2,4), imagesc(Intens(:,:)), title('i image'); axis image;
figure(3)
subplot(2,2,1), plot(R2(:,320,1)), title('vert, y');
subplot(2,2,2), plot(R2(150,:,2)), title('horiz, x');
subplot(2,2,3), plot(R2(:,320,3)), title('vert, r');
subplot(2,2,4), plot(R2(150,:,3)), title('horiz, r');

deltay = (527.3-496.4)/(198-126);
deltax = (135.5 -74.85)/(362 - 112);

%%
R2diff = 0*R2(:,:,1);
R2diff(1:end-1,:) = diff(R2(:,:,1));
volymhus = (R2(:,:,3)-400).*R2diff*1/tick_divide.*(R2(:,:,3)>410);
imagesc(volymhus)
nansum(nansum(volymhus))/1000
%%


volume = sum(nansum(R2(126:198,111:362,3)-400))/1000*deltay*deltax % vol i cm^3

%%
tick_divide =  4.1417;
load hus90.mat


 r = rangeim.range;
 y = rangeim.x;
 x = repmat(double(rangeim.prof_id)/tick_divide,[size(y,1),1]);
imsz = size(r);
R1 = zeros([imsz 3]);
R1(:,:,1) = double(y);
R1(:,:,2) = double(x);
R1(:,:,3) = double(r);
cert = (r == 0);
R1c = repmat(cert,[1 1 3]);
R1(R1c) = NaN;


R2 = R1(401:700,201:700,:);
Intens = rangeim.intens(401:700,201:700);
figure(1)
meshc(R2(126:198,111:362,1),R2(126:198,111:362,2),R2(126:198,111:362,3)-400)
figure(2)
subplot(2,2,1), imagesc(R2(:,:,1)), title('y image'); axis image;
subplot(2,2,2), imagesc(R2(:,:,2)), title('x image'); axis image;
subplot(2,2,3), imagesc(R2(:,:,3)), title('r image'); axis image;
subplot(2,2,4), imagesc(Intens(:,:)), title('i image'); axis image;
figure(3)
subplot(2,2,1), plot(R2(:,320,1)), title('vert, y');
subplot(2,2,2), plot(R2(150,:,2)), title('horiz, x');
subplot(2,2,3), plot(R2(:,200,3)), title('vert, r');
subplot(2,2,4), plot(R2(100,:,3)), title('horiz, r');

volume = sum(nansum(R2(84:230,178:300,3)-400))/1000*deltay*deltax