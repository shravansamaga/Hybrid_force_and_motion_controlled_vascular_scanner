
%% MILESTONE 3 - COORDINATE FRAME TEST

clear;
clc;

%% LOAD ROBOT PARAMETERS

run('config/robot_parameters.m');

%% TEST CONFIGURATION

q = [
    0;
    0;
    0
    ];

%% CHECK JOINT LIMITS

valid = validate_joint_limits(robot, q);

assert(valid, 'Joint limit test failed.');

%% CALCULATE FRAMES

frames = coordinate_frames(robot, q);

%% EXPECTED PROBE POSITION

expected = [
    robot.L1 + robot.L2 + robot.L3;
    0;
    robot.base_height
    ];

%% ACTUAL PROBE POSITION

actual = frames.PT;

%% ERROR

error = norm(actual - expected);

fprintf('\nExpected Probe Position:\n');

disp(expected);

fprintf('Actual Probe Position:\n');

disp(actual);

fprintf('Position Error: %.10f m\n', error);

assert(error < 1e-10, ...
    'Coordinate transformation test failed.');

fprintf('\nMILESTONE 3 BASIC TEST PASSED\n');
