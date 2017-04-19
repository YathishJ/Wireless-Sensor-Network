function deploy_net(Num_nodes,NW_range)
global NW_nodes;
global segments;
    L = 100; 
    ids = (1:Num_nodes)';
    NW_nodes = [ids L*rand(Num_nodes,2)]; % create random nodes
    plot(NW_nodes(:,2),NW_nodes(:,3),'k.') % plot the nodes
    text(NW_nodes(Num_nodes,2),NW_nodes(Num_nodes,3),...
        [' ' num2str(ids(Num_nodes))],'Color','b','FontWeight','b')
    hold on
    
    num_segs = 0; 
    segments = zeros(Num_nodes*(Num_nodes-1)/2,3);
    for i = 1:Num_nodes-1 % create edges between some of the nodes
        text(NW_nodes(i,2),NW_nodes(i,3),[' ' num2str(ids(i))],'Color','b','FontWeight','b')
        for j = i+1:Num_nodes
            d = sqrt(sum((NW_nodes(i,2:3) - NW_nodes(j,2:3)).^2));
            if (d < NW_range)
                plot([NW_nodes(i,2) NW_nodes(j,2)],[NW_nodes(i,3) NW_nodes(j,3)],'k.-')
                % add this link to the segments list
                num_segs = num_segs + 1;
                segments(num_segs,:) = [num_segs NW_nodes(i,1) NW_nodes(j,1)];
            end
        end
    end
    segments(num_segs+1:Num_nodes*(Num_nodes-1)/2,:) = [];
 %   axis([0 L 0 L]);
%     push_log(strcat('Number of nodes : ',num2str(Num_nodes)));
 %    push_log(strcat('Transmission range : ',num2str(Node_Range))); 
%      
end
