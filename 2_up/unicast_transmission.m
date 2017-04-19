%% Records unicast transmission into the TxRx matrix
function [RxTxM,sp]=unicast_transmission(E,RxTxM,sender,receiver)
        sp=shortestPath(E,sender,receiver);
      
        disp(['Hop-by-Hop Authenitcation from Tx to Rx =' num2str(sp)]);
        for j=1:numel(sp)
            node=sp(j);
            if j==1
                RxTxM(3,node)=RxTxM(3,node)+1;
            elseif j==numel(sp)
                RxTxM(2,node)=RxTxM(2,node)+1;
            else
            RxTxM(2,node)=RxTxM(2,node)+1;
            RxTxM(3,node)=RxTxM(3,node)+1;
            end
               
        end
        
end