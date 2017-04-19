function  rand_network (noOfNodes,L,R)
n= noOfNodes;
rand('state', 0);
figure(1)

%clf;
%hold on;

value_length = L;
value_range = R;
netXloc = rand(1,n)*value_range;
netYloc = rand(1,n)*value_range;
for i = 1:n
    plot(netXloc(i), netYloc(i), '.');
    title('Wireless Network with nodes')
    xlabel('X coordinates of the Node')
    ylabel('Y coordinates of the Node')
    text(netXloc(i), netYloc(i), num2str(i));
    for j = 1:n
        distance = sqrt((netXloc(i) - netXloc(j))^2 + (netYloc(i) - netYloc(j))^2);
        if distance <= value_range
            matrix(i, j) = 1; % there is a link;
            line([netXloc(i) netXloc(j)], [netYloc(i) netYloc(j)], 'LineStyle', ':');
        else
            matrix(i, j) = inf;
        end;
    end;
end;

































% rand('state', 0);
% figure(1);
% clf;
% hold on;
% value_length = L;
% value_range = R;
% netXloc = rand(1,noOfNodes)*value_length;
% netYloc = rand(1,noOfNodes)*value_length;
% for i = 1:noOfNodes
%     plot(netXloc(i), netYloc(i), '.');
%     text(netXloc(i), netYloc(i), num2str(i));
%     for j = 1:noOfNodes
%         % Calculation of the distance.
%         distance(j) = sqrt((netXloc(i) - netXloc(j))^2 + (netYloc(i) - netYloc(j))^2);
%         if distance(j) <= value_range
%             matrix(i, j) = 1; % there is a link;
%             line([netXloc(i) netXloc(j)], [netYloc(i) netYloc(j)], 'LineStyle', ':');
%         else
%             matrix(i, j) = inf;
%         end;
%     end;
% end;