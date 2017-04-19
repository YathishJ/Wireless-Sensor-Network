function txtime = tx_time(pkt)

global max_size_mac_body size_mac_header size_rts size_cts size_ack size_plcp;
global basic_rate;

% assume pkt.size <= max_size_mac_body

switch pkt.type
    case 'data'
        txtime = (pkt.size + size_mac_header) / pkt.rate + size_plcp / basic_rate;
    case 'ack'
        txtime = (size_ack + size_plcp) / basic_rate;
    case 'rts'
        txtime = (size_rts + size_plcp) / basic_rate;
    case 'cts'
        txtime = (size_cts + size_plcp) / basic_rate;
    otherwise
        disp(['tx_time: wrong packet type: ' pkt.type]);
end
return;