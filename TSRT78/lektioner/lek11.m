initcourse TSRT78


%% 9.7a
load ecgdata

w = fsamp*2*pi;
[b, a ] = butter(7, [45/(fsamp/2) 55/(fsamp/2)], 'stop');

signal_filt = filtfilt(b,a, ekg);

figure(1)
plot(signal_filt)
hold on
plot(signal)
hold off

%% b
t = (0:1/fsamp:1.5-1/fsamp);
phi = rand(1)*2*pi;
sinus = 10*sin(2*pi*50*t + phi);
sinus = [0 sinus];
ekg_ny = [0; ekg];
mu = 0.001;
[theta, yhat] = rarx([ekg_ny sinus' ], [1 3 1], 'ug', mu );
figure(1)
plot(ekg)
figure(2)
signal_ny = [0; signal];
t_ny = [0 t];
plot(t_ny, signal_ny,t_ny,(ekg_ny-yhat));

%% d

lam = 0.95;
[theta, yhat] = rarx([ekg_ny sinus'], [1 4 1], 'ff', lam );

figure(3)
plot(t_ny,signal_ny,t_ny,(ekg_ny-yhat))


%% 9.12 a 

