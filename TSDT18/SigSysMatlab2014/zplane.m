function zplane(H)
%ZPLANE Plottning av belopp av z-transformer.
%
%    ZPLANE(X) - X är z-transform.
%    
%    Beskrivnig:
%    Plottar nivåkurvor för absolutbeloppet av X[z] på ett område på och
%    innanför enhetscirkeln i z-planet. Poler och nollställen markeras också.
%    Plotten kan vridas genom att "dra" i plotten med musen!
%    
%    Example:
%    H = butterw(3);
%    G = bilintr(H,1,0.2);
%    zplane(G);
%    
%    See also:
%    SPLANE
   
% (c) Lasse Alfredsson

if vtype(H)~=10, error('Input incorrect: not z transform'); end
if max(abs(po(H)))>1, disp('Note: Poles outside |z|=1'); end
clf

N=H(1,3)*poly(H(1,4:3+H(1,2)));
D=H(2,3)*poly(H(2,4:3+H(2,2)));
r=0:.05:1;
phi=(0:.005:1)*2*pi;
X=kron(r,cos(phi)')';
Y=kron(r,sin(phi)')';
Z=X+j*Y;
a=abs(polyval(N,Z)./polyval(D,Z));
cut=5*max(a(length(r),:));
if cut==inf, cut=5; end
a=min(cut*ones(size(a)),a);
plot3(X(length(r),:),Y(length(r),:),a(length(r),:),'r','linewidth',3)
v=25;
h=-10;
view(h,v)
axis([-1 1 -1 1 0 cut/2])
hold on
plot(exp(j*phi))
plot([1 -1],[0 0])
plot([0 0],[1 -1])
for k=1:H(1,2),
 plot(real(H(1,3+k)),imag(H(1,3+k)),'ob','Markersize',6);
end
for k=1:H(2,2),
 plot(real(H(2,3+k)),imag(H(2,3+k)),'xb','Markersize',8);
end
xlabel('Re(z)')
ylabel('Im(z)')
zlabel('Magnitude')
save ZPLANEMAT X Y a h v cut
cont=['set(get(gcf,''currentobject''),''visible'',''off''); zplsub'];
h=uicontrol('style','pushbutton','units','normal','pos',[.45 .8 .15 .06], ...
            'string','Continue','callback',cont);
        
title('Use the mouse to rotate the plot!','fontsize',12)
rotate3d on % Möjliggör rotering av plotten med musen















