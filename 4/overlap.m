function [o] = overlap(a, b, c, d)

% check if [a, b] and [c, d] overlap

o = 0;
if (a>c & a<d), o = 1; return; end
if (b>c & b<d), o = 1; return; end
if (c>a & c<b), o = 1; return; end
if (d>a & d<b), o = 1; return; end

return;    