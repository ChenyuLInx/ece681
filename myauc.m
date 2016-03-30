function [ size ] = myauc( pD,pF )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
size = abs(trapz(pF,pD));

end

