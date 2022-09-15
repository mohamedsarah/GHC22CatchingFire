%% This script is created for
%% GHC22 - Catching Fire:Using Drones to Detect and Track Wildfires
%% Date - 24 Aug 2022


fprintf("\nRunning the Simulation using Simulink Online\n")
    
   
% -------------------------------------------------------------------------
% Create a Scenario
    
    %Create a UAV Scenario
    Scenario = uavScenario("UpdateRate",100,"ReferenceLocation",[0 0 0]);
    
    %Add a marker to the start of the UAV
    addMesh(Scenario,"cylinder",{[sceneData.WaypointsXY(1,1) sceneData.WaypointsXY(1,2) 1] [0 .01]},[0 0 1]);
    
    % Initial Position and Orientation of the UAV
    InitialPosition = [sceneData.WaypointsXY(1,2) sceneData.WaypointsXY(1,1) -7];
    InitialOrientation = [0 0 0];
    
    % Create a UAV Platform
    platUAV = uavPlatform("UAV",Scenario, ...
                          "ReferenceFrame","NED", ...
                          "InitialPosition",InitialPosition, ...
                          "InitialOrientation",eul2quat(InitialOrientation));
    
    % Add a quadcoptor mesh for visualization
    updateMesh(platUAV,"quadrotor",{1.2},[0 0 1],eul2tform([0 0 pi]));
    
    % Create and Mount Sensor Model
    
    % Specify lidar resolution
    AzimuthResolution = 0.5;
    ElevationResolution = 2;
    
    % Specify Lidar Range
    MaxRange = 7;
    AzimuthLimits = [-179 179];
    ElevationLimits = [-15 15];
    
    % Create statistical sensor model to generate points clouds for the lidar
    % sensor
    LidarModel = uavLidarPointCloudGenerator("UpdateRate",10, ...
                                             "MaxRange",MaxRange, ...
                                             "RangeAccuracy",3, ...
                                             "AzimuthResolution",AzimuthResolution, ...
                                             "ElevationResolution",ElevationResolution, ...
                                             "AzimuthLimits",AzimuthLimits, ...
                                             "ElevationLimits",ElevationLimits, ...
                                             "HasOrganizedOutput",true);
    % Create lidar sensor and mount on the quadcoptor 
    uavSensor("Lidar",platUAV,LidarModel, ...
                    "MountingLocation",[0 0 -0.4], ...
                    "MountingAngles",[0 0 180]);
               
         
    %-------------------------------------------------------------------------
    % Adding Obstacles in the Scenario
    
    obstacleHeight = 2;      % Height of the obstacles
    %obstaclesRadius = 1;    % Width of the obstacles
                 
    tree = stlread('tree1.stl');
    
               
    for i = 1:size(sceneData.ObstacleXY,1)
                                   
             addMesh(Scenario,"custom", ...
                        {tree.Points./50000 + [sceneData.ObstacleXY(i,1) sceneData.ObstacleXY(i,2), obstacleHeight],...
                        tree.ConnectivityList},[0 1 0]);
    end
                
    
    %-------------------------------------------------------------------------
    % Adding Waypoints in the Scenario
    Waypoints = [sceneData.WaypointsXY(:,2), sceneData.WaypointsXY(:,1), -7*ones(size(sceneData.WaypointsXY,1),1)];
    for i = 2:size(Waypoints,1)
        addMesh(Scenario,"cylinder",{[Waypoints(i,2) Waypoints(i,1) 1] [0 0.1]},[1 0 0]);
    end

                     
                
    
%% SECTION 4/4 - Start Simulink Model
                
fprintf("\nLoading Simulink Model.....\n")
    
open_system("ObstacleAvoidanceDemo.slx");
    
    % Setting the controller parameters. These parameters can be tuned for a
    % smoother flight
    % Proportional Gains
    Px = 6;
    Py = 6;
    Pz = 6.5;
    
    % Derivative Gains
    Dx = 1.5;
    Dy = 1.5;
    Dz = 2.5;
    
    % Integral Gains
    Ix = 0;
    Iy = 0;
    Iz = 0;  
    
    % Filter Coefficients
    Nx = 10;
    Ny = 10;
    Nz = 14.4947065605712; 
    
    % Specify gravity, drone mass and sample time for controller and plant
    % blocks
    UAVSampleTime = 0.001;
    Gravity = 9.81;
    DroneMass = 0.1;
    
    out = sim("ObstacleAvoidanceDemo.slx");
    

% %% Visualize the path
% hold on
% points = squeeze(out.trajectoryPoints(1,:,:))';
% plot3(points(:,2),points(:,1),-points(:,3),"-r");
% %legend(["Start Position","Obstacles","","","Waypoints","","","Direct Path","UAV Trajectory"])