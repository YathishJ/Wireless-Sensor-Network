function [y, nodes_range_table, hub_range_table] = deploy_node(nodes_per_raw, length, range)

% Deploys n nodes on a grid in a length x length field with 1 hub.
%
% The variable Y returns a n_nodes x 2 matrix where for each line, l, the first column is the
% x value and the second column is the y value of the node l.
% The 3th column is 1 if node is a hub and 0 if it's a source node.

n_nodes = (nodes_per_raw)^2;

% space between nodes
s = length / (nodes_per_raw - 1);

y = [];

for z = 0 : nodes_per_raw - 1
    for x = 0 : nodes_per_raw - 1
        y = [y; [s * x, s * z]];
    end
end

y = [y; round(length/2), round(length/2)];
y(:, 3) = 0;

y(1:n_nodes, 3) = 0;        % Nodes
y(n_nodes + 1 : end, 3) = 1;    % Hub


nodes_range_table = zeros(n_nodes, 40);
hub_range_table = zeros(1, 40);

% Matrix with all the nodes/hubs within the range of the nodes
for i = 1 : n_nodes
    z = dist_calc(i, range, y, n_nodes);
    node_index = find(z > 0);
    nodes_range_table(i, 1 : size(node_index)) = node_index';
end

% Array with the nodes within the range of the hub
z = dist_calc(n_nodes + 1, range, y, n_nodes);
node_index = find(z > 0);
hub_range_table = node_index';

