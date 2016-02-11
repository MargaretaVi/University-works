%% lektionssuppgifter

initcourse TSBB15
%% 2.1
x = [0:pi];
y = sin(x);
figure(1);
plot(x ,y , 'm--h');

%% 2.2
sin(1);
sin = 42; % you overwrite the sinus function here to 42
sin(1); % thus you return 42 here though sin(2) does not exist as how sin is a variable
which sin
clear sin
which sin

% if you have a sin.m file you will overwrite the function with the one you
% wrote yourself

%% 2.3  % must have file from initcourse
type timedloops
timedloops

%difference is the time it takes to loop. the one with vector operations is the fastest 
% what should you consider?? preallocate memory and use vectors 
%% 2.4 

A = rand(9,9);
A(2, 7);            % return the element in row 2, column 7
A(3:6, 1:2:5);      % row 3 to 6, only column 1,2,5
A([1 1 5 5 3 1], :); % returns all columns of row 1 , 1, 5, 5, 3 ,1 in this particular order.
A(end:-2:1, 1:2:end);% returning every other row from the end to the top 
                    % though the columns values are take from the top to
                    % bottom.
A(17);              % returns the 17:th value, start counting each column.
A(:);               % returns all columns after each other.
b = [1 7 3];        % define b as a row vector with three columns ( three elements)
A(b,5) = 97;        % row 1, 7,3 columns 5 is redefined as 97
A(4, 7:9) = b;      % row 4. coloumn 7:9 is redefined as b so seventh column = 1, 8  = 7 and 9 = 3
A(A<0.5) = 0;        % for all values in A less than 0.5 set it to 0. which are none
mask = A==0;         % makes a mask that is as big as A with only zeros
A(mask) = 1:sum(mask(:)); % returns nothing as A does not contains any zeros

%% 2.5

A = 1:64;                % redefines A to a vector containing values from 1 to 64
reshape(A, 16, 4)        % reshapes A into a 16 x 4 matrix   
reshape(A, [4 4 4])      % reshapes A into a 4 x 4 x 4 matrix
reshape(A, 4, [], 2, 2)  % reshapes in a matrix with elements as matrises (?)
B = [1 7 2 49];          % defines a vector B
repmat(B, 10, 2)         % repeating the matrix by 10 rows and 2 columns
repmat(B, 4:-1:2)        % repeats 4 rows, 4-1 columns and 2 times in depths

%%  2.6

test = rand(128,128);
imagebw(test,1);
%% 3

[x,y]=meshgrid(-128:127,-128:127);
subplot(1,2,1);imagebw(x,1)
subplot(1,2,2);imagebw(y,1)
r = sqrt(x.^2 + y.^2);
figure(3)
imagebw(r,1);

p1=cos(r/2);
figure(4)
subplot(1,2,1);imagebw(p1,1)
P1 = abs(fft(p1));
subplot(1,2,2);imagebw(P1,1)

% what does fftshift do?
% Shift zero-frequency component to center of spectrum

% what does ifftshift do?
% Inverse FFT shift

%%
p2= cos(r.^2/200);
P2 = abs(fftshift(fft(ifftshift(p2))));

figure(5)
subplot(1,2,1);imagebw(p2,1)
subplot(1,2,2);imagebw(P2,1)

% why not symmetric?

% 
p2=p2.*(r.^2/200<22.5*pi);
P2 = abs(fftshift(fft(ifftshift(p2))));

figure(6)
subplot(1,2,1);imagebw(p2,1)
subplot(1,2,2);imagebw(P2,1)

%% 4

u=x/256*2*pi;
v=y/256*2*pi;

% how do you generate a lowpass filter in the F-domain?
% by multiplyling with a sinc function. ( convolution <-> multiplication)

rho = pi/4;

% How is filtering in the F-domain computed?

% Since the image p2 contains radially increasing frequency, one could expect that the
% result was attenuated outside a certain radius, and largely unaffected in the image
% centre. Why didn’t this happen here?

lp=ones(1,9)/9;
p2fs=conv2(lp,lp',p2);
figure(8)
imagebw(p2fs,1)

% why does it behave differently in different parts?
% circular convolution??

% gaussian filtering

sigma=3;
lp=exp(-0.5*([-6:6]/sigma).^2);
lp=lp/sum(lp);

p2fs=conv2(lp,lp',p2);
figure(9)
imagebw(p2fs,1)

% Why does this filter work better? (Hint: Look at the filter lp’*lp.)
% the later one is several sinus functions with different heigths , compared to the first one
% which is a constant
% gaussian is rotationinvariant

%% 5 

%A=double(imread('paprika.png'))/255;
A=im2double(imread('paprika.png'));
size(A)

subplot(2,2,1);image(A);axis image
for k=1:3,
    subplot(2,2,1+k);
    imagebw(A(:,:,k)*255,0);
end

% which component it which? % brigth color represent high value
% 1.2 = Red
% 2.1 = green
% 2.2 = blue
 
% convert to gray

Ag = rgb2gray(A);
subplot(2,2,1);imagebw(Ag,1);axis image
%% 5.1

df=-1/sigma^2*[-6:6].*lp;

fx=conv2(lp,df',p2,'same');
fy=conv2(df,lp',p2,'same');
z=fx+1i*fy;
figure(11)
subplot(1,2,1);gopimage(z);axis image

% the colour represents different angles of the gradient

z2=abs(z).*exp(1i*2*angle(z));
subplot(1,2,2);gopimage(z2);axis image
% the gradient will always point in the same direction

figure(12)
imagebw(abs(z),1);

% the gradient is zero at places when looking at p2 ... ->

%% 5.2
T=zeros(256,256,3);
T(:,:,1)=fx.*fx;
T(:,:,2)=fx.*fy;
T(:,:,3)=fy.*fy;
figure(13)
subplot(1,2,1);image(tens2RGB(T));axis image

sigma = 5;

lp=exp(-0.5*([-10:10]/sigma).^2);
Tlp=zeros(256,256,3);
Tlp(:,:,1)=conv2(lp,lp',T(:,:,1),'same');
Tlp(:,:,2)=conv2(lp,lp',T(:,:,2),'same');
Tlp(:,:,3)=conv2(lp,lp',T(:,:,3),'same');
subplot(1,2,2);image(tens2RGB(Tlp));axis image


% cos² alfa = t11-T22 etc

%% 5.3

load mystery_vector.mat

[max_value, max_ind] = max(mystery_vector);
mystery_image = reshape(mystery_vector,240,320);

[col ,row] = ind2sub(size(mystery_image),max_ind);
mystery_image(row,col)

sobelx = [ -1 0 1;
           -2 0 2;
           -1 0 1];
matrix_conv = convmtx2(sobelx, 240, 320);
image2 = reshape(matrix_conv*mystery_image(:), size(sobelx) + [240 320]-1);
image3 = conv2(mystery_image,sobelx);
figure(14)
imagebw(image2,1)
figure(15)
imagebw(image3,1)
%% 6

% step = jumps to the breakpoints/ the next breakpoint
% step in = jumps in to the functions that the breakpoints are point at
% step out = jumps out of the steping to the next breakpoint

%%

copyfile('/site/edu/bb/ComputerVision/matlab/debug/*','~/Documents/MATLAB/TSBB15/lektioner')


