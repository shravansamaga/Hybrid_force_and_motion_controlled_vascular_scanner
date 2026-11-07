
%% ============================================================
% MILESTONE 5 - ROBOT VISUALIZATION TEST
% ============================================================

clear;
clc;

addpath(genpath(pwd));

%% LOAD PARAMETERS

run('config/robot_parameters.m');

%% TEST CONFIGURATION

q = [
    pi/4;
    pi/6;
    pi/6
    ];

%% STATIC VISUALIZATION

visualize_robot(robot,q);

%% COORDINATE FRAME VISUALIZATION

frames = coordinate_frames(robot,q);

figure('Name','Coordinate Frame Test');

hold on;
grid on;
axis equal;

xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');

plot3([frames.P0(1),frames.P1(1), ...
    frames.P2(1),frames.P3(1),frames.PT(1)], ...
    [frames.P0(2),frames.P1(2), ...
    frames.P2(2),frames.P3(2),frames.PT(2)], ...
    [frames.P0(3),frames.P1(3), ...
    frames.P2(3),frames.P3(3),frames.PT(3)], ...
    'k-o','LineWidth',3);

draw_coordinate_frames(frames,0.08);

view(45,25);

%% ANIMATION TEST

t = linspace(0,1,60)';

trajectory = [
    pi/4 + 0.1*sin(2*pi*t), ...
    pi/6 + 0.2*sin(2*pi*t), ...
    pi/6 + 0.2*cos(2*pi*t)
    ];

animate_robot(robot,trajectory);

fprintf('\nMILESTONE 5 VISUALIZATION TEST COMPLETED\n');
