function [tht,Pt,epsi] = arrls( y,na,lambda)
if nargin <3; lambda= 0.99; end
N = length(y);

th = zeros(na,1);
P = 100*eye(na);
for t = na+1:N
    phi = -y(t-1:-1:t-na,:);
    K=P*phi./(lambda+phi'*P*phi);
    P = (P-K*phi'*P)./lambda;
    epsi(:,t) = y(t)-phi'*th;
    th = th+K*epsi(:,t);
    tht(:,t) = th;
    Pt(:,:,t) = P;
    
end

end

