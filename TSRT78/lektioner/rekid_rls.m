function [ th, yhat] = rekid_rls(y,u,N,lambda)

ny = length(y);
th = zeros(N+1,ny+1);
P = eye(N+1,N+1);
for t=1:ny
    phi = [u(t:-1:max(t-N,1)); zeros(N+1-t,1)];
    P = 1/lambda*(P-(P*phi*phi'*P)/(lambda + phi'*P*phi));
    K = P*phi/(lambda + phi'*P*phi);
    th(:,t+1) = th(:,t)+K*(y(t)-phi'*th(:,t));
    yhat(t) = phi'*th(:,t+1);
end
th = th(:,2:end)';

end

