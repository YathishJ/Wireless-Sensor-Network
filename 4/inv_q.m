function x = inv_q(y)
% Inverse of Q-function
% y = Q(x) --> x = inv_Q(y)

x = sqrt(2.0) * inv_erfc(2.0 * y);

return;
