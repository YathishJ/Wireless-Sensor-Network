function print_RxTxM(RxTxM,numNodes)
        figure('Color','w','Position',[100 100 800 500])
        RxTxM(4,:)=RxTxM(2,:)+RxTxM(3,:)
        bar(RxTxM(4,:));
        set(gca,'FontSize',6,'YGrid','off','YGrid','on','XLim',[0 numNodes],'XMinorTick','on');
        xlabel('\it node ID \rm [-] \rightarrow');
        ylabel('\it Number of messages \rm [-] \rightarrow');
        
        hold on;
end