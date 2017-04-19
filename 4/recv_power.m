function [Pr] = recv_power(tx, rv, rmodel)
% send packet at PHY layer

global node Gt Gr freq L ht hr pathLossExp std_db d0;
global cs_threshold;

lambda = 3e8 / freq;
Pt = node(tx, 3);
if Pt <= 0
    disp(['In function recv_power: the transmission power of node ' num2str(tx) ' is zero']);
end
% Pt

% Update the position before calculating distance and received power
position_update;

d = sqrt((node(tx, 1)-node(rv, 1))^2+(node(tx, 2)-node(rv, 2))^2);

switch rmodel
    case 'friis'
        Pr = friis(Pt, Gt, Gr, lambda, L, d);
    case 'tworay'
        [Pr, crossover_dist] = tworay(Pt, Gt, Gr, lambda, L, ht, hr, d);
    case 'shadowing'
        Pr = log_normal_shadowing(Pt, Gt, Gr, lambda, L, pathLossExp, std_db, d0, d);
end

% if Pr <= cs_threshold
%     Pr = 0;
% end

return;
