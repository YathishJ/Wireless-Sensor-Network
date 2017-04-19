function routing_table = Route_update_table(y, nodes_range_table, routing_table, n_nodes, rt_lqueue)



[a, b] = size(nodes_range_table);

cnt = 1;
loop_cnt = 0;
same_hop = 0;
% Loop to consider all nodes' neighbor i
while(cnt ~= 0)
    % detects if there's no more route update
    loop_cnt = loop_cnt +1;
    cnt = 0;
    for i = 1 : a
        r_source = routing_table(1, 1, i); % ID hub of i;
        % it enters in this "if" only if node i hasn't already direct route to the hub
        if (r_source < n_nodes + 1)
            for j = 1 : b
                neighbor_i = nodes_range_table(i, j);
                % If the range table reaches the end then finish column
                if (neighbor_i == 0), break; end
                r_neighbor = routing_table(1, 1, nodes_range_table(i, j));
                hopcount_neighbor = routing_table(1, 2, nodes_range_table(i, j));
                hopcount_source = routing_table(1, 2, i);
                
                % if a hub is in the node's range discard
                if (neighbor_i > n_nodes)
                % if the routing_table of node target is not empty and has
                % a hop count lower than the actual node target (excluding zero)
                elseif (r_neighbor ~= 0 && ((hopcount_neighbor + 1 <= hopcount_source) || hopcount_source == 0))
                    index = find(routing_table(:,2,i) == 0);
                    
                    % Checks if the route is already in the routing_table
                    for r = 1 : rt_lqueue
                        if (routing_table(r, :, i) == [neighbor_i, hopcount_neighbor + 1])
                            same_hop = 1;
                        end
                    end
                    
                    if (same_hop == 0)
                        % if the routing table is empty
                        if (length(index) == rt_lqueue)
                            routing_table(1, 1:2, i) = [neighbor_i, hopcount_neighbor + 1];
                            cnt = 1;
                        elseif (isempty(index) == 1)    % está tudo preenchido
                            %%%%%%%%%%%% paparipapa %%%%%%%%%%%%%
                        elseif (1 <= length(index) < rt_lqueue)
                            routing_table(index(1), 1:2, i) = [neighbor_i, hopcount_neighbor + 1];
                            cnt = 1;
                        end

                        [t u] = sort(routing_table(:, 2, i));
                        aux = [];
                        % if routing_table is still empty do nothing
                        if (routing_table(:, 2, i) == 0)
                        % else sort it by u
                        else
                            for k = 1:length(u)
                                aux(k, :) = routing_table(u(k), :, i);
                            end
                        end
                        % Organize the 0 hops to the begginning
                        u = find(aux(:, 2) == 0);
                        if isempty(u) == 0
                          aux = [aux(u(end) + 1:end,:); aux(1:u(end), :)];
                        end
                        routing_table(:, :, i) = aux;
                    end
                    same_hop = 0;
                end
            end
        end
    end
end


