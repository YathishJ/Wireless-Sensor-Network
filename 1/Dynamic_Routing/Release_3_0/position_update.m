function position_update()
% Update position when nodes are moving

global node n;
global mobility_model pos maxspeed maxpause;
global current_time;
global maxx maxy;

% pos:
% 1, 2: starting x and y
% 3: starting time
% 4: moving speed or pasue time
% 5, 6: ending x and y

if strcmp(mobility_model, 'random_waypoint') == 0
    return;
end

for i=1:n
    if pos(i, 3) > current_time
        disp(['position: the starting time ' num2str(pos(i, 3)) ' for node ' num2str(i) ' is larger than current time ' num2str(current_time)]);
        continue;
    end
    if pos(i, 1)==pos(i, 5) & pos(i, 2)==pos(i, 6)
        % I am pause
        while 1
            % if i==1, disp(['position_update: at time ' num2str(current_time) ' node 1 is pause at (x, y)=' num2str(pos(1, 1)) ', ' num2str(pos(1, 2))]); end
            if (pos(i, 3)+pos(i, 4)) >= current_time
                node(i, 1:2) = pos(i, 1:2);
                break;
            end
            % moving
            pos(i, 3) = pos(i, 3) + pos(i, 4);
            pos(i, 5) = rand*maxx;
            pos(i, 6) = rand*maxy;
            pos(i, 4) = rand*maxspeed;
            tempt = sqrt((pos(i, 1)-pos(i, 5))^2+(pos(i, 2)-pos(i, 6))^2)/pos(i, 4);
            if (pos(i, 3)+tempt) >= current_time
                u=(current_time-pos(i, 3))/tempt;
                node(i, 1:2) = pos(i, 1:2)*(1-u) + pos(i, 5:6)*u;
                break;
            end
            % pause
            pos(i, 1:2) = pos(i, 5:6);
            pos(i, 3) = pos(i, 3) + tempt;
            pos(i, 4) = rand*maxpause;
        end
    else
        % I am moving
        while 1
            % if i==1, disp(['position_update: at time ' num2str(current_time) ' node 1 is moving from (x, y)=' num2str(pos(1, 1)) ', ' num2str(pos(1, 2)) ' at speed=' num2str(pos(1, 4))]); end
            tempt = sqrt((pos(i, 1)-pos(i, 5))^2+(pos(i, 2)-pos(i, 6))^2)/pos(i, 4);
            if (pos(i, 3)+tempt) >= current_time
                u=(current_time-pos(i, 3))/tempt;
                node(i, 1:2) = pos(i, 1:2)*(1-u) + pos(i, 5:6)*u;
                break;
            end
            pos(i, 1:2) = pos(i, 5:6);
            pos(i, 3) = pos(i, 3) + tempt;
            pos(i, 4) = rand*maxpause;
            if (pos(i, 3)+pos(i, 4)) >= current_time
                node(i, 1:2) = pos(i, 1:2);
                break;
            end
            pos(i, 3) = pos(i, 3) + pos(i, 4);
            pos(i, 5) = rand*maxx;
            pos(i, 6) = rand*maxy;
            pos(i, 4) = rand*maxspeed;
        end
    end
end

% disp(['position_update: at time ' num2str(current_time) ' node 1 is located at (x, y)=' num2str(node(1, 1)) ', ' num2str(node(1, 2))]);

return;
