function [ y ] = g( A )

y = exp(1 + A.^2);
y = round(y,5)
end

