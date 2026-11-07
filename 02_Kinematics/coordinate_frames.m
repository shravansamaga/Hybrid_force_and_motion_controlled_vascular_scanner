
function frames = coordinate_frames(robot, q)
% ============================================================
% 3R VASCULAR SCANNER
% COORDINATE FRAME TRANSFORMATIONS
% Milestone 3
%
% Joint arrangement: Yaw-Pitch-Pitch
% q = [theta1; theta2; theta3] in radians
% ============================================================

%% INPUT VALIDATION

assert(numel(q) == 3, ...
    'Joint vector must contain exactly 3 angles.');

q = q(:);

assert(all(isfinite(q)), ...
    'Joint angles must be finite.');

%% JOINT VARIABLES

theta1 = q(1);
theta2 = q(2);
theta3 = q(3);

%% ROTATION MATRICES

Rz = @(t) [cos(t), -sin(t), 0;
           sin(t),  cos(t), 0;
           0,       0,      1];

Ry = @(t) [cos(t),  0, sin(t);
           0,       1, 0;
          -sin(t),  0, cos(t)];

%% TRANSLATION MATRICES

Tz = @(d) [eye(3), [0; 0; d];
           0, 0, 0, 1];

Tx = @(d) [eye(3), [d; 0; 0];
           0, 0, 0, 1];

%% ROTATION HOMOGENEOUS MATRICES

H_Rz = @(t) [Rz(t), zeros(3,1);
             0, 0, 0, 1];

H_Ry = @(t) [Ry(t), zeros(3,1);
             0, 0, 0, 1];

%% INDIVIDUAL FRAME TRANSFORMATIONS

% Base to shoulder
T01 = Tz(robot.base_height) * H_Rz(theta1);

% Shoulder to elbow
%%T12 = Tx(robot.L1) * H_Ry(theta2);
T12 = H_Ry(theta2) * Tx(robot.L1);
% Elbow to wrist
%%T23 = Tx(robot.L2) * H_Ry(theta3);
T23 = H_Ry(theta3) * Tx(robot.L2);
 
% Wrist to probe tip
T3T = Tx(robot.L3);

%% CUMULATIVE TRANSFORMATIONS

frames.T01 = T01;

frames.T02 = T01 * T12;

frames.T03 = frames.T02 * T23;

frames.T0T = frames.T03 * T3T;

%% EXTRACT FRAME POSITIONS

frames.P0 = [0; 0; 0];

frames.P1 = T01(1:3,4);

frames.P2 = frames.T02(1:3,4);

frames.P3 = frames.T03(1:3,4);

frames.PT = frames.T0T(1:3,4);

%% DISPLAY RESULTS

fprintf('\n3R Coordinate Frames Calculated\n');

fprintf('Shoulder: %.4f %.4f %.4f m\n', ...
    frames.P1);

fprintf('Elbow: %.4f %.4f %.4f m\n', ...
    frames.P2);

fprintf('Wrist: %.4f %.4f %.4f m\n', ...
    frames.P3);

fprintf('Probe Tip: %.4f %.4f %.4f m\n', ...
    frames.PT);

end
