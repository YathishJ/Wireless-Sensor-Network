
%% Simulates one round of data gathering    
function [RxTxM] = WSN_simulation(net,R,fieldX,fieldY,receiver,RxTxM,E,numNodes)
         RxTxM1 = RxTxM;
        for j=1:numNodes
            sender=j;
            if sender~=receiver
                [RxTxM,sp]=unicast_transmission(E,RxTxM,sender,receiver);
                printNet(R,net,fieldX,fieldY);
                mark_Ref_Nodes (net,sp,'r');
                %pause(0.05);
                hold off;
            end
        end 
  
end