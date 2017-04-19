function dist = dist_calc(n, range, y, n_nodes)

% The function calculates the distance between a specific node n and the
% others nodes or hubs in y
% Y return 1 if it is in the range and 0 if not for all network

for i = 1 : n_nodes
    h = sqrt((y(n,1) - y(i,1))^2 + (y(n,2) - y(i,2))^2);
    if (h < range && i ~= n)
        dist(i,1) = 1;
    else
        dist(i,1) = 0;
    end
end
