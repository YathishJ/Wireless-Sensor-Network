function Pr = log_normal_shadowing(Pt, Gt, Gr, lambda, L, pathlossExp, std_db, d0, d)
% log normal shadowing radio propagation model:
% Pr0 = friss(d0)
% Pr(db) = Pr0(db) - 10*n*log(d/d0) + X0
% where X0 is a Gaussian random variable with zero mean and a variance in db
%        Pt * Gt * Gr * (lambda^2)   d0^passlossExp    (X0/10)
%  Pr = --------------------------*-----------------*10
%        (4 *pi * d0)^2 * L          d^passlossExp

% calculate receiving power at reference distance
Pr0 = friis(Pt, Gt, Gr, lambda, L, d0);

% calculate average power loss predicted by path loss model
avg_db = -10.0 * pathlossExp * log10(d/d0);

% get power loss by adding a log-normal random variable (shadowing)
% the power loss is relative to that at reference distance d0
% question: reset rand does influcence random
rstate = randn('state');
randn('state', d);
powerLoss_db = avg_db + (randn*std_db+0);  % random('Normal', 0, std_db);
randn('state', rstate);

% calculate the receiving power at distance d
Pr = Pr0 * 10^(powerLoss_db/10);

return;