
%% ============================================================
% MILESTONE 4 - DH MODEL VALIDATION
% ============================================================

clear;
clc;

addpath(genpath(pwd));

%% LOAD PARAMETERS

run('config/robot_parameters.m');

%% TEST CONFIGURATIONS

configurations = [
    0,       0,       0;
    pi/4,    pi/6,    pi/6;
    pi/2,   -pi/6,    pi/4;
    -pi/4,    pi/3,   -pi/6
    ];

%% VALIDATE EACH CONFIGURATION

fprintf('\n===== DH MODEL VALIDATION =====\n');

for i = 1:size(configurations,1)

    q = configurations(i,:)';

    %% COORDINATE FRAME MODEL

    frames = coordinate_frames(robot,q);

    %% DH MODEL

    result = forward_kinematics(robot,q);

    %% POSITION COMPARISON

    p_coordinate = frames.PT;

    p_DH = result.position;

    error = norm(p_coordinate - p_DH);

    fprintf('\nConfiguration %d\n',i);

    fprintf('Coordinate model:\n');
    disp(p_coordinate);

    fprintf('DH model:\n');
    disp(p_DH);

    fprintf('Position error: %.12f m\n',error);

    assert(error < 1e-10, ...
        'DH and coordinate models do not match.');

end

fprintf('\nALL DH VALIDATION TESTS PASSED\n');
