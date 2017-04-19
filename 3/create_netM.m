function [netM,RxTxM]=create_netM(numNodesXY,step,grid,fieldX,fieldY)
ID=1;
for i=1:numNodesXY
    for j=1:numNodesXY
        netM(1,ID)=ID;% inicializaec topologie
        RxTxM(1,ID)=ID; % inicializace matice RxTxM
        if grid==1
            x=step*j+50;
            y=step*i+50;
        else
            x=rand*fieldX;
            y=rand*fieldY;
        end
        netM(2,ID)=x;
        netM(3,ID)=y;
        RxTxM(2,ID)=0;
        RxTxM(3,ID)=0;
        ID=ID+1;
        
    end
end
end
