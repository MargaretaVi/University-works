% [xhat, meas] = filterTemplate;
%% 2
% acc = meas.acc(:,1:end-50);
% t = meas.t(:,1:end-50);
% gyr = meas.gyr(:,1:end-50);
% mag = meas.mag(:,1:end-50);
% oritent = meas.orient(:,1:end-50);

% histogram
% acc
acc_mean = mean(acc(:,~any(isnan(acc),1)),2);
acc_var = var(acc(:,~any(isnan(acc),1))');
acc_cov = cov(acc(:,~any(isnan(acc),1))');
figure(1)
subplot(311)
hist(acc(1,~any(isnan(acc),1)));
subplot(312)
hist(acc(2,~any(isnan(acc),1)));
subplot(313)
hist(acc(3,~any(isnan(acc),1)));
title 'Histogram Acc'


% gyro
gyro_mean = mean(gyr(:,~any(isnan(gyr),1)),2);
gyro_var = var(gyr(:,~any(isnan(gyr),1))');
gyro_cov = cov(gyr(:,~any(isnan(gyr),1))');
figure(2)
subplot(311)
hist(gyr(1,~any(isnan(gyr),1)));
subplot(312)
hist(gyr(2,~any(isnan(gyr),1)));
subplot(313)
hist(gyr(3,~any(isnan(gyr),1)));
title 'Histogram gyr'

% mag
mag_mean = mean(mag(:,~any(isnan(mag),1)),2);
mag_var = var(mag(:,~any(isnan(mag),1))');
mag_cov = cov(mag(:,~any(isnan(mag),1))');
figure(3); 
subplot(311);title 'Histogram mag';
hist(mag(1,~any(isnan(mag),1)));
subplot(312)
hist(mag(2,~any(isnan(mag),1)));
subplot(313)
hist(mag(3,~any(isnan(mag),1)));

% signal
figure(4)
subplot(311)
plot(acc(1,~any(isnan(acc),1)))
subplot(312)
plot(acc(2,~any(isnan(acc),1)))
subplot(313)
plot(acc(3,~any(isnan(acc),1)))

figure(5)
subplot(311)
plot(mag(1,~any(isnan(mag),1)))
subplot(312)
plot(mag(2,~any(isnan(mag),1)))
subplot(313)
plot(mag(3,~any(isnan(mag),1)))

figure(6)
subplot(311)
plot(gyr(1,~any(isnan(gyr),1)))
subplot(312)
plot(gyr(2,~any(isnan(gyr),1)))
subplot(313)
plot(gyr(3,~any(isnan(gyr),1)))

%% 3

figure(7)
euler = q2euler(xhat.x);
euler2 = q2euler(meas.orient);
subplot(311)
plot(xhat.t,euler(1,:),'r',xhat.t,euler2(1,:),'b');

subplot(312)
plot(xhat.t,euler(2,:),'r',xhat.t,euler2(2,:),'b');

subplot(313)
plot(xhat.t,euler(3,:),'r',xhat.t,euler2(3,:),'b');