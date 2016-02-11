%% 4

%% 4.1 Rot axis, rot angle and rot mtx


n=2*rand(3,1)-1;
n_hat=n/norm(n);
alpha=2*pi*rand(1,1);
I=eye(3);
square_n_hat=[0 -n_hat(3) n_hat(2); n_hat(3) 0 -n_hat(1); -n_hat(2) n_hat(1) 0];

R=n_hat*n_hat'+cos(alpha)*(I-n_hat*n_hat')+sin(alpha)*square_n_hat

% alpha=acos((trace(R)+1)/2)
% square_n_hat=(R-R')/(2*sin(alpha));
% n_hat=[square_n_hat(3,2); square_n_hat(1,3); square_n_hat(2,1)]


%% 4.2 Mtx exp

%R_e=exp(alpha*square_n_hat)
%or
Rexp=expm(alpha*square_n_hat)


[e1 l1]=eig(R)
[e2 l2]=eig(a*liu_crossop(n))


%% 4.3 unit quuaternions

q=[cos(alpha/2); n_hat*sin(alpha/2)]
nor=norm(q);
q_minus=[cos(alpha/2); -n_hat*sin(alpha/2)];

x0=randn(3,1);
p=[0;x0]
R*x0


rot_x0=quatmultiply(quatmultiply(q',p'),q_minus')

R_q=liu_R_from_q(q)

%% 5.1 create synt data

%% 5.2 est R and t

%% 5.3 est from real data
