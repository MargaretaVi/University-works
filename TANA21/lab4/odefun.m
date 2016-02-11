function [ p ] = odefun( t,v)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

A = [-5*10^-5 1 0 ; -kp -1 -ki; 1 0 0];
b = [-10^-3; 10^-3; 0];
p = @(t,v) A*v +b;

end

