function [Pr0, SNR] = recv_phy(tx, rv, rmodel)
% send packet at PHY layer

global node;
global white_noise_variance;

if node(tx, 3) <= 0
    warning('send_phy: transmission power is zero');
end

Pr0 = recv_power(tx, rv, rmodel);
Pr = 0;
I = find(node(:, 3)>0);
for i=1:length(I)
   tx1 = I(i);
   if tx1 == rv, continue; end
   if tx1 == tx, continue; end
   Pr = Pr + recv_power(tx1, rv, rmodel);
end
% N0 = abs(random('norm', 0, white_noise_variance));
N0 = white_noise_variance;
SNR = db(Pr0/(Pr+N0), 'power');
% disp(['Received power=' num2str(Pr0) '  Interference=' num2str(Pr) '  SNR=' num2str(SNR)]);

return;
