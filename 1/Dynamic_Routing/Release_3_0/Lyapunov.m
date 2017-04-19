%% -----Generate problem instances---------
M = 5;     % number of secondary users
K = 1;  % number of orthogonal channels
Iters = 4*1e3/1;

rho = 0.2 ;%+ 0.01*(2*rand(1,K)-1);  % QoS constraints of primary users
p1 = 0.2 + 0.1*(2*rand(1,K) - 1); % vector of idle-channel prob
p2 = 0.8 + 0.1*(2*rand(1,K) - 1);
% link capacities 
c_bar = zeros(1,M);
c = c_bar + 0.5*(2*rand(1,M));
c_max = 1;
c2 = c_bar + 0.5*(2*rand(1,K));
% secondary users' flow rates
x = zeros(Iters,M);
x_max = c(1:M);
gamm = zeros(Iters,M);

phi = zeros(M,K);   % resource matrix
phi2 = zeros(Iters,M);   % resource matrix
[phi,cost] = Hungarian(phi);
%phi_bak = zeros(M,K,Iters);
C_MUE = zeros(Iters,K);     % collision variable
% Virtual Queues
Q = zeros(Iters,M);
Z = zeros(Iters,M);
H = zeros(Iters,K);
% Channel state
% S = zeros(Iters,K);

V = 2; % Define Non-negative weight of penanty function
nu = 1; % weight of proportionally fair utility function
%% -----Algorithms-----------------------------------------
t_change = 2000;
W = zeros(M,K);

p = p1; % high channel occupancy  
operation = [zeros(1,1600) ones(1,400)];  %# Fill the vector with 0 and 1
S = operation(randperm(2000))';  %# Randomly reorder it
for iter = 1:t_change  
    %----CFBS level-----------------
    % Performance weighted matrix
    for i=1:M
        for j=1:K
            W(i,j) = Z(iter,i)*c(i)*p(j) - H(iter)*(1-S(iter));
            %W(i,j) = Z(iter,i)*c(i)*p(j) - H(iter)*(1-p(j))*c2(j);
        end
    end
    [phi,cost] = Hungarian(-W); % Resuorce allocation
        
    for i=1:M
        phi2(iter,i) = phi(i);
    end
    %----FUE level------------------
    % Auxiliary Variable
    for i=1:M
        gamm(iter,i) = V/Q(iter,i) - 1/nu;  
        if (gamm(iter,i)<0)
            gamm(iter,i) = 0;
        end
        if (gamm(iter,i)> x_max(i))
            gamm(iter,i) = x_max(i);
        end
    end
    % Flow Control
    for i=1:M
%         cvx_begin
%             variable x_min
%             minimize ((Z(iter,i)-Q(iter,i))*x_min)
%             subject to
%                 x_min <= x_max(i);
%                 x_min >= 0;
%         cvx_end
%         x(iter,i) = x_min;
%         f_min = cvx_optval;  % optimal value of LP
        %fprintf(1,'Optimal value of LP is %0.4f.\n\n',f_min);
        f = Z(iter,i)-Q(iter,i);
        A =  1;
        b = x_max(i);
        lb = zeros(1,1);
        [x_min,fval,exitflag,output,lambda] = linprog(f,A,b,[],[],lb);
        x(iter,i) = x_min;
        f_min = fval;
    end
    %----Update Virtual Queues------
    C_MUE(iter) = 0;
    for i=1:M
        for j=1:K
            Q(iter+1,i) = max(Q(iter,i) + gamm(iter,i) - x(iter,i),0);
            Z(iter+1,i) = max(Z(iter,i) + x(iter,i) - c(i)*p(j)*phi(i),0);
        
            C_MUE(iter,j) = C_MUE(iter,j) + (1-S(iter))*phi(i);
            %C_MUE(iter) = C_MUE(iter) + (1-p(j))*phi(i)*c2(j);
        end
    end
    for i=1:K
        %H(iter+1,i) = max(H(iter,i) - rho*c2(i),0) + C_MUE(iter);
        H(iter+1,i) = max(H(iter,i) - rho,0) + C_MUE(iter);
    end 
    
