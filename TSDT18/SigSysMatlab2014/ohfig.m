function ohfig(parent)
%OHFIG Gör text större och linjer bredare i figur
%   OHFIG(f) ändrar (i figur #f) fontstorleken på 
%   alla figurtexter, vertikala positioner för x-, y- och z-label, 
%   och tjocklek på linjer.
%   Det kan finnas flera ''axes'' per figur.
%   nargin=0 => f=aktuell figur

% Lasse Alfredsson, September 1997

if nargin==0, parent=gcf; end

lw=2;

child=get(parent,'Children');
if isempty(child)		
	if strcmp(get(parent,'type'),'line')		% type==line
		set(parent,'linewidth',lw)
	elseif strcmp(get(parent,'type'),'text')	% type==text
		set(parent,'Fontsize',14)
	elseif strcmp(get(parent,'type'),'axes')	% empty axes
		set(parent,'Fontsize',14)	
	end
else
	if strcmp(get(parent,'type'),'axes')		% type==axes
		set(parent,'FontSize',14)
		set(get(parent,'XLabel'),'FontSize',14)
		set(get(parent,'YLabel'),'FontSize',14)
		set(get(parent,'ZLabel'),'FontSize',14)
		set(get(parent,'Title'),'FontSize',14)
	end
	for a=1:length(child)
		ohfig(child(a))
	end
end



