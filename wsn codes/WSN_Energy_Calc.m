% creation of Node Network and finding the Energy
% X Coordinate value
n= 10;
transmission_range = 200;
x= rand(1,n)*100;
y = rand(1,n)*100;
for i = 1:n
    figure(2);
    plot(x,y,'*k','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                      'MarkerFaceColor','g',...
                       'MarkerSize',5)
    title('Wireless Network with nodes')
    xlabel('X coordinates of the Node')
    ylabel('Y coordinates of the Node')
    text(x(i), y(i), num2str(i));
    hold on;
    for j = 1:n
        distance = sqrt((x(i) - x(j))^2 + (y(i) - y(j))^2);
        if distance <= 100
            matrix(i, j) = 1; % there is a link;
            line([x(i) x(j)], [y(i) y(j)], 'LineStyle', '-');
        else
            matrix(i, j) = inf;
        end;
    end;
end;

%Energy Model (all values in Joules)
%Initial Energy 
Eo = 100;
%Eelec=Etx=Erx (Transmit Energy  ETX and Recieve energy
ETX = 100*0.000000000005 ;
ERX = 1000.000000000005 ;
%Transmit Amplifier types
Efs = 1000*0.000000000005;
Emp = 0.0013 ;
%Data Aggregation Energy
EDA = 5 *0.000000000005 ;

%Computation of do % short distance
do = sqrt(Efs / Emp);

packets_to_sent = 4000;

%Energy calculation of tranmisted energy for Nodes
Energy_Sum_Tx= 0;
Energy_Sum_Rx= 0;
for i= 1:n
    for j = 2:n
         MinDistance = sqrt((x(i) - x(j))^2 + (y(i) - y(j))^2);
        if (MinDistance > do)
               Transmit_Energy = Eo - ( ETX*(packets_to_sent) + Emp*packets_to_sent*( MinDistance^4)); 
        
        else 
                Transmit_Energy = Eo - ( ETX*(packets_to_sent) + Efs*packets_to_sent*( MinDistance^2)); 
        end;
        Energy_Sum_Tx = Energy_Sum_Tx+Transmit_Energy;
          Eo= Energy_Sum_Tx;
    end
Energy_Transmitted(i)= Energy_Sum_Tx;
end

%Energy calculation of Recieved energy for Nodes
for i= 1:n
    for j = 2:n
         MinDistance = sqrt((x(i) - x(j))^2 + (y(i) - y(j))^2);
        if (MinDistance > do)
               Recieved_Energy = Eo - ( ERX*(packets_to_sent) + Emp*4000*( MinDistance^4)); 
        
        else 
                Recieved_Energy = Eo - ( ERX*(packets_to_sent) + Efs*4000*( MinDistance^2)); 
        end;
        Eo= Recieved_Energy;   
        Energy_recieved(i)= Energy_Sum_Rx;
    end
       Energy_Recieved(i) = Energy_Sum_Rx;
end