% clear;

%=======================================
% Global parameters
global adebug bdebug cdebug;
global n node;
global Gt Gr freq L ht hr pathLossExp std_db d0;
global cs_threshold;
global white_noise_variance;
global rmodel;
global rv_threshold;
global slot_time CW_min CW_max turnaround_time max_retries;
global packet_id retransmit pending_id;
global mac_queue;
global SIFS DIFS;
global backoff_attmpt;
global size_mac_header;
global default_power;
global cca_time;
global backoff_counter backoff_attempt;
global max_size_mac_body size_mac_header size_rts size_cts size_ack size_plcp;
global basic_rate;
global nav;
global ack_tx_time cts_tx_time rts_tx_time;
global default_rate default_ttl;
global size_IDDR_Route_Req size_IDDR_Route_Reply;
global net_queue;
global IDDR_Route_Req_timeout net_pending net_max_retries;
global IDDR_Route_Reply_table;
global bcast_table;
global mac_status;
global adebug bdebug cdebug ddebug;
global rv_threshold_delta;
global IDDR_Route_Req_out IDDR_Route_Req_in IDDR_Route_Req_forward;
global IDDR_Route_Req_out IDDR_Route_Req_in IDDR_Route_Req_forward;
global IDDR_Route_Reply_out IDDR_Route_Reply_in IDDR_Route_Reply_forward;
global IDDR_Route_Reply_out IDDR_Route_Reply_in IDDR_Route_Reply_forward IDDR_Route_Reply_destination;
global mobility_model pos maxspeed maxpause;
%=======================================


%=======================================
% Debug parameters
adebug = 0;
bdebug = 0;
cdebug = 0;
ddebug = 1;
%=======================================


%=======================================
% MAC and PHY parameters of IEEE 802.15.4x
% --------------------------------------
% MAC layer packet size
max_size_mac_body = 2312*8;
size_mac_header = (2+2+6+6+6+2+6+4)*8;  % FC+duration+a1+a2+a3+sequence+a4+fcs
size_rts = (2+2+6+6+4)*8;   % FC+duration+ar+at+fcs
size_cts = (2+2+6+4)*8;     % FC+duration+ar+fcs
size_ack = size_cts;
%---------------------------------------
% FHSS PHY: old: may not be correct, not used
size_plcp_fhss = 96+32; % PLCP preamble + PLCP header
fhss_turnaround_time = 19*1e-6;
fhss_slot_time = 50*1e-6;
fhss_cca_time = 27*1e-6;    % clear channel assessment time?
fhss_SIFS = 28*1e-6;
% --------------------------------------
% DSSS PHY and HR/DSSS (IEEE 802.15.4b, 1999, section 15.3.3)
size_plcp_dsss = 144+48;
dsss_turnaround_time = 5*1e-6;
dsss_slot_time = 20*1e-6;
dsss_cca_time = 15*1e-6;
dsss_SIFS = 10*1e-6;
% --------------------------------------
% OFDM 2.4 GHz: IEEE 802.15.4g (section 19.8.4)
size_plcp_g = 20+4;     % if rate is 1 Mbps
g_RxTxturnaround_time = 5*1e-6;
g_TxRxturnaround_time = 10*1e-6;
g_slot_time = 20*1e-6;   % short is 9 us
g_cca_time = 15*1e-6;   % short is 4 us
g_SIFS = 10*1e-6;
% --------------------------------------
% OFDM 5 GHz: IEEE 802.15.4a (section 17.5.2)
size_plcp_g = 20+4;     % if rate is 1 Mbps
a_RxTxturnaround_time = 2*1e-6;
a_slot_time = 9*1e-6;
a_cca_time = 4*1e-6;   % short is 4 us
a_SIFS = 16*1e-6;
a_CW_min = 4;           % 16=2^4-1
%===========================================


%=======================================
% Radio propagation parameters
rmodel = 'shadowing';
default_power = 0.2;
Gt=1;
Gr=1;
freq=2.4e9; % IEEE 802.15.4a or g
L=1;
ht=1;
hr=1;
pathLossExp=2;
std_db=0.1; % variance used in shadowing (approximately: 10^(std_db/10) = 2%)
d0=1;       % reference distance used in shadowing
% Find N0
% Note: for all three radio propagation models, they are almost the same
% when d is not too large or the log-normal fading is not large.
% when Gt=Gr=L=ht=hr=1 and freq=2.4 GHz, Pr=Pt*(lambda/4/pi/d)^2
% so when d=d0=1, Pr=Pt*1e-6/d^2
% so we choose background noise N0=Pt*1e10 in order to achieve SNR=40 dB
% so we should choose rv_threshold be somewhere below 40 dB
lambda = 3e8 / freq;
d=d0;
switch rmodel
    case 'friis'
        Pr = friis(default_power, Gt, Gr, lambda, L, d);
    case 'tworay'
        [Pr, crossover_dist] = tworay(default_power, Gt, Gr, lambda, L, ht, hr, d);
    case 'shadowing'
        Pr = log_normal_shadowing(default_power, Gt, Gr, lambda, L, pathLossExp, std_db, d0, d);