end  % iter
p = p2;  % low channel occupancy
operation = [zeros(1,400) ones(1,1600)];  %# Fill the vector with 0 and 1
S2 = [S;operation(randperm(2000))'];  %# Randomly reorder it
for iter = (t_change+1):Iters  
    %----CFBS level-----------------
    % Performance weighted matrix
    for i=1:M
        for j=1:K
            W(i,j) = Z(iter,i)*c(i)*p(j) - H(iter)*(1-S2(iter));
            %W(i,j) = Z(iter,i)*c(i)*p(j) - H(iter)*(1-p(j))*c2(j);
        end
    end
    [phi,cost] = Hungarian(-W); % Resuorce allocation
 
    %----FUE level------------------
    % Auxiliary Variable
    for i=1:M
        gamm(iter,i) = V/Q(iter,i) - 1/nu;  
        if (gamm(iter,i)<0)
            gamm(iter,i) = 0;
        end
        if (gamm(iter,i)> x_max(i))
            gamm(iter,i) = x_max(i);
        end
    end
    % Flow Control
    for i=1:M
%         cvx_begin
%             variable x_min
%             minimize ((Z(iter,i)-Q(iter,i))*x_min)
%             subject to
%                 x_min <= x_max(i);
%                 x_min >= 0;
%         cvx_end
%         x(iter,i) = x_min;
%         f_min = cvx_optval;  % optimal value of LP
%         %fprintf(1,'Optimal value of LP is %0.4f.\n\n',f_min);
        f = Z(iter,i)-Q(iter,i);
        A =  1;
        b = x_max(i);
        lb = zeros(1,1);
        [x_min,fval,exitflag,output,lambda] = linprog(f,A,b,[],[],lb);
        x(iter,i) = x_min;
        f_min = fval;
    end
    %----Update Virtual Queues------
    C_MUE(iter) = 0;
    for i=1:M
        for j=1:K
            Q(iter+1,i) = max(Q(iter,i) + gamm(iter,i) - x(iter,i),0);
            Z(iter+1,i) = max(Z(iter,i) + x(iter,i) - c(i)*p(j)*phi(i),0);
        
            C_MUE(iter,j) = C_MUE(iter,j) + (1-S2(iter))*phi(i);
            %C_MUE(iter) = C_MUE(iter) + (1-p(j))*phi(i)*c2;
        end
        
    end
    
    for i=1:K
        %H(iter+1,i) = max(H(iter,i) - rho*c2(i),0) + C_MUE(iter);
        H(iter+1,i) = max(H(iter,i) - rho,0) + C_MUE(iter);
    end 
end  % iter

%% ---------------------Figures-------------------------------------
 x_avg = zeros(Iters,1);
 Q_avg = zeros(Iters,1);
 Z_avg = zeros(Iters,1);
 H_avg = zeros(Iters,1);
 Utility =  zeros(Iters,1);
 for i=1:Iters
     x_avg(i) = (x(i,1)+x(i,2)+x(i,3)+x(i,4)+x(i,5))/5;
     
     Q_avg(i) = (Q(i,1)+Q(i,2)+Q(i,3)+Q(i,4)+Q(i,5))/5;
     Z_avg(i) = (Z(i,1)+Z(i,2)+Z(i,3)+Z(i,4)+Z(i,5))/5;
     H_avg(i) = H(i);
     for j=1:M
        Utility(i) = Utility(i) + log(1+nu*x(i,j));
     end
     
 end
 
figure(1), clf
axis([0 Iters 0 5])
plot( [1:Iters],smooth(x_avg, 50, 'moving'), 'b-', 'LineWidth',1 ), hold on,
%plot( [1:Iters],smooth(x(:,1), 50, 'moving'), 'r-',[1:Iters],smooth(x(:,2), 50, 'moving'), 'g-', [1:Iters],smooth(x(:,3), 50, 'moving'), 'b-',[1:Iters],smooth(x(:,4), 50, 'moving'), 'p-',[1:Iters],smooth(x(:,5), 50, 'moving'), 'black-','LineWidth',1 ), hold on,
xlabel('Iter');
ylabel('Average Rate');

figure(2), clf
axis([0 Iters 0 1])
%semilogy( [1:Iters],smooth(Q_avg, 10, 'moving'), 'r-', 'LineWidth',1 ), hold on,
%semilogy( [1:Iters],smooth(Z_avg, 10, 'moving'), 'b-', 'LineWidth',1 ), hold on,
plot([1:Iters],smooth(Q_avg, 50, 'moving'), 'r-',[1:Iters],smooth(Z_avg, 50, 'moving'), 'b-'), hold on,
xlabel('Iter');
ylabel('Average Backlog');

figure(3), clf
plot( [1:Iters],H_avg, 'g-', 'LineWidth',1 ), hold on,
%plot([1:Iters],Q_avg,'r-',[1:Iters],Z_avg,'b-');
xlabel('Iter');
ylabel('Collision Backlog');

figure(4), clf
plot( [1:Iters],smooth(Utility, 50, 'moving'), 'g-', 'LineWidth',1 ), hold on,
%plot([1:Iters],Q_avg,'r-',[1:Iters],Z_avg,'b-');
xlabel('Iter');
ylabel('Total Utility');