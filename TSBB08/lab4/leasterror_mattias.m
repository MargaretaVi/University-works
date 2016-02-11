
function out = leasterror(in, start)
%# operation ?midway?
%# returns integer ?Threshold?
%# param in histogram ?Histogram?
%# param start integer ?Start?
num = length(in);
t1 = round(start);
%t1 = midway(in,start);
t0 = t1+2;

% Calculate the threshold
%------------------------
while abs(t0-t1) > 0.5
    
    t0 = t1;
    num0 = t0;
    
    % Calculate mean for the lower part of the histogram
    % --------------------------------------------------
    lowersum1 = in(1:num0)*(1:num0)';
    lowersum2 = sum(in(1:num0));
    if lowersum2 ~= 0
        mean0 = lowersum1/lowersum2;
        var0 = sum(in(1:num0)*((1:num0)' - mean0).^2)/lowersum2;
    else
        mean0 = num0;
        var0 = 0;
    end;
    P0 = lowersum2;
    
    % Calculate mean for the upper part of the histogram
    % --------------------------------------------------
    uppersum1 = in(num0+1:num)*(num0+1:num)';
    uppersum2 = sum(in(num0+1:num));
    if uppersum2  ~= 0
        mean1 = uppersum1/uppersum2;
        var1 = sum(in(num0+1:num)*((num0+1:num)' - mean1).^2)/uppersum2;
    else
        var1 = 0;
        mean1 = num0;
    end;
    P1=uppersum2;
    % Calculate new threshold
    % -----------------------
    %at^2 +bT+c = 0 =>
    if P0~=0 && P1 ~=0
        a = (var1 - var0)/(var0*var1);
        b = 2*(mean1/var1 - mean0/var0);
        c = -2*log(P0/P1) + log(var0/var1) - (mean1^2/var1) + (mean0^2/var0);
        T = round(roots([a b c]));
        distT = abs(t0-T);
        if distT(1)<=distT(2)
            t1 = T(1);
        else
            t1=T(2);
        end
    elseif P0==0 || P1==0
        t1 = round((mean0+mean1)/2);
    end;
    out = t1;
end
end