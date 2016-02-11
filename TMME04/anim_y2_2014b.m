function anim_y2_2014b (t,theta,phi,F_Ah,F_Av,a,t_scale,fig1,fig2)
%Die Kaiserglocke im Kölner Dom.
%Animation routine for computer assignment in Mekanik Y, del 2, 2014.
%Input:
%Vector theta and phi holding the values of "theta" and "phi" for the instants of time
%given in the vector t (output from ode45). F_Ah and F_Av with the
%horizontal and vertical force components at the roof.
%a is the distance between the two hinges. fig1 and fig2 are the numbers of
%the plotting windows that will be used.
%t_scale determines the time scale of the animation. t_scale=1 implies that
%the animation is done without changing the time scale. t_scale=10
%implies that the animation will take 10 times *longer*.


%Clear current figure:
f1=figure(fig1);
set(fig1,'Units','normalized','Position',[0.0 0.3 0.5 0.6])
clf
f2=figure(fig2);
set(fig2,'Units','normalized','Position',[0.5 0.3 0.5 0.6])
clf
figure(fig1)




%Glocke ("standard" xy coordinats here!)
%Local coords:
s_p1=[-1.8;-3];
s_p2=[-0.8;0];
s_p3=[0.8;0];
s_p4=[1.8;-3];

%Klöppel:
s_p5=[0;0];
s_p6=[0;-a];


%Define plotting area of appropriate size:
h1=axes;
set(h1,'XLim',[-4.2 4.2],'YLim',[-3.2 1], ...
'NextPlot','add');
axis equal


angle=theta(1);
Q=[cos(angle) -sin(angle);
    sin(angle) cos(angle)];
r_p1=Q*s_p1;
r_p2=Q*s_p2;
r_p3=Q*s_p3;
r_p4=Q*s_p4;
%
r_p5=Q*s_p5;
r_p6=Q*s_p6;

%Plot for t=0:

h3=plot([r_p1(1) r_p2(1) r_p3(1) r_p4(1)], [r_p1(2) r_p2(2) r_p3(2) r_p4(2)]);
set(h3,'erasemode','xor','LineWidth',2);
h4=plot([r_p5(1) r_p6(1)], [r_p5(2) r_p6(2)]);
set(h4,'erasemode','xor','LineWidth',2);
h5=plot([r_p6(1) r_p6(1)+3*sin(phi(1))], [r_p6(2) r_p6(2)-3*cos(phi(1))]);
set(h5,'erasemode','xor','LineWidth',1);
h6=text(2.5,1,['Tid: ' num2str(t(1),'%4.1f')]);
set(h6,'erasemode','xor')


figure(fig2)
h7=axes('Position',[0.1 0.6 0.8 0.35]);
title('F_{Ah}')
xlabel('t')
set(h7,'XLim',[0 max(t)],'YLim',[min(F_Ah) max(F_Ah)], ...
'NextPlot','add');
h8=plot([t(1)], [F_Ah(1)]);
set(h8,'erasemode','none','LineWidth',1);
%
h9=axes('Position',[0.1 0.1 0.8 0.35]);
title('F_{Av}')
xlabel('t')
set(h9,'XLim',[0 max(t)],'YLim',[min(F_Av) max(F_Av)], ...
'NextPlot','add');
h10=plot([t(1)], [F_Av(1)]);
set(h10,'erasemode','none','LineWidth',1);


t0=clock;
for i=2:length(t)
    
  angle=theta(i);
  Q=[cos(angle) -sin(angle);
    sin(angle) cos(angle)];
  r_p1=Q*s_p1;
  r_p2=Q*s_p2;
  r_p3=Q*s_p3;
  r_p4=Q*s_p4;
  %
  r_p5=Q*s_p5;
  r_p6=Q*s_p6;
  
  
  set(h3,'XData',[r_p1(1) r_p2(1) r_p3(1) r_p4(1)], ...
      'YData',[r_p1(2) r_p2(2) r_p3(2) r_p4(2)]);
  set(h4,'XData',[r_p5(1) r_p6(1)], ...
      'YData',[r_p5(2) r_p6(2)]);
  set(h5,'XData',[r_p6(1) r_p6(1)+3*sin(phi(i))], ...
      'YData',[r_p6(2) r_p6(2)-3*cos(phi(i))]);
  while etime(clock,t0)<t_scale*t(i),end %Wait to plot until t_scale*t(i) seconds have
                                 %elapsed since start of animation. 
  set(h6,'string',['Tid: ' num2str(t(i),'%4.1f')]);
  
  set(h8,'XData',[t(i-1) t(i)], ...
      'YData',[F_Ah(i-1) F_Ah(i)]);
  set(h10,'XData',[t(i-1) t(i)], ...
      'YData',[F_Av(i-1) F_Av(i)]);
  
  drawnow
end

