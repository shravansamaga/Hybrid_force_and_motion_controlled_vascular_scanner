
function valid = validate_joint_limits(robot, q)
% ============================================================
% JOINT LIMIT VALIDATION
% ============================================================

q = q(:);

assert(numel(q) == 3, ...
    'Expected three joint angles.');

limits = robot.joint_limits;

valid = true;

for i = 1:3

    if q(i) < limits(i,1) || q(i) > limits(i,2)

        fprintf('Joint %d violates its limits.\n', i);

        valid = false;

    end

end

if valid
    fprintf('All joint limits satisfied.\n');
end

end
