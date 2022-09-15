    sceneData = evalin('base', 'sceneData'); % To assure that the data is read from the base workspace
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
  
    show3D(Scenario);
    
    legend("Start Position","Obstacles")