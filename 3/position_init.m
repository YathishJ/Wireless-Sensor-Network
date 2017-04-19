function position_init()
% Initialize mobility model and start it
% Should be called after initializing topology and parameters

global node n;
global mobility_model pos maxspeed maxpause;
global maxx maxy;

% pos:
% 1, 2: starting x and y
% 3: starting time
% 4: moving speed or pasue time
% 5, 6: ending x and y

if strcmp(mobility_model, 'random_waypoint') == 0
    return;
end

pos(:, 1:2) = node(:, 1:2);
pos(:, 3) = zeros(n, 1);
pos(:, 4:6) = [rand(n, 1)*maxspeed rand(n, 1)*maxx rand(n, 1)*maxy];
