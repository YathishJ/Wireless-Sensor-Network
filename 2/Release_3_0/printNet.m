% Neigbor matrix creation

function E=printNet(R,netM,fieldX,fieldY)
    set(gca,'FontSize',8,'YGrid','off')
    
    plot(netM(2,:),netM(3,:),'ko','MarkerSize',5,'MarkerFaceColor','b');
       title('Node Transaction b/w Neighbour Matrix Creation')
    xlabel('Field X ')
    ylabel('Field Y ')

    axis([0 fieldX 0 fieldY]);
    hold all;
    radek=1;
    for j=1:numel(netM(1,:))
        for jTemp=1:numel(netM(1,:))
         X1=netM(2,j);
         Y1=netM(3,j);
         X2=netM(2,jTemp);
         Y2=netM(3,jTemp);
         xSide=abs(X2-X1);
         ySide=abs(Y2-Y1);
         d=sqrt(xSide^2+ySide^2);
         if (d<R)&&(j~=jTemp)
             vertice1=[X1,X2];
             vertice2=[Y1,Y2];
             plot(vertice1,vertice2,'-.k','LineWidth',0.1);
             hold all;
             E(radek,1)=j;
             E(radek,2)=jTemp;
             E(radek,3)=d;
             radek=radek+1;
         end
        end
    end
    v=netM(1,:);
    vv=v';
    s=int2str(vv);
    text(netM(2,:)+1,netM(3,:)+3,s,'FontSize',8,'VerticalAlignment','Baseline');
    hold all;
end
