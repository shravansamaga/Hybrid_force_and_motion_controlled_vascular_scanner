
function result = forward_kinematics(robot, q)
% ============================================================
% 3R VASCULAR SCANNER
% DH-BASED FORWARD KINEMATICS
% ============================================================

q = q(:);

assert(numel(q) == 3, ...
    'Joint vector must contain three angles.');

assert(all(isfinite(q)), ...
    'Joint angles must be finite.');

DH = dh_parameters(robot);

%% INDIVIDUAL LINK TRANSFORMATIONS

A1 = dh_transform( ...
    q(1), DH(1,2), DH(1,3), DH(1,4));

A2 = dh_transform( ...
    q(2), DH(2,2), DH(2,3), DH(2,4));

A3 = dh_transform( ...
    q(3), DH(3,2), DH(3,3), DH(3,4));

%% CUMULATIVE TRANSFORMATIONS

T01 = A1;
T02 = A1 * A2;
T03 = A1 * A2 * A3;

%% OUTPUT

result.T01 = T01;
result.T02 = T02;
result.T03 = T03;

result.position = T03(1:3,4);
result.rotation = T03(1:3,1:3);

end
