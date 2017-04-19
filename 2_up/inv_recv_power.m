function [d] = inv_recv_power(rmodel, Pt, Gt, Gr, lambda, L, ht, hr, pathLossExp, d0, Pr)
% d = inv_recv_power('shadowing', Pt, Gt, Gr, lambda, L, ht, hr, pathLossExp, d0, 10^(SNR/10)*white_noise_variance)
% Given received power Pr, or equally SNR, find the corresponding distance d.

switch rmodel
    case 'friis'
        %        Pt * Gt * Gr * (lambda^2)
        %  Pr = --------------------------
        %        (4 *pi * d)^2 * L
        d = sqrt(Pt*Gt*Gr*lambda^2/Pr/L)/4/pi;
    case 'tworay'
        % if d < crossover_dist, use Friis free space model
        % if d >= crossover_dist, use two ray model
        % 	     Pt * Gt * Gr * (ht^2 * hr^2)
        %   Pr = ----------------------------
        %            d^4 * L
        crossover_dist = (4 * pi * ht * hr) / lambda;
        d = sqrt(Pt*Gt*Gr*lambda^2/Pr/L)/4/pi;
        if (d > crossover_dist)
            d = (Pt*Gt*Gr*(hr*hr*ht*ht)/Pr/L)^(1/4);
        end
    case 'shadowing'
        % Pr0 = friss(d0)
        % Pr(db) = Pr0(db) - 10*n*log(d/d0) + X0
        % where X0 is a Gaussian random variable with zero mean and a variance in db
        %        Pt * Gt * Gr * (lambda^2)   d0^pathLossExp    (X0/10)
        %  Pr = --------------------------*-----------------*10
        %        (4 *pi * d0)^2 * L          d^pathLossExp
        % Assume X0=0
        d = (Pt*Gt*Gr*lambda*lambda/(4*pi*d0)^2/L*d0^pathLossExp/Pr)^(1/pathLossExp);
end

return