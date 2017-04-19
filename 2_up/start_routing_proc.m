

global range
global n_nodes

length = 200;       % length of the field

range = 56;         % range of the nodes

sc_c = 7.65;         % Energy capacity of the SC
rb_c = 75;           % Energy capacity of the RB
rt_lqueue = 25;      % number of hubs route to each node
specs = '_200m';

for nodes = 6 : 2 : 10
    n_nodes = nodes * nodes;
        %close all
        [y, nodes_range_table, hub_range_table] = deploy_node(nodes, length, range);
        % add the residual energy of the SC and RB
        y(:, 4) = sc_c;
        y(:, 5) = rb_c;
        % Call setup_phase to assign  closest route in the routing tables
        routing_table = create_routing_tables(y, nodes_range_table, hub_range_table, rt_lqueue);
        filename=[sprintf('C:/%ix%inodes.mat', nodes, nodes)];
        save(filename, 'routing_table', 'range', 'hub_range_table', 'length', 'n_nodes', 'nodes_range_table', 'rb_c', 'sc_c', 'y');   

end

