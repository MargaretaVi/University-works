%% lek 10

initcourse tsrt78
load sig92b
%% a) LMS

theta_hat = zeros(length(y),1);
theta_hat(1) = 0.3;
mu = 0.005/(0.1+(y(1)^2));
for i = 2:length(y)
    phi = -y(i-1);
    theta_hat(i) = theta_hat(i-1) + mu*phi*(y(i) - phi'*theta_hat(i-1)); 
end

plot([th theta_hat])

%% b) RLS

lambda = 0.995;
p(1) = 1;
theta_hat(1) = 0;
% for j = 2:length(y)
%     phi = -y(j-1);
%     p(j) = 1/lambda*(p(j-1)- (p(j-1)*phi*(phi')*p(j-1))/(lambda + phi'*p(j-1)*p(j-1)));
% end
% 
% for i=2:length(y)
% phi = -y(i-1);
% k(i) = p(i-1)*phi/(lambda + phi'*p(i-1)*phi);
% end

for i = 2:length(y) 
    phi = -y(i-1);
    p(i) = 1/lambda*(p(i-1)- (p(i-1)*phi*(phi')*p(i-1))/(lambda + phi'*p(i-1)*p(i-1)));
    k(i) = p(i-1)*phi/(lambda + phi'*p(i-1)*phi);
    theta_hat(i) = theta_hat(i-1) + k(i)*(y(i) - phi'*theta_hat(i-1));
end
 
plot([th theta_hat'])

%% c) Kalman

p(1) = 10^3;
theta_hat(1) = 0;
Q = 1;
R = 1000;

for i = 2:length(y)
    phi = -y(i-1);
    p(i) = p(i-1) - (p(i-1)*phi*(phi')*p(i-1))/(R + phi'*p(i-1)*phi) +Q;
    k(i) = p(i-1)*phi/(R + phi'*p(i-1)*phi);
    theta_hat(i) = theta_hat(i-1) + k(i)*(y(i) - phi'*theta_hat(i-1));
end

plot([th theta_hat'])

%% 9.6

N = 1000;
th(1,:) = [0.5*ones(500,1); 1.2*ones(500,1)]';
th(2,:) = [0.7*ones(300,1); 1.8*ones(700,1)]';

u = zeros(N,1);
y = zeros(N,1);

for i = 2:N
    u(i) = normrnd(0,1);
    y(i) = th(:,i)'*[u(i); u(i-1)]+0.1*normrnd(0,1);
end
% 
% p(1) = 10^3;
% theta_hat(1) = 0;
% Q = eye(2);
% R = 1000*eye(2);
% for i = 2:length(y)
%     phi = [u(i); u(i-1)];
%     p(i) = p(i-1) - (p(i-1)*phi*(phi')*p(i-1))/(R + phi'*p(i-1)*phi) +Q;
%     k(i) = p(i-1)*phi/(R + phi'*p(i-1)*phi);
%     theta_hat(i) = theta_hat(i-1) + k(i)*(y(i) - phi'*theta_hat(i-1));
% end

p = eye(2)*10^3;
theta_hat = [1;1];
Q = [5 0;0 1];
R = 1000;
for i = 2:length(y)
    phi = [u(i); u(i-1)];
    k = p*phi/(R + phi'*p*phi);
    p = p - (p*phi*(phi')*p)/(R + phi'*p*phi) +Q;
    theta_hat(:,i) = theta_hat(:,i-1) + k*(y(i) - phi'*theta_hat(:,i-1));
end
subplot(2,1,1)
plot([th(1,:)' theta_hat(1,:)'])
subplot(2,1,2)
plot([th(2,:)' theta_hat(2,:)'])


%% 




