function Pr = friis(Pt, Gt, Gr, lambda, L, d)

% Friis free space propagation model:
%        Pt * Gt * Gr * (lambda^2)
%  Pr = --------------------------
%        (4 *pi * d)^2 * L

M = lambda / (4 * pi * d);
Pr = Pt * Gt * Gr * (M * M) / L;

return;