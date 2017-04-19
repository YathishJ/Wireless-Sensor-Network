function routing_table = create_routing_tables(y, nodes_range_table, hub_range_table, rt_lqueue)

% Creates the routing tables
% Y is a matrix that contains the location of the nodes and hubs on the
% field. 
% The 3th column shows if the node is a hub or a node.
% hub_n is the first index in y where the hubs are located.

global range
global n_nodes

% This function adds the hub ID into the routing table of all hub's neighbors
routing_table = route_table_ID_HopCoount(y, hub_range_table);

% Add rt_lqueue-1 lines to the routing table
routing_table(2:rt_lqueue, :, :) = 0;

routing_table = Route_update_table(y, nodes_range_table, routing_table, n_nodes, rt_lqueue);

