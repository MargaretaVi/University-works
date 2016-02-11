
m1=20.0;
m2=1.0;
k1=4000;
k2=200;
F0=10;
w=0:0.1:2*(sqrt(k1/m1));


X1 = (F0.*(k2-m1.*w.^2))./(k2*k1-w.^2.*(k2.*m1 + k1.*m2 + k2.*m2)+ m1.*m2.*w.^4);
X2 = (F0.*m2.*w.^2)./(k1.*k2 - k1.*m2.*w.^2-k2.*m1.*w.^2+m1.*m2.*w.^4-k2.*m2.*w.^2);   

plot(w,abs(X1),w,abs(X2),'r-')
title('Amplituden mot \omega')

xlabel('\omega')
ylabel('Amplitude') 