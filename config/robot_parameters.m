
%% ============================================================
%  3R VASCULAR SCANNER
%  ROBOT PARAMETERS
%  Milestone 2
% =============================================================

clearvars -except robot;

%% 1. ROBOT GEOMETRY

robot.base_height = 0.20;

robot.L1 = 0.30;       % Upper arm
robot.L2 = 0.25;       % Forearm
robot.L3 = 0.10;       % Probe mounting offset

%% 2. LINK MASSES

robot.m1 = 2.00;
robot.m2 = 1.50;
robot.m3 = 0.50;

%% 3. CENTRE OF MASS

robot.com1 = robot.L1 / 2;
robot.com2 = robot.L2 / 2;

% Probe assembly approximated as a point mass
robot.com3 = robot.L3;

%% 4. MOMENT OF INERTIA
% Initial slender-rod approximation

robot.I1 = (robot.m1 * robot.L1^2) / 12;

robot.I2 = (robot.m2 * robot.L2^2) / 12;

% Initial probe rotational inertia approximation
robot.I3 = 0.001;

%% 5. JOINT LIMITS (RADIANS)

robot.joint_limits = [
    -pi,       pi;
    -pi/2,     pi/2;
    -3*pi/4,   3*pi/4
    ];

%% 6. INITIAL JOINT CONFIGURATION

robot.q_initial = [
    0;
    0;
    0
    ];

%% 7. GRAVITY

robot.gravity = 9.81;

%% 8. PROBE PARAMETERS

robot.probe_mass = robot.m3;
robot.probe_offset = robot.L3;

%% 9. DISPLAY PARAMETERS

disp('3R Robot Parameters Loaded');

disp(robot);

fprintf('Total modelled mass: %.2f kg\n', ...
    robot.m1 + robot.m2 + robot.m3);

fprintf('Upper arm inertia: %.6f kg.m^2\n', ...
    robot.I1);

fprintf('Forearm inertia: %.6f kg.m^2\n', ...
    robot.I2);
