% Checks if the occupied slots
tie = find(0 < routing_table(:, 2, node));
for i = 1 : length(tie)
    % Energy consumption by receiving feedback
    % packet
    [y, no_trans] = energy_consumption (y, 'transmiss', 1, routing_table(i, 1, node));
    if (no_trans == 0)
        % Energy consumption by receiving feedback
        % packet
        [y, no] = energy_consumption (y, 'reception', 1, node);
        % Neighbour node with energy
        node_energy = [node_energy, y(routing_table(tie(i), 1, node), 5) + y(routing_table(tie(i), 1, node), 4)];
    elseif (no_trans == 1)
        % Neighbor node without energy
        node_energy = [node_energy, 0];
    end
end

[t u] = max(node_energy);
% Sort routing table per routescore
if(u ~= 1)
    aux = routing_table(1, :, node);
    routing_table(1, :, node) = routing_table(u, :, node);
    routing_table(u, :, node) = aux;
end
node_energy = [];