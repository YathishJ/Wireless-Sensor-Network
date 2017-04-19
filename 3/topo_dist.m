function [d] = topo_dist(i, j);
% return distance between two nodes i and j

global n node;

d = 0;
if i<=0 | i>n, return; end
if j<=0 | j>n, return; end
d = sqrt((node(i, 1) - node(j, 1))^2 + (node(i, 2) - node(j, 2))^2);

return;
