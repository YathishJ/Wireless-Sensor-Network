% function loadAndPrintNet loads the given network from the networkDB.mat
% database and print its layout into the figure.
% number of nodes N = 50,100,400.
% degree d = 8,10,12,14,16,18,20,22,24,26
function loadAndPrintNet(N,d)
load networksDB.mat
R=25; %radio range in meters

switch lower(d)
    case{8}
        p=1;
    case{10}
        p=2;
    case{12}
        p=3;
    case{14}
        p=4;        
    case{16}
        p=5;
    case{18}
        p=6;                
    case{20}
        p=7;
    case{22}
        p=8;
    case{24}
        p=9;
    case{26}
        p=10;
    otherwise
        error('Wrong degree, choose node degree of 8,10,12,14,16,18,20,22,24,26!')
end
switch lower(N)
    case{50}
        net=databaseNets.net50(:,:,p)
    case{100}
        net=databaseNets.net100(:,:,p)
    case{400}
        net=databaseNets.net400(:,:,p)
    otherwise
        error('Wrong number of nodes, you can choose only N=50,100 or 400!')
end

printNet(R,net)

%% Display network
function printNet(R,netM)
    figure('Color','w','Position',[100 100 700 600])
    set(gca,'FontSize',8,'YGrid','off')
    xlabel('\it x \rm [m] \rightarrow')
    ylabel('\it y \rm [m] \rightarrow')
    hold on;
    plot(netM(2,:),netM(3,:),'ko','MarkerSize',5,'MarkerFaceColor','k');
    hold on;
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
             plot(vertice1,vertice2,'-.b','LineWidth',0.1);
             hold on;
         end
         
        end
    end
    v=netM(1,:);
    vv=v';
    s=int2str(vv);
    text(netM(2,:)+1,netM(3,:)+1,s,'FontSize',8,'VerticalAlignment','Baseline');