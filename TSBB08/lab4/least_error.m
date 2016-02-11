function [ thres] = least_error( in)
%UNTITLED2 Summary of this function goes here
%   least_error thresholding
start=medelvar(in);
start=midway(in,start);


num = length(in);
t1 = round(start);
t0 = t1+2;

% Calculate the threshold
%------------------------
while abs(t0-t1) > 0.5
    
    t0 = t1;
    num0 = t0;
    
    % Calculate mean for the lower part of the histogram
    % --------------------------------------------------
    lowersum1 = sum(in(1:num0)*[1:num0]');
    lowersum2 = sum(in(1:num0));
    if lowersum2 ~= 0
        mean0 = lowersum1/lowersum2;
    else
        mean0 = num0;
    end;
    
    %lowervar1 = in(1:num0)*(((1:num0) - mean0).^2)';
    lowervar1 = sum(in(1:num0)*((1:num0)' - mean0).^2);
    if lowersum2 ~= 0
        var0 = lowervar1/lowersum2;
    else
        var0 = 100;
    end;

    
    % Calculate mean for the upper part of the histogram
    % --------------------------------------------------
    uppersum1 = sum(in(num0+1:num)*(num0+1:num)');
    uppersum2 = sum(in(num0+1:num));
    if uppersum2 ~= 0
        mean1 = uppersum1/uppersum2;
    else
        mean1 = num0;
    end;
    
    uppervar1 = in(num0+1:num)*(((num0+1:num) - mean1).^2)';
    if uppersum2 ~= 0
        var1 = uppervar1/uppersum2;
    else
        var1 = 100;
    end;
    
    % Calculate new threshold
    % -----------------------
    
    %sigma_0 = variance(in(1:first));
    %sigma_1 = variance(in(first +1: num));
    %mean0 = medelvar(1:first);
    %mean1 = medelvar(first +1:num);
    
    P_0 = lowersum2;
    P_1 = uppersum2;
    
    %a=(((sigma_0.*sigma_1).^2)/(sigma_1.^2-sigma_0.^2));
    %b=2*(mean1/(sigma_1^2)-mean0/(sigma_0^2));
    %c=log((sigma_0/sigma_1)^2)-2*log(P_0/P_1)+(mean0/sigma_0)^2-(mean1/sigma_1)^2;
    
    a = (var1 - var0)/(var0*var1);
    b= 2*(-1*mean0/var0 + mean1/var1);
    c = -2*log(P_0/P_1) + log((var0)/(var1)) + (mean0^2)/var0 - ( mean1^2)/var1;
    
    
    if P_0 ~= 0 && P_1 ~= 0
        T=round(roots([a,b,c]));
        r1=T(1)
        r2=T(2)
        if r1>mean0 && r1<mean1
            t1 = r1;
        else
            t1 = r2;
        end
    else
        t1 = round((mean0+mean1)/2);
        display('tbabboon')
    end;
    thres=t1
end

