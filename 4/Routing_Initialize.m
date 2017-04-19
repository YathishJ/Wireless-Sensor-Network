
%%%%%%%%%%%%%%%%%% Routing INITIALIZATIONS %%%%%%%%%%%%%%%%%%%%%%%%%%
% SC leakage per time slot
sc_leakage = 0.0001;
% Packet generation rate
packetgeneration = 10;
% Packet Length in bytes
packet_length = 24;
% All the packets forwarded to the hub
hub_rpackets = zeros(1000000, 5);
% Consumption of a packet transmitted, 
tenergy_per_packet = (59.2 * 10^(-6)) * packet_length;
% Consumption of a packet received, 
renergy_per_packet = (28.6 * 10^(-6)) * packet_length;
% Temporary packet queue, last column is the source node
temp_packet_queue = zeros(100, 6, n_nodes + 1);
%  enegy per time slot [Pv cell outdoor]
henergy = 0.001;
%  rate/percentage
h_percentage = 2;

%%%%%%%%%%%%%%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%%%

% Forwarded packets // lines:n_nodes; Columns: number of messages
% forwarded
for_packets = zeros(n_nodes, 1);
rec_packets = zeros(n_nodes, 1);
% Lost packets
l_packets = zeros(n_nodes, 1);

deadnodes = zeros(n_nodes,1);

l_packet_counter = 1;
h_rpacket_counter = 1;