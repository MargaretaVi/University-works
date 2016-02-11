function anim_y2_2014a (t,theta,phi,F_Ah,F_Av,l1,l2,t_scale,fig1,fig2)
%Animation routine for computer assignment in Mekanik Y, del 2, 2014.
%Input:
%Vector theta and phi holding the values of "theta" and "phi" for the instants of time
%given in the vector t (output from ode45). F_Ah and F_Av with the
%horizontal and vertical force components at the roof.
%l1 and l2 are the lengths of the bars. fig1 and fig2 are the numbers of
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



%Calculate the end points of the bars: ("standard" xy coordinats here!)
x_p1=0*theta;
y_p1=0*theta;
x_p2=l1*sin(theta);
y_p2=-l1*cos(theta);
x_p3=x_p2+l2*sin(phi);
y_p3=y_p2-l2*cos(phi);



%Define plotting area of appropriate size:
h1=axes;
set(h1,'XLim',[1.1*(-l1-l2)   1.1*(l1+l2)],'YLim',[1.1*(-l1-l2)   1.1*(l1+l2)], ...
'NextPlot','add');
%axis equal


%Plot for t=0:

h3=plot([x_p1(1) x_p2(1) x_p3(1)], [y_p1(1) y_p2(1) y_p3(1)]);
set(h3,'erasemode','xor','LineWidth',2);
h6=text(1.1,1.5,['Tid: ' num2str(t(1),'%4.1f')]);
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
  set(h3,'XData',[x_p1(i) x_p2(i) x_p3(i)], ...
      'YData',[y_p1(i) y_p2(i) y_p3(i)]);
  
  while etime(clock,t0)<t_scale*t(i),end %Wait to plot until t_scale*t(i) seconds have
                                 %elapsed since start of animation. 
  set(h6,'string',['Tid: ' num2str(t(i),'%4.1f')]);
  set(h8,'XData',[t(i-1) t(i)], ...
      'YData',[F_Ah(i-1) F_Ah(i)]);
  set(h10,'XData',[t(i-1) t(i)], ...
      'YData',[F_Av(i-1) F_Av(i)]);
  
  drawnow
end
