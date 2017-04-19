function [newid] = new_id(i);
% return a new id for node i

global n packet_id;

newid = 0;
if i<=0 | i>n, return; end
packet_id(i) = packet_id(i) + 1;
newid = packet_id(i);

return;
