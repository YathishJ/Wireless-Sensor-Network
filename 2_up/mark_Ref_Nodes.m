%% Node highliting
function mark_Ref_Nodes (net,sp,barva)
         for j=1:numel(sp)
             node=sp(j);
             n_X=net(2,node);
             n_Y=net(3,node);
             plot (n_X,n_Y,'bo','LineWidth',3 ,'MarkerEdgeColor', barva,'MarkerSize',6);
         end
end