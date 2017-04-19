function [Pr, crossover_dist] = tworay(Pt, Gt, Gr, lambda, L, ht, hr, d)
% if d < crossover_dist, use Friis free space model
% if d >= crossover_dist, use two ray model
% Two-ray ground reflection model:
% 	     Pt * Gt * Gr * (ht^2 * hr^2)
%   Pr = ----------------------------
%            d^4 * L
% The original equation in Rappaport's book assumes L = 1.
% To be consistant with the free space equation, L is added here.

crossover_dist = (4 * pi * ht * hr) / lambda;
if (d < crossover_dist)
	Pr = Friis(Pt, Gt, Gr, lambda, L, d);
else
	Pr = Pt * Gt * Gr * (hr * hr * ht * ht) / (d * d * d * d * L);
end

return;
