
function DH = dh_parameters(robot)
% ============================================================
% 3R VASCULAR SCANNER
% STANDARD DENAVIT-HARTENBERG PARAMETERS
% Milestone 4
% ============================================================

% Columns: [theta, d, a, alpha]
% All angles in radians.

DH = [
    0, robot.base_height, 0,       -pi/2;
    0, 0,                 robot.L1, 0;
    0, 0,                 robot.L2 + robot.L3, 0
    ];

end
