function print_RxTxM(RxTxM,numNodes)
        figure('Color','w','Position',[100 100 800 500])
        RxTxM(4,:)=RxTxM(2,:)+RxTxM(3,:)
        bar(RxTxM(3,:));
        set(gca,'FontSize',6,'YGrid','off','YGrid','on','XLim',[0 numNodes],'XMinorTick','on');
       Xla = xlabel('Node ID');
set(Xla,'FontSize', 12);
Yla = ylabel('Number of packets');
set(Yla,'FontSize', 12);
        
        hold on;
end