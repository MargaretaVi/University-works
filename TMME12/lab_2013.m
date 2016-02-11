%lab 2013
%givna värden
m1=20.0;
m2=1.0;
k1=4000;
k2=200;
l01=0.3;
l02=0.1;
c1=0;
c2=0.2;
F0=10;
g=9.82;

t_max=150;


wn1=sqrt(k1/m1);        %egenfrekvensen för kropp 1 utan massdämpare.

%kappa = m2/m1;
%k2opt =m2*((wn1/(1+kappa))^2);
%k2=k2opt;
%c2opt=(2*m2*wn1*(sqrt((kappa*(3-(sqrt(kappa/(2+kappa)))))/(8*((1+kappa)^3)))));
%c2=c2opt;

%begynnelsevillkor:

x1_0=0;
x1_dot_0=0;
x2_0=0;
x2_dot_0=0;


%Utdrag ifrån uppgiften

w=linspace(0.2*wn1,2*wn1,200);         %Vinkelfrekvenser
x1_ampl=zeros(length(w),1);            % Allokera en nollvektor med 200 element

options=odeset('RelTol',1e-3,'AbsTol',1e-6);

for jj=1:length(w)
    
  [t_vek,Y]=ode45(@lab_2013_ekv, [0 t_max], [x1_0 x1_dot_0 x2_0 x2_dot_0], ...
      options,m1,m2,k1,k2,l01,l02,c1,c2,F0,w(jj),g);
  
 x1=Y(:,1);
  
  n=length(t_vek);      %Antal element i t-vek.
  n_90=round(0.9*n);    %Element som motsvarar tiden 0.9*t_max
  
 x1_ampl(jj)=(max(x1(n_90:n))-min(x1(n_90:n)))/2;
  
end

plot(w,x1_ampl)
xlabel('w (rad/s)')
ylabel('Ampituden')
title('Amplituden under fortvarighet mot \omega')



%plottar x1 mot tiden vid ett bestämt \omega
%w = 25;
%[t_vek,Y]=ode45(@lab_2013_ekv, [0 t_max], [x1_0 x1_dot_0 x2_0 x2_dot_0], ...
     % options,m1,m2,k1,k2,l01,l02,c1,c2,F0,w,g);
  
%plot(t_vek, Y(:,1))
%legend('\omega = 25')
%xlabel('Tiden')
%ylabel('Amplituden')

