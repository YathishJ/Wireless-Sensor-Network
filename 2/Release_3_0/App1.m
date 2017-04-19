% Simulation for different network size
clear all;
% Initialize random number generator
rand('state', 0);
randn('state', 0);
NoOfNodes=20; 
global n node NoOfNodes;
global IDDR_Route_Req_out IDDR_Route_Req_in IDDR_Route_Req_forward;
global IDDR_Route_Req_out IDDR_Route_Req_in IDDR_Route_Req_forward;
global IDDR_Route_Reply_out IDDR_Route_Reply_in IDDR_Route_Reply_forward;
global IDDR_Route_Reply_out IDDR_Route_Reply_in IDDR_Route_Reply_forward IDDR_Route_Reply_destination;

% Parameters
apptype = 'Event_Driven'; 
% Sink (50m; 50m)
%Sink = 50x50;
Radio_Range = 6; %m
%Application_Type = 'Event_driven';
Task_Packet_Size =30; % bytes (Payload) 
Header_Size = 27;% bytes
Buffer_Size = 31; % pkts
log_file = 'log_';
Simulation_Time = 300;
LUI = 1;
MUI = 20;

max_time = Simulation_Time;
ntopo = 1;
nsize = NoOfNodes/10;
itraffic = MUI/4;

for isize = 10:10:(10*nsize)
    n = isize;
    maxx = sqrt(100*100*n/30);
    maxy = maxx;
    disp([' ===== Network size = ' num2str(n) '  maxx = maxy = ' num2str(maxx) ' =====']);
    for itopo = 1:ntopo
        % Reset the parameters
        parameter;
        rand('state', itopo);
        randn('state', itopo);
        % Generate a random network topology
        Sink = maxx*maxy;
        node = topo(n, maxx, maxy, 1);
        node = [node, zeros(n, 2)];
        Event_list = [];
        for k=1:itraffic
            Event_list(k).instant = 1+100*k*slot_time;
            Event_list(k).type = 'send_app';
            Event_list(k).node = k;
            Event_list(k).app.type = apptype;
            Event_list(k).app.key = n+1-k;
            Event_list(k).app.id1 = k;
            Event_list(k).app.id2 = itopo;
            Event_list(k).app.route = [];
            Event_list(k).app.hopcount = 0;
            Event_list(k).net = [];
            Event_list(k).pkt = [];
        end
        % Run the simulation
        tstart = clock;
        run_app1(Event_list', max_time, [log_file, num2str(n)]);
        disp(sprintf('--- Network size= %d, Topology id=%d, Running time=%g \n', n, itopo, etime(clock, tstart)));
        % Log the numbers of 
        n1=sum(IDDR_Route_Req_out);
        n2=sum(IDDR_Route_Req_in);
        n3=sum(IDDR_Route_Req_forward);
        n4=sum(IDDR_Route_Req_out);
        n5=sum(IDDR_Route_Req_in);
        n6=sum(IDDR_Route_Req_forward);
        n7=sum(IDDR_Route_Reply_out);
        n8=sum(IDDR_Route_Reply_in);
        n9=sum(IDDR_Route_Reply_forward);
        n10=sum(IDDR_Route_Reply_out);
        n11=sum(IDDR_Route_Reply_in);
        n12=sum(IDDR_Route_Reply_forward);
        n13=sum(IDDR_Route_Reply_destination);
        fid = fopen([log_file num2str(n) '_IDDR'], 'a');
        if fid == -1, error(['Cannot open log file for IDDR']); end
        fprintf(fid, '%d %d %d %d %d %d %d %d %d %d %d %d %d %d \n', [itopo; n1; n2; n3; n4; n5; n6; n7; n8; n9; n10; n11; n12; n13]);
        fclose(fid);
    end
end
