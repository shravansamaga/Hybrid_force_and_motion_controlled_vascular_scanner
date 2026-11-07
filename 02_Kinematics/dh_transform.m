
function A = dh_transform(theta, d, a, alpha)
% ============================================================
% STANDARD DH HOMOGENEOUS TRANSFORMATION
% ============================================================

ct = cos(theta);
st = sin(theta);

ca = cos(alpha);
sa = sin(alpha);

A = [
    ct, -st*ca,  st*sa, a*ct;
    st,  ct*ca, -ct*sa, a*st;
    0,   sa,     ca,    d;
    0,   0,      0,     1
    ];

end
