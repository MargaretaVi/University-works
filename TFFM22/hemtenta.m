A = 3.9083e-3;
B = -5.775e-7;
R0 = 100;
a = 3.85033e-3;
t = 50;
R1 = R0*(1 + A.*t + B.*(t.^2));
R2 = R0*(1 + a.*t);

%R1 = inline('R0*(1 + A.*t + B.*(t.^2))','t','R0','A','B')
%R2 = inline('R0*(1 + a.*t)','t','a','R0')

temp = [0:0.1:100];

%plot(temp,R1(temp,R0,A,B))
%hold on
%plot(temp,R2(temp,a,R0),'r-')
%hold off

%plot(t,R1-R2)

R1-R2

