%% 2.3 bc

T =1 ;
N = 32;
w_1 = 1;
n = [1:N];
y(n) = cos(w_1*n);

[Y,w] = dtft(y(n));

figure(1)
plot(w,abs(Y))  % leakage due to truncation

%% 2.5

T = 3.9*10^-4;
N =length(u2);
signal = load('power');
u2 = signal.u2;

y =u2(1:3:end);

figure(2)
subplot (2,1,1)
[U2, w] = dtft(u2,T);
plot(w,abs(U2));

subplot(2,1,2)
[Y,w] = dtft(y,3*T);
plot(w,abs(Y))

%% b

u2_low = decimate(u2,3);


figure(3)
subplot (2,1,1)
[U2, w] = dtft(u2,T);
plot(w,abs(U2));

subplot(2,1,2)
[U2_low,w] = dtft(u2_low,3*T);
plot(w,abs(U2_low))

%% 2.10 a
N = 16;
n = 1:16;
T =1;
w= 2*pi/N*n;
x0(n) = cos(2*pi*n/8);
x1(n) = cos(2*pi*n/7);

X0 = fft(x0);
X1 = fft(x1);

figure(4)
subplot (2,1,1)
stem(w,abs(X0)), 'r';
hold on
[X0_dtft, w0] = dtft(x0,T);
plot(w0,abs(X0_dtft));
hold off

subplot(2,1,2)
stem(w,abs(X1)), 'r';
hold on
[X1_dtft, w1] = dtft(x1,T);
plot(w1,abs(X1_dtft));
hold off

%% 2.10 b

N = 16;
p = 2;

x0_app = [x0,zeros(1,(p-1)*N)];
x1_app = [x1,zeros(1,(p-1)*N)];

X0_app = fft(x0_app);
X1_app = fft(x1_app);

figure(5)
subplot (2,1,1)
stem(2*pi/N/p*(0:N*p-1),abs(X0_app))

subplot(2,1,2)
stem(2*pi/N/p*(0:N*p-1),abs(X1_app))


%% 2.22b

w0 = 2*pi/sqrt(17);
N = 16;
n = 1:16;

x(n) = sin(w0*n);
X = fft(x);

x_32 = [x,zeros(1,(2-1)*N)];
X_32 = fft(x_32,2*N);

x_64 = [x,zeros(1,(4-1)*N)];
X_64 = fft(x_64);

x_256 = [x,zeros(1,(16-1)*N)];
X_256 = fft(x_256);

figure(6)
subplot (3,1,1)
stem(2*pi/32*[0:31],abs(X_32));
hold on
plot(2*pi/N*[0:N-1], abs(X),'r*');

subplot (3,1,2)
stem(2*pi/32*[0:63],abs(X_64));
hold on
plot(2*pi/N*[0:N-1]*2, abs(X),'r*');

subplot (3,1,3)
stem(2*pi/32*[0:255],abs(X_256));
hold on
plot(2*pi/N*[0:N-1]*8, abs(X),'r*');