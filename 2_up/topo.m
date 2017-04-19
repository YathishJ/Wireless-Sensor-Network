function [node] = topo(maxn, maxx, maxy, drawFigure);
% Generate network topology

% S = rand('state');
% rand('state',0);
node = rand(maxn,2);
node(:,1) = node(:,1)*maxx;
node(:,2) = node(:,2)*maxy;
% rand('state',S);

if drawFigure >= 1
    % make background white, run only once
    colordef none,  whitebg
    figure(1);
    axis equal
    hold on;
    box on;
    % grid on;
    plot(node(:, 1), node(:, 2), 'w.', 'MarkerSize', 5);
    title('Node Deployment');
    xlabel('Field X');
    ylabel('Field Y');

    axis([0, maxx, 0, maxy]);
    set(gca, 'XTick', [0; maxx]);
    set(gca, 'YTick', [maxy]);
end

% line([info(i, 2), info(k, 2)], [info(i, 3), info(k, 3)], 'Color', 'k', 'LineStyle', '-', 'LineWidth', 1.5);
return;
