function routing_table = route_table_ID_HopCoount(y, hubs_range_table)



global n_nodes

% Declaring the routing table that will have a maximum of 1 hub address
% with ID and hop count to it in each of the n_nodes dimension!!
routing_table = zeros(1, 2, n_nodes);

[a, b] = size(hubs_range_table);


for j = 1 : b
    if (hubs_range_table(1,j) == 0), break;
    else
        routing_table(1, :, hubs_range_table(1,j)) = [n_nodes + 1, 1];
    end
end


