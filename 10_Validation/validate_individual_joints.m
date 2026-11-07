
%% ============================================================
% NUMERICAL JOINT INDEPENDENCE VALIDATION
% ============================================================

clear;
clc;

addpath(genpath(pwd));

run('config/robot_parameters.m');

q0 = [0;0;0];

baseline = coordinate_frames(robot,q0);

joint_names = {'J1','J2','J3'};

for j = 1:3

    q = q0;

    q(j) = pi/6;

    result = coordinate_frames(robot,q);

    fprintf('\nTesting %s\n',joint_names{j});

    if j == 1

        % Base rotation must not change shoulder height.
        assert(norm(result.P1-baseline.P1)<1e-10);

        % Elbow and probe must rotate around base Z.
        assert(norm(result.PT(1:2))>0);

    elseif j == 2

        % Shoulder remains fixed.
        assert(norm(result.P1-baseline.P1)<1e-10);

        % Elbow and probe positions change.
        assert(norm(result.P2-baseline.P2)>1e-6);
        assert(norm(result.PT-baseline.PT)>1e-6);

    elseif j == 3

        % Shoulder and elbow remain fixed.
        assert(norm(result.P1-baseline.P1)<1e-10);
        assert(norm(result.P2-baseline.P2)<1e-10);

        % Probe position changes.
        assert(norm(result.PT-baseline.PT)>1e-6);

    end

    fprintf('%s independence test PASSED\n', ...
        joint_names{j});

end

fprintf('\nALL THREE JOINT TESTS PASSED\n');
