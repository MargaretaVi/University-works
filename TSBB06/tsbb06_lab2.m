%% 4

%% 4.1 Rot axis, rot angle and rot mtx
n = 2*rand(3,1)-1;
n = n/norm(n)
vinkel = 2*pi*rand(1,1)
%
I=eye(3);
square_n_hat=[0 -n(3) n(2); n(3) 0 -n(1); -n(2) n(1) 0];
R=n*n'+cos(vinkel)*(I-n*n')+sin(vinkel)*square_n_hat;

Rn=R*n
% rotation angle and axis
[n_hat, angle] = find_nalpha(R)

%% 4.2 Mtx exp

%R_e=exp(alpha*square_n_hat)
%or
Rexp=expm(vinkel*square_n_hat);

[e1 l1]=eig(Rexp)
[e2 l2]=eig(vinkel*liu_crossop(n_hat))


%% 4.3 unit quuaternions

q=[cos(vinkel/2); n_hat*sin(vinkel/2)]
nor=norm(q)
q_minus=[cos(vinkel/2); -n_hat*sin(vinkel/2)];

x0=randn(3,1);
p=[0;x0];

R_times_x0 = R*x0

rot_x0=liu_qmult(liu_qmult(q,p),q_minus)

%%
R_q=liu_R_from_q(q)
R
%% 5.1 create synt data

% mini of points = 3

N = 9;

x1 = 2*rand(3,N)-1;
t= 2*rand(3,1)-1; % translaton vector
n = 2*rand(3,1)-1;
n = n/norm(n); % normalized rotation vector
a = 2*pi*rand(1,1); %rotation angle
R = liu_rodrigues(n,a); % R from (n,a)

x2 = R*x1 + t*ones(1,N);

% add noise, gaussian

s = 0.01;
x1n = x1 + s*randn(3,N);
x2n = x2 + s*randn(3,N);

%% 5.2 est R and t

a0 = mean(x1n,2);
b0 = mean(x2n,2);
A = x1n - a0*ones(1,N);
B = x2n - b0*ones(1,N);

[U S V] = svd(A*B');
Rest = V*U';
detRest = det(Rest); % check if det(Rest) is one, then it fullfills the condition

test = b0-Rest*a0;

x2e = Rest*x1n + test*ones(1,N);
err = norm(x2e - x2n, 'fro')


%% 5.3 est from real data

load rigiddataA

%%
N_new = 90;
a0_new = mean(data1,2);
b0_new = mean(data2,2);
A_new = data1 - a0_new*ones(1,N_new);
B_new = data2 - b0_new*ones(1,N_new);

[U_new S_new V_new] = svd(A_new*B_new');
RdataA = V_new*U_new';
detRest_new = det(RdataA); % check if det(Rest) is one, then it fullfills the condition

tdataA = b0_new-RdataA*a0_new

x2dataA = RdataA*data1 + tdataA*ones(1,N_new);

[ndataA, alphadataA] = find_nalpha(RdataA)
err = norm(x2dataA - data2, 'fro')

%%
load rigiddataB

N_new = 90;
a0_new = mean(data1,2);
b0_new = mean(data2,2);
A_new = data1 - a0_new*ones(1,N_new);
B_new = data2 - b0_new*ones(1,N_new);

[U_new S_new V_new] = svd(A_new*B_new');
RdataA = V_new*U_new';
detRest_new = det(RdataA); % check if det(Rest) is one, then it fullfills the condition

tdataA = b0_new-RdataA*a0_new

x2dataA = RdataA*data1 + tdataA*ones(1,N_new);

[ndataA, alphadataA] = find_nalpha(RdataA)
err = norm(x2dataA - data2, 'fro')

% change sign of V

[U S V] = svd(A_new*B_new');
tau=sign(det(U)*det(V'));
sigma=eye(3);
sigma(3,3)=tau;
Rgood=V'*sigma*U';
ett=det(Rgood); % check

tdataB_new = b0_new-Rgood*a0_new

x2dataA = Rgood*data1 + tdataA*ones(1,N_new);

[ndataA, alphadataA] = find_nalpha(Rgood)
err2 = norm(x2dataA - data2, 'fro')

