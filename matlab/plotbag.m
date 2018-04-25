% LT Joshua Malia
% ME4823 - MRC
% .bag file data extraction plotting

clear;clc;close all

% Load bag file
bag = rosbag('../data/turtlebot_waypoint.bag');

% Select topic
msg_odom = rosmessage('nav_msgs/Odometry');
showdetails(msg_odom);
bagselect = select(bag,'Topic','/odom');

% Create timeseries
ts1 = timeseries(bagselect,'Pose.Pose.Position.X','Pose.Pose.Position.Y');
ts2 = timeseries(bagselect,'Pose.Pose.Orientation.W','Pose.Pose.Orientation.X','Pose.Pose.Orientation.Y','Pose.Pose.Orientation.Z');
ts3 = timeseries(bagselect,'Twist.Twist.Linear.X','Twist.Twist.Linear.Y');
ts4 = timeseries(bagselect,'Twist.Twist.Angular.Z');

% Rename Data Columns for plotting
X = ts1.Data(:,1); Y = ts1.Data(:,2); 

angles = quat2eul([ts2.Data(:,1) ts2.Data(:,2) ts2.Data(:,3) ts2.Data(:,4)]);
Heading = angles(:,1);

LinearVelocity = ts3.Data(:,1); 
AngularVelocity = ts4.Data(:,1);

% Reset to Relative Time
Time = ts1.Time-ts1.Time(1);

% XY Position Plot
figure(1);
    plot(X,Y);grid on
    xlabel('X Position []'); ylabel('Y Position []')
    title('Turtlebot X/Y Position')

% Heading Plot
figure(2);
    plot(Time,Heading);grid on
    xlabel('Time [s]'); ylabel('Heading [rad]')
    title('Turtlebot Heading')

% Quiver Plot
figure(3);
    U = LinearVelocity.*cos(Heading);
    V = LinearVelocity.*sin(Heading);
    ii = 1:20:length(X);
    quiver(X(ii),Y(ii),U(ii),V(ii)); grid on
    xlabel('X Position []'); ylabel('Y Position []')
    title('Quiver Plot turtlebot/odom')

    
    