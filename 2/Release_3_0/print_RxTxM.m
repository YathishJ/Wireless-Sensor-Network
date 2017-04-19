function print_RxTxM(RxTxM,numNodes)
        figure('Color','w','Position',[100 100 800 500])
        RxTxM(4,:)=RxTxM(2,:)+RxTxM(3,:)
        bar(RxTxM(3,:));
        set(gca,'FontSize',6,'YGrid','off','YGrid','on','XLim',[0 numNodes],'XMinorTick','on');
        xlabel(' Node ID  ');
        ylabel('Number of Messages ');
        
        hold on;
end