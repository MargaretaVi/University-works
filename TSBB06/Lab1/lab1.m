% HT1 lab 1

%computing homography


%% Load image

clc

img1 = imread('img1.ppm');
img2 = imread('img2.ppm');
figure(1);
imagesc(img1);
figure(2);
imagesc(img2);

% Coordinates

%y1 = vgg_get_homg([516 349; 130 502; 191 140; 780 36]');
%y2 = vgg_get_homg([478 353; 227 590; 166 242; 570 41]');
y1= vgg_get_homg([516 349; 130 502; 191 140; 780 36; 81 7;524 58;445 600; 748 450]');
y2 = vgg_get_homg([478 353; 227 590; 166 242; 570 41; 35 144; 399 102;503 589; 666 385]');

figure(1);hold('on');plot(y1(1,:),y1(2,:),'go')
figure(2);hold('on');plot(y2(1,:),y2(2,:),'go')

%% 4.1
clc
% dont forget to reshape vector z back to matrix h.
A=[];
%N=4;
N = 8;
for cnt=1:N
    A=[A;
        [y1(1,cnt) 0 -y1(1,cnt).*y2(1,cnt) y1(2,cnt) 0 -y1(2,cnt).*y2(1,cnt) 1 0 -y2(1,cnt)];
        [ 0 y1(1,cnt) -y1(1,cnt).*y2(2,cnt) 0 y1(2,cnt) -y1(2,cnt).*y2(2,cnt) 0 1 -y2(2,cnt)]
        ];
end
A0 = A(:,1:(end-1));
b = A(:,end);
zbar = -1*(inv((A0'*A0))*A0'*b);
z=[zbar;1];
H1min = [z(1) z(2) z(3);
    z(4) z(5) z(6);
    z(7) z(8) z(9)]';

%% reidual error
clc

res = A*z;
%% matching with nonhomg
clc
H1=H1min;
y2b=vgg_get_nonhomg(H1*y1);
y1b=vgg_get_nonhomg(inv(H1)*y2);
figure(1);plot(y1b(1,:),y1b(2,:),'rx');
figure(2);plot(y2b(1,:),y2b(2,:),'rx');

%% geometric error symmetric
e1=0;
for k=1:length(y1)
    e1=e1+norm(vgg_get_nonhomg(y2(:,k))-y2b(:,k))^2 +...
        norm(vgg_get_nonhomg(y1(:,k))-y1b(:,k))^2;
end
e1=sqrt(e1)

%% non-symmetric
clc
e1_non=0;
for k=1:length(y1)
    e1_non=e1_non+norm(vgg_get_nonhomg(y1(:,k))-y1b(:,k))^2 ;
end
e1_non=sqrt(e1_non)

e2_non=0;
for k=1:length(y2)
    e1_non=e1_non+norm(vgg_get_nonhomg(y2(:,k))-y2b(:,k))^2 ;
end
e2_non=sqrt(e2_non)
%% transformation
clc
img2t=image_resample(double(img1),H1, 640,800);
figure(3);imagesc(uint8(img2t));
figure(4);imagesc(uint8(img2t)-img2);
%% new calc of Ao, b by setting another element in Z to 1

A0_new = A(:,2:end);
b_new = A(:,1);
zbar_new = -1*(inv((A0_new'*A0_new))*A0_new'*b_new);
%H = reshape (zbar(:,end),1,9);
z_new=[1; zbar_new];
H1min_new = [z_new(1) z_new(2) z_new(3);
    z_new(4) z_new(5) z_new(6);
    z_new(7) z_new(8) z_new(9)]';

%% matching with nonhomg
clc
H1=H1min;
y2b=vgg_get_nonhomg(H1*y1);
y1b=vgg_get_nonhomg(inv(H1)*y2);
figure(1);plot(y1b(1,:),y1b(2,:),'yx');
figure(2);plot(y2b(1,:),y2b(2,:),'yx');

%% 4.3

[U S V] = svd(A);
H2 = reshape(V(:,end), 3,3);
y2h2=vgg_get_nonhomg(H2*y1);
y1h2=vgg_get_nonhomg(inv(H2)*y2);

e2=0;
for k=1:length(y1)
    e2=e2+norm(vgg_get_nonhomg(y2(:,k))-y2h2(:,k))^2 +...
        norm(vgg_get_nonhomg(y1(:,k))-y1h2(:,k))^2;
end
e2=sqrt(e2);

%% Hartley transformation
clc
singval = diag(S)';
%figure(4);plot(log(diag(S)),'o');

[y1t T1] = liu_preconditioning(y1);
[y2t T2] = liu_preconditioning(y2);
medelT1 = mean(mean(y1t));
medelT2 = mean(mean(y2t));

%%
At=[];
N = 8;
for cnt=1:N
    At=[At;
        [y1t(1,cnt) 0 -y1t(1,cnt).*y2t(1,cnt) y1t(2,cnt) 0 -y1t(2,cnt).*y2t(1,cnt) 1 0 -y2t(1,cnt)];
        [ 0 y1t(1,cnt) -y1t(1,cnt).*y2t(2,cnt) 0 y1t(2,cnt) -y1t(2,cnt).*y2t(2,cnt) 0 1 -y2t(2,cnt)]
        ];
end
[Ut St Vt] = svd(At);
Ht = reshape(Vt(:, end), 3,3);

% H3 

H3 = inv(T2)*Ht*T1; 

y2h3=vgg_get_nonhomg(H3*y1);
y1h3=vgg_get_nonhomg(inv(H3)*y2);


diag(St)';
%figure(5); plot(log(diag(St)),'o');

% geo error 


e3=0;
for k=1:length(y1)
    e3=e3+norm(vgg_get_nonhomg(y2(:,k))-y2h3(:,k))^2 +...
        norm(vgg_get_nonhomg(y1(:,k))-y1h3(:,k))^2;
end
e3=sqrt(e3);

%% 4.5 
clc
load -ascii H1to2p


y2b2=vgg_get_nonhomg(H1to2p*y1);
y1b2=vgg_get_nonhomg(inv(H1to2p)*y2);
%figure(1);plot(y1b(1,:),y1b(2,:),'rx');
%figure(2);plot(y2b(1,:),y2b(2,:),'rx');

% geometric error symmetric
e4=0;
for k=1:length(y1)
    e4=e4+norm(vgg_get_nonhomg(y2(:,k))-y2b2(:,k))^2 +...
        norm(vgg_get_nonhomg(y1(:,k))-y1b2(:,k))^2;
end
e4=sqrt(e4);

% error
clc

e14=e4-e1
e24=e4-e2
e34=e4-e3

%% 4.6 Transformation of lines
clc
y1p= vgg_get_homg([100 371]');
y2p= vgg_get_homg([219 519]');

% l1 = liu_crossop(y1p)*liu_crossop(y2p)
l1= cross(y1p,y2p);

figure(1);
imagesc(img1);
figure(1);
hold on;
drawline(l1,'axis','xy');
hold off;

l2 = inv(H3')*l1;
figure(2);
imagesc(img2);
figure(2);
hold on;
drawline(l2,'axis','xy');
hold off;

%% 4 .7 SVD
clc
%y1q= vgg_get_homg([188 139; 161 16; 406 207; 765 92 ;447 512 ]');
%y2q= vgg_get_homg([168 242; 103 137; 355 254; 576 88; 476 511 ]');
%new sets of point
y1q= vgg_get_homg([72 337; 98 373; 224 250 ; 265 571 ; 291 596]');
y2q= vgg_get_homg([129 454 ; 161 479 ; 306 508 ;361 616 ; 338 629]');

l2= cross(y1p,y2p);

figure(10);
imagesc(img1);
figure(10);
hold on;
drawline(l1,'axis','xy');
hold off;

l2 = inv(H3')*l1;
figure(11);
imagesc(img2);
figure(11);
hold on;
drawline(l2,'axis','xy');
hold off;

Aq=[];
N = 5;
for cnt=1:N
    Aq=[Aq;
        [y1q(1,cnt) 0 -y1q(1,cnt).*y2q(1,cnt) y1q(2,cnt) 0 -y1q(2,cnt).*y2q(1,cnt) 1 0 -y2q(1,cnt)];
        [ 0 y1q(1,cnt) -y1q(1,cnt).*y2q(2,cnt) 0 y1q(2,cnt) -y1q(2,cnt).*y2q(2,cnt) 0 1 -y2q(2,cnt)]
        ];
end
[U_q S_q V_q] = svd(Aq);
Hq = reshape(V_q(:,end), 3,3);
diag(S_q)';

figure(12);
plot(log(diag(S_q)),'o');

%%
[y1qH T1q] = liu_preconditioning(y1q);
[y2qH T2q] = liu_preconditioning(y2q);

Atq=[];
N = 5;
for cnt=1:N
    Atq=[Atq;
        [y1qH(1,cnt) 0 -y1qH(1,cnt).*y2qH(1,cnt) y1qH(2,cnt) 0 -y1qH(2,cnt).*y2qH(1,cnt) 1 0 -y2qH(1,cnt)];
        [ 0 y1qH(1,cnt) -y1qH(1,cnt).*y2qH(2,cnt) 0 y1qH(2,cnt) -y1qH(2,cnt).*y2qH(2,cnt) 0 1 -y2qH(2,cnt)]
        ];
end
[Utq Stq Vtq] = svd(Atq);
Htq = reshape(Vtq(:, end), 3,3);

% H3 

H3q = inv(T2)*Htq*T1; 

y2h3=vgg_get_nonhomg(H3q*y1);
y1h3=vgg_get_nonhomg(inv(H3q)*y2);


diag(Stq)';
figure(13); plot(log(diag(Stq)),'o');

%trans1 = Htq*double(img1);
figure(14); %imagesc(uint8(trans1));
imagesc(uint8(image_resample(double(img1),H3q,640,800)))