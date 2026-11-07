
function animate_robot(robot, trajectory)
% ============================================================
% 3R VASCULAR SCANNER
% ROBOT ANIMATION
% ============================================================

assert(size(trajectory,2)==3, ...
    'Trajectory must have three joint columns.');

figure('Name','3R Robot Animation','Color','w');

hold on;
grid on;
axis equal;

xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');

title('3R Robotic Manipulator Animation');

xlim([-0.8 0.8]);
ylim([-0.8 0.8]);
zlim([-0.6 0.8]);

view(45,25);

% Fixed base
[X,Y,Z] = cylinder(0.06,40);
Z = Z * robot.base_height;

surf(X,Y,Z,'FaceColor',[0.3 0.3 0.3], ...
    'EdgeColor','none');

% Create animated graphics objects

hBase = plot3(nan,nan,nan,'k','LineWidth',5);
hUpper = plot3(nan,nan,nan,'b','LineWidth',8);
hFore = plot3(nan,nan,nan,'r','LineWidth',7);
hProbe = plot3(nan,nan,nan,'m','LineWidth',4);

hJoints = plot3(nan,nan,nan,'ko', ...
    'MarkerFaceColor','y','MarkerSize',12);

hTip = plot3(nan,nan,nan,'go', ...
    'MarkerFaceColor','g','MarkerSize',10);

for i = 1:size(trajectory,1)

    q = trajectory(i,:)';

    valid = validate_joint_limits(robot,q);

    if ~valid
        error('Trajectory violates joint limits at frame %d.',i);
    end

    frames = coordinate_frames(robot,q);

    P = [frames.P0 frames.P1 frames.P2 ...
        frames.P3 frames.PT];

    set(hBase,'XData',P(1,1:2), ...
        'YData',P(2,1:2), ...
        'ZData',P(3,1:2));

    set(hUpper,'XData',P(1,2:3), ...
        'YData',P(2,2:3), ...
        'ZData',P(3,2:3));

    set(hFore,'XData',P(1,3:4), ...
        'YData',P(2,3:4), ...
        'ZData',P(3,3:4));

    set(hProbe,'XData',P(1,4:5), ...
        'YData',P(2,4:5), ...
        'ZData',P(3,4:5));

    set(hJoints,'XData',P(1,2:4), ...
        'YData',P(2,2:4), ...
        'ZData',P(3,2:4));

    set(hTip,'XData',P(1,5), ...
        'YData',P(2,5), ...
        'ZData',P(3,5));

    drawnow;

end

legend('Base','Upper arm','Forearm', ...
    'Probe mount','Joints','Probe tip');

end
