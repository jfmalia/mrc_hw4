% LT Joshua Malia
% ME4823 - MRC
% two letter turtle script

clear;clc;
rosshutdown;
rosinit;

% Spawn a Second Turtle
spawn = rossvcclient('/spawn');
msg = rosmessage(spawn);
    msg.X = 6; msg.Y = 6;
call(spawn,msg)

% Teleport the First Turtle
telp = rossvcclient('/turtle1/teleport_absolute');
msg = rosmessage(telp);
    msg.X = 2; msg.Y = 7.5;
call(telp,msg)

% Clear all traces
call(rossvcclient('/clear'))

% Write J


% Write o
Twist2 = rospublisher('/turtle1/pose');
    msg = rosmessage(Twist2)
    msg.LinearVelocity = [5 0 0];
    msg.AngularVelocity =

