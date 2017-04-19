function [packet_ID, y, packet_queue, hub_rpackets, res_consumption, deadnodes] = BPR_process(y, routing_table, packet_queue, n_nodes, slot_queue, timez, rb_energy, simulation_specs, sc_energy)

% This function routes the packets trough the network

global Iter
packet_ID = 0;

global D
node_energy = [];
Routing_Initialize;
cycle = 1;
for cycle = 1 : timez
   
    Stuck_packet;
    
    %%%%%%%%%%%%%%%%% Forwarding Process %%%%%%%%%%%%%%%%%%%%%%
    for node = 1 : n_nodes
        %%%%%%%%%%%%%%% Energy %%%%%%%%%%%%
        if (y(node, 7) == 0)
            deadnodes(node,1) = 1;
            %sprintf('-> Node %i is dead <-', node)
            continue;
        else
            % SC leakage
            if (y(node, 4) > 0.1)
                y(node, 4) = y(node, 4) - sc_leakage;
            end
            %%%  process %%%%%%%%%%%%
            if (rem(cycle,h_percentage) == rem(node,h_percentage))
                if ((y(node, 5) < rb_energy * (1 - D)) || y(node, 6) == 1)
                    y(node, 5) = y(node, 5) + henergy;
                    y(node, 6) = 1; % RB fully recharging mode on
                    %sprintf('Node %i has reached the battery DoD', node)
                    deadnodes(node,1) = 1;
                    % If battery is fully charged, switch load
                    if (y(node, 5) >= rb_energy)
                        y(node, 6) = 0; % RB fully recharging mode off
                        y(node, 7) = y(node, 7) - 1;
                        %sprintf('Node %i has its battery fully charged and will start now to charge its SC', node)
                    end
                else
                    if (y(node, 4) < (sc_energy - henergy))
                        y(node, 4) = y(node, 4) + henergy;
                    end
                end
            end
            %%%%%%%% END process %%%%%%%%%%%
            
            % if no packet in the queue or no route on the routing table or
            % no energy
            if (packet_queue(1, 1, node) == 0 || routing_table(1, 2, node) == 0 || (y(node, 5) < 1) )
                continue;
                
                % if it has packets in the queue, forward the first
            else
                % if next node is a hub forward directly...
                if (routing_table(1, 2, node) == 1)
                     % checks the energy requirment
                    [y, on] = energy_consumption (y, 'transmiss', packet_length, node);
                    fwd_Stuck_Pkt_using_Twin_Ball_technique;
                
                else
                     if (packet_queue(1, end, node) >= packet_queue(1, end - 1, node))
                        nozero = find(0 < routing_table(:, 2, node));
                        [t u] = min(routing_table(nozero(1):nozero(end), 2, node));

                        By_pass_Infected_area;

                    else % Normal routing
                        Normal_Routing;
                     end
                % Checks the empty space in the destiny packet_queue
                empty_queue = find(temp_packet_queue(:,1, routing_table(1, 1, node)) == 0);
                
                check_energy_requirement;
               
            end
        end
    end
end
for p_temp = 1 : n_nodes
    Traffic_Diversion = find(temp_packet_queue(:, 1, p_temp) ~= 0);
    if (isempty(Traffic_Diversion) == 1)
        continue;
    else
      Intermediary_Beacon_updates;
    end
end
for n = 1 : n_nodes
    zz = find (packet_queue(:,1,n) ~= 0);
    if isempty(zz)==0
        packet_queue(zz(1):zz(end), 3, n) = packet_queue(zz(1):zz(end), 3, n) + 0.1;
    end
end

end


res_consumption = sum(y(1:end-1, 5)) + sum(y(1:end-1, 4));