end
% white_noise_variance is used as N0 when calculating SNR
white_noise_variance = Pr / 1e6;    % SNR will be upper-bounded by 60 dB when d >= d0
max_SNR=db(Pr/white_noise_variance, 'power');
% receive threshold is used to determine if a reception with SNR is above
% this threshold so that the packet can be correctly received.
rv_threshold = 30;      % db
rv_threshold_delta = 0.1;   % around rv_threshold possible packet loss
% carrier sense threthold is used to check if the channel is free to be taken for transmission
% we use Pr(when d=d0)+N0 so if there is a transmitter in distance d0 or multiple transmitter in longer distance,
% the channel will be regarded as busy.
cs_threshold=Pr+white_noise_variance;   % 0.1
%=======================================


%=======================================
% MAC and PHY parameters
%---------------------------------------
% we use IEEE 802.15.4 MAC and IEEE802.15.4 DSSS PHY parameters
size_plcp = size_plcp_dsss;
turnaround_time = dsss_turnaround_time;
slot_time = dsss_slot_time;
cca_time = dsss_cca_time;
SIFS = dsss_SIFS;
DIFS = SIFS + 2*slot_time;
basic_rate = 1e6;
ack_tx_time = (size_ack + size_plcp) / basic_rate;
cts_tx_time = (size_cts + size_plcp) / basic_rate;
rts_tx_time = (size_rts + size_plcp) / basic_rate;
%---------------------------------------
% other MAC and PHY parameters
default_rate = 5e6;         % question: how much fixed rate should we choose?
CW_min = 5;                 % 31 = 2^5-1
CW_max = 10;                % 1023 = 2^10-1
backoff_counter = zeros(n, 1);
backoff_attempt = zeros(n, 1);
packet_id = zeros(n, 1);    % id for next MAC or NET packet
pending_id = zeros(n, 1);   % id of current transmitting MAC packet, used for timeout
max_retries = 3;            % for RTS
retransmit = zeros(n, 1);   % retransmit times for a pending mac packet, <= max_retries
nav = []; for i=1:n, nav(i).start=0; nav(i).end=0; end
mac_queue = []; for i=1:n, mac_queue(i).list=[]; end
mac_status = []; for i=1:n, mac_status(i)=0; end
%=======================================


%=======================================
% NET parameters
default_ttl = 7;
IDDR_Route_Req_timeout = 0.2;   % question
size_IDDR_Route_Req = 22*8;
size_IDDR_Route_Reply = 22*8;
net_max_retries = 3;
net_pending = []; for i=1:n, net_pending(i).id=[]; net_pending(i).retransmit=[]; end
net_queue = []; for i=1:n, net_queue(i).list=[]; end
IDDR_Route_Reply_table = []; for i=1:n, IDDR_Route_Reply_table(i).list=[]; end   % record of sent IDDR_RREP
bcast_table = zeros(n, n);              % record of broadcast id
IDDR_Route_Req_out = zeros(n, 1);
IDDR_Route_Req_in = zeros(n, 1);
IDDR_Route_Req_forward = zeros(n, 1);
IDDR_Route_Req_out = zeros(n, 1);
IDDR_Route_Req_in = zeros(n, 1);
IDDR_Route_Req_forward = zeros(n, 1);
IDDR_Route_Reply_out = zeros(n, 1);
IDDR_Route_Reply_in = zeros(n, 1);
IDDR_Route_Reply_forward = zeros(n, 1);
IDDR_Route_Reply_out = zeros(n, 1);
IDDR_Route_Reply_in = zeros(n, 1);
IDDR_Route_Reply_forward = zeros(n, 1);
IDDR_Route_Reply_destination = zeros(n, 1);
%=======================================


%=======================================
% Mobility parameters
model =  'random_waypoint' ; %'none'; % or
pos = zeros(n, 6);
maxspeed = 0;
maxpause = 0;
%=======================================
