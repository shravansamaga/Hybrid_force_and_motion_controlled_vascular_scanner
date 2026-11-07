
function visualize_robot(robot, q)
% ============================================================
% 3R VASCULAR SCANNER
% 3D ROBOT VISUALIZATION
% Milestone 5
% ============================================================

q = q(:);

assert(numel(q) == 3, ...
    'Three joint angles are required.');

assert(validate_joint_limits(robot,q), ...
    'Joint configuration violates limits.');

%% CALCULATE ROBOT FRAMES

frames = coordinate_frames(robot,q);

P0 = frames.P0;
P1 = frames.P1;
P2 = frames.P2;
P3 = frames.P3;
PT = frames.PT;

%% CREATE FIGURE

figure('Name','3R Vascular Scanner', ...
       'Color','w');

hold on;
grid on;
axis equal;

xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');

title('Spatial 3R Robotic Vascular Scanner');

view(45,25);

xlim([-0.8 0.8]);
ylim([-0.8 0.8]);
zlim([-0.6 0.8]);

%% DRAW BASE

[X,Y,Z] = cylinder(0.06,40);

Z = Z * robot.base_height;

surf(X,Y,Z, ...
    'FaceColor',[0.3 0.3 0.3], ...
    'EdgeColor','none');

%% DRAW ROBOT LINKS

% Base to shoulder
plot3([P0(1) P1(1)], ...
      [P0(2) P1(2)], ...
      [P0(3) P1(3)], ...
      'k','LineWidth',5);

% Upper arm
plot3([P1(1) P2(1)], ...
      [P1(2) P2(2)], ...
      [P1(3) P2(3)], ...
      'b','LineWidth',8);

% Forearm
plot3([P2(1) P3(1)], ...
      [P2(2) P3(2)], ...
      [P2(3) P3(3)], ...
      'r','LineWidth',7);

% Probe mounting offset
plot3([P3(1) PT(1)], ...
      [P3(2) PT(2)], ...
      [P3(3) PT(3)], ...
      'm','LineWidth',4);

%% DRAW JOINTS

points = [P1 P2 P3];

for i = 1:3

    plot3(points(1,i), ...
          points(2,i), ...
          points(3,i), ...
          'ko', ...
          'MarkerFaceColor','y', ...
          'MarkerSize',12);

end

%% DRAW PROBE TIP

plot3(PT(1),PT(2),PT(3), ...
      'go', ...
      'MarkerFaceColor','g', ...
      'MarkerSize',10);

%% LABEL JOINTS

text(P1(1),P1(2),P1(3),' J1');
text(P2(1),P2(2),P2(3),' J2');
text(P3(1),P3(2),P3(3),' J3');

text(PT(1),PT(2),PT(3),' Probe');

%% DRAW GLOBAL COORDINATE FRAME

quiver3(0,0,0,0.15,0,0,'r','LineWidth',2);
quiver3(0,0,0,0,0.15,0,'g','LineWidth',2);
quiver3(0,0,0,0,0,0.15,'b','LineWidth',2);

legend('Base','Base to shoulder', ...
       'Upper arm','Forearm', ...
       'Probe mount','Joints','Probe tip');
%%extra addition
draw_coordinate_frames(frames,0.08);

hold off;

end
