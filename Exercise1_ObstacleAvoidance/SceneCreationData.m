classdef SceneCreationData < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        ObstacleXY = zeros(0, 2);
        WaypointsXY = zeros(0, 2);
    end

    methods
        function reset(obj)
            obj.ObstacleXY = zeros(0,2);
            obj.WaypointsXY = zeros(0,2);
        end

%         function [scene, InitialPosition, Waypoints] = generateScene(obj)
%             scene = uavScenario("UpdateRate",100,"ReferenceLocation",[0 0 0]);
%             addMesh(scene,"cylinder",{[obj.WaypointsXY(1,1) obj.WaypointsXY(1,2) 1] [0 .01]},[0 0 1]);
%             InitialPosition = [obj.WaypointsXY(1,2) obj.WaypointsXY(1,1) -7];
%             InitialOrientation = [0 0 0];
%             platUAV = uavPlatform("UAV",scene, ...
%                 "ReferenceFrame","NED", ...
%                 "InitialPosition",InitialPosition, ...
%                 "InitialOrientation",eul2quat(InitialOrientation));
%             updateMesh(platUAV,"quadrotor",{1.2},[0 0 1],eul2tform([0 0 pi]));
%             AzimuthResolution = 0.5;
%             ElevationResolution = 2;
%             MaxRange = 7;
%             AzimuthLimits = [-179 179];
%             ElevationLimits = [-15 15];
%             LidarModel = uavLidarPointCloudGenerator("UpdateRate",10, ...
%                 "MaxRange",MaxRange, ...
%                 "RangeAccuracy",3, ...
%                 "AzimuthResolution",AzimuthResolution, ...
%                 "ElevationResolution",ElevationResolution, ...
%                 "AzimuthLimits",AzimuthLimits, ...
%                 "ElevationLimits",ElevationLimits, ...
%                 "HasOrganizedOutput",true);
%             uavSensor("Lidar",platUAV,LidarModel, ...
%                 "MountingLocation",[0 0 -0.4], ...
%                 "MountingAngles",[0 0 180]);
%            
%             % xlimits = [-30 0];
%             % ylimits = [-30 0];
%            % color = [0.588 0.294 0];
%            % addMesh(scene,"terrain",{"gmted2010",xlimits,ylimits},color);
% 
%             obstacleHeight = 2;                      % Height of the obstacles
%             %obstaclesRadius = 1;                       % Width of the obstacles
%              
%             tree = stlread('tree1.stl');
% 
%            
%             for i = 1:size(obj.ObstacleXY,1)
%                 %addMesh(scene,"cylinder", ...
%                 %    {[obj.ObstacleXY(i,1) obj.ObstacleXY(i,2) obstaclesRadius], ...
%                 %    [0 obstacleHeight]},0.651*ones(1,3));
%                 
%                 addMesh(scene,"custom", ...
%                     {tree.Points./50000 + [obj.ObstacleXY(i,1) obj.ObstacleXY(i,2), obstacleHeight],...
%                     tree.ConnectivityList},[0 1 0]);
%             end
%             %show3D(scene);
%             
%             Waypoints = [obj.WaypointsXY(:,2), obj.WaypointsXY(:,1), -7*ones(size(obj.WaypointsXY,1),1)];
%             for i = 2:size(Waypoints,1)
%                 addMesh(scene,"cylinder",{[Waypoints(i,2) Waypoints(i,1) 1] [0 0.1]},[1 0 0]);
%             end
%             show3D(scene);
%             legend("Start Position","Obstacles")
%         end
    end
end

