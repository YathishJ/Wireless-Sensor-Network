%==============
function RxTxM = Wireless_Sensor_Network(numNodes,grid,receiver)
fieldX=500;
fieldY=300;
%Parameters for grid topology
numNodesXY=round(sqrt(numNodes));
step=10;
figure;
%% =============Main================
R=calc_R(numNodes,fieldX,fieldY)
[netM,RxTxM]=create_netM(numNodesXY,step,grid,fieldX,fieldY);
figure('Color','w','Position',[100 100 800 500]);
E=printNet(R,netM,fieldX,fieldY);
RxTxM=WSN_simulation(netM,R,fieldX,fieldY,receiver,RxTxM,E,numNodes);

print_RxTxM(RxTxM,numNodes);


end
