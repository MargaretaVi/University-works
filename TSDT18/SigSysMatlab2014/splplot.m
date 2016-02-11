function splplot(U,n,fmax)
%splplot
% splplot används lokalt av logspect

global pm1 pm2 pm3 pm4 KlabL FSMAX
vu=vtype(U);
if vu==5,
 f=U(KlabL+2)*(0:KlabL/2-1);
 if nargin<3, fmax=U(KlabL+1)/2; end
elseif vu==6,
 if nargin<3, fmax=bandwi(U); end
 if fmax==inf, fmax=FSMAX/2; end
 f=(0:KlabL/2-1)*2*fmax/KlabL;
 Ut=U(1,3)*poly(U(1,4:3+U(1,2)));
 Un=U(2,3)*poly(U(2,4:3+U(2,2)));
 U=polyval(Ut,j*2*pi*f)./polyval(Un,j*2*pi*f);
elseif vu==9,
 f=(0:KlabL/2-1)/KlabL;
 if nargin<3, fmax=.5; end
elseif vu==10,
 if nargin<3, fmax=.5; end
 f=(0:KlabL/2-1)/KlabL;
 Ut=U(1,3)*poly(U(1,4:3+U(1,2)));
 Un=U(2,3)*poly(U(2,4:3+U(2,2)));
 U=polyval(Ut,exp(j*2*pi*f))./polyval(Un,exp(j*2*pi*f));
end
if vu~=11,
 U=abs(U(1:KlabL/2));
 a=find(f<=fmax);
 %U=max(U,1e-5*ones(size(U)));            % OBS!!! BORTKOMMENTERAD DEC -99
 U=20*log10(U);
 plot(f(a),U(a))
 axis([0 fmax -100 20])
 grid
 b=find(U>=max(U)-3);
 text='Cutoff frequencies ';
 if b(1)~=1,
  text=[text num2str(f(b(1)))];
 end
 c=find(diff(b)>1);
 if length(c)>0,
  if length(text)==19,
   text=[text num2str(f(b(c(1)))) ' , ' num2str(f(b(c(1)+1)))];
  else
   text=[text ' , ' num2str(f(b(c(1)))) ' , ' num2str(f(b(c(1)+1)))];
  end
  for i=2:length(c)-1,
   text=[text ' , ' num2str(f(b(c(i)))) ' , ' num2str(f(b(c(i)+1)))];
  end
 end
 if b(length(b))~=KlabL/2,
  if length(text)==19,
   text=[text num2str(f(b(length(b))))];
  else
   text=[text ' , ' num2str(f(b(length(b))))];
  end
 end
 b=find(text==',');
 if length(b)~=0,
  b=b(length(b));
  text=[text(1:b-1) 'and' text(b+1:length(text))];
 else
  text=[text(1:15) 'y' text(19:length(text))];
 end
 title(text)
 ylabel('Magnitude (dB)')
 if vu==5 | vu==6,
  xlabel('Frequency (Hz)')
 else
  xlabel('Normalized frequency')
 end
 if n==2,
  subplot(2,1,2)
  plot(f(a),U(a))
  axis([0 fmax -5 5])
  grid
  ylabel('Magnitude (dB)')
  if vu==5 | vu==6,
   xlabel('Frequency (Hz)')
  else
   xlabel('Normalized frequency')
  end
 end
else
 if nargin<3, fmax=U(129); end
 if fmax>U(129)-1, fmax=U(129)-1; end
 U=abs(U(1:fmax+1));
 %U=max(U,1e-5*ones(size(U)));            % OBS!!! BORTKOMMENTERAD DEC -99
 U=20*log10(U);
 plot(0:fmax,U,'o')
 axis([0 fmax -100 20])
 hold on
 for i=1:fmax,
  plot([i-1 i-1],[U(i) -100])
 end
 hold off
 grid
 xlabel('Point number')
 ylabel('Magnitude')
 if n==2,
  subplot(2,1,2)
  plot(0:fmax,U,'o')
  axis([0 fmax -5 5])
  hold on
  for i=1:fmax,
   plot([i-1 i-1],[U(i) -5])
  end
  hold off
  grid
  xlabel('Point number')
  ylabel('Magnitude')
 end
end
shg


