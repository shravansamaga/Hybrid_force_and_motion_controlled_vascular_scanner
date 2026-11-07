
%% ============================================================
% MILESTONE 6 - INDIVIDUAL JOINT TESTING
% ============================================================

clear;
clc;
close all;

addpath(genpath(pwd));

%% LOAD ROBOT PARAMETERS

run('config/robot_parameters.m');

%% SIMULATION SETTINGS

N = 80;
t = linspace(0,1,N)';

%% JOINT 1 TEST - BASE ROTATION

fprintf('\nTESTING JOINT 1 - BASE ROTATION\n');

q1 = zeros(N,3);

q1(:,1) = (pi/3)*sin(2*pi*t);

animate_robot(robot,q1);

%% JOINT 2 TEST - SHOULDER ROTATION

fprintf('\nTESTING JOINT 2 - SHOULDER ROTATION\n');

q2 = zeros(N,3);

q2(:,2) = (pi/4)*sin(2*pi*t);

animate_robot(robot,q2);

%% JOINT 3 TEST - ELBOW ROTATION

fprintf('\nTESTING JOINT 3 - ELBOW ROTATION\n');

q3 = zeros(N,3);

q3(:,3) = (pi/3)*sin(2*pi*t);

animate_robot(robot,q3);

fprintf('\nALL INDIVIDUAL JOINT ANIMATIONS COMPLETED\n');
