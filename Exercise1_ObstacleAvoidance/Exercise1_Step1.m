classdef Exercise1_Step1 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                     matlab.ui.Figure
        GridLayout                   matlab.ui.container.GridLayout
        LeftPanel                    matlab.ui.container.Panel
        STEP2AddWaypointsLabel_2     matlab.ui.control.Label
        ResettheScenarioButton       matlab.ui.control.Button
        STEP2AddWaypointsLabel       matlab.ui.control.Label
        AddWaypointsInterestPointsButton  matlab.ui.control.Button
        AddTreesObstaclesButton      matlab.ui.control.Button
        AddtreesasObtasclesintheScenarioLabel  matlab.ui.control.Label
        CenterPanel                  matlab.ui.container.Panel
        STEP3OncereadyclickonthebuttontorunthesimulationLabel  matlab.ui.control.Label
        Exercise1Label               matlab.ui.control.Label
        GHC2022CatchingFireLabel     matlab.ui.control.Label
        CreatetheScenarioButton      matlab.ui.control.Button
        UIAxes                       matlab.ui.control.UIAxes
        RightPanel                   matlab.ui.container.Panel
        QuadcoptorinSimulationLabel  matlab.ui.control.Label
        Image4                       matlab.ui.control.Image
        Image3                       matlab.ui.control.Image
        Image2                       matlab.ui.control.Image
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
        twoPanelWidth = 768;
    end

    
    properties (Access = private)
    end
    
    properties (Access = public)
        sData % Description
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            %
             app.sData = SceneCreationData;
            % Create UIAxes
            title(app.UIAxes,"Build the Scenario")
            plot(app.UIAxes, 0,0, '+');
            grid(app.UIAxes, 'on');
            axis(app.UIAxes, 'equal');
             % Set axis
            xlim(app.UIAxes, [-20 20]);
            ylim(app.UIAxes, [-20 20]);
        end

        % Button pushed function: AddTreesObstaclesButton
        function AddTreesObstaclesButtonPushed(app, event)
            app.AddTreesObstaclesButton.Enable = false;
             app.UIAxes.ButtonDownFcn = @(~,data)updateObstacleLocation(app.UIAxes ...
                 , data, app.sData);
        end

        % Button pushed function: ResettheScenarioButton
        function ResettheScenarioButtonPushed(app, event)
            cla(app.UIAxes)
            app.AddTreesObstaclesButton.Enable = true;
            app.AddWaypointsInterestPointsButton.Enable = true;
            app.CreatetheScenarioButton.Enable = false;
            startupFcn(app);
        end

        % Button pushed function: AddWaypointsInterestPointsButton
        function AddWaypointsInterestPointsButtonPushed(app, event)
            app.AddTreesObstaclesButton.Enable = false;
            app.AddWaypointsInterestPointsButton.Enable = false;
            app.CreatetheScenarioButton.Enable = true;
            app.UIAxes.ButtonDownFcn = @(~,data)updateWaypointsLocation(app.UIAxes, data, app.sData);
        end

        % Button pushed function: CreatetheScenarioButton
        function CreatetheScenarioButtonPushed(app, event)
            assignin('base','sceneData',app.sData);
            app.CreatetheScenarioButton.Enable = false;
            Exercise1_Step1_helper;
            
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 3x1 grid
                app.GridLayout.RowHeight = {474, 474, 474};
                app.GridLayout.ColumnWidth = {'1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 1;
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 3;
                app.RightPanel.Layout.Column = 1;
            elseif (currentFigureWidth > app.onePanelWidth && currentFigureWidth <= app.twoPanelWidth)
                % Change to a 2x2 grid
                app.GridLayout.RowHeight = {474, 474};
                app.GridLayout.ColumnWidth = {'1x', '1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = [1,2];
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 2;
            else
                % Change to a 1x3 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {220, '1x', 158};
                app.LeftPanel.Layout.Row = 1;
                app.LeftPanel.Layout.Column = 1;
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 2;
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 3;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 878 474];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {220, '1x', 158};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.BackgroundColor = [0.8 0.8 0.8];
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create AddtreesasObtasclesintheScenarioLabel
            app.AddtreesasObtasclesintheScenarioLabel = uilabel(app.LeftPanel);
            app.AddtreesasObtasclesintheScenarioLabel.WordWrap = 'on';
            app.AddtreesasObtasclesintheScenarioLabel.FontWeight = 'bold';
            app.AddtreesasObtasclesintheScenarioLabel.Position = [12 344 195 44];
            app.AddtreesasObtasclesintheScenarioLabel.Text = 'Add ''trees'' as Obtascles in the Scenario';

            % Create AddTreesObstaclesButton
            app.AddTreesObstaclesButton = uibutton(app.LeftPanel, 'push');
            app.AddTreesObstaclesButton.ButtonPushedFcn = createCallbackFcn(app, @AddTreesObstaclesButtonPushed, true);
            app.AddTreesObstaclesButton.Tooltip = {'Add trees'};
            app.AddTreesObstaclesButton.Position = [13 313 135 23];
            app.AddTreesObstaclesButton.Text = 'Add Trees (Obstacles)';

            % Create AddWaypointsInterestPointsButton
            app.AddWaypointsInterestPointsButton = uibutton(app.LeftPanel, 'push');
            app.AddWaypointsInterestPointsButton.ButtonPushedFcn = createCallbackFcn(app, @AddWaypointsInterestPointsButtonPushed, true);
            app.AddWaypointsInterestPointsButton.Tooltip = {'Add Waypoints'};
            app.AddWaypointsInterestPointsButton.Position = [8 146 184 23];
            app.AddWaypointsInterestPointsButton.Text = 'Add Waypoints (Interest Points)';

            % Create STEP2AddWaypointsLabel
            app.STEP2AddWaypointsLabel = uilabel(app.LeftPanel);
            app.STEP2AddWaypointsLabel.WordWrap = 'on';
            app.STEP2AddWaypointsLabel.FontWeight = 'bold';
            app.STEP2AddWaypointsLabel.Position = [8 212 200 52];
            app.STEP2AddWaypointsLabel.Text = 'Add ''Waypoints'' as Interest Points in the Scenario through which a drone will move around';

            % Create ResettheScenarioButton
            app.ResettheScenarioButton = uibutton(app.LeftPanel, 'push');
            app.ResettheScenarioButton.ButtonPushedFcn = createCallbackFcn(app, @ResettheScenarioButtonPushed, true);
            app.ResettheScenarioButton.Tooltip = {'This option will clear the obstacles and waypoints from the space'};
            app.ResettheScenarioButton.Position = [37 49 124 23];
            app.ResettheScenarioButton.Text = 'Reset the Scenario';

            % Create STEP2AddWaypointsLabel_2
            app.STEP2AddWaypointsLabel_2 = uilabel(app.LeftPanel);
            app.STEP2AddWaypointsLabel_2.WordWrap = 'on';
            app.STEP2AddWaypointsLabel_2.FontSize = 10;
            app.STEP2AddWaypointsLabel_2.FontAngle = 'italic';
            app.STEP2AddWaypointsLabel_2.Position = [11 168 200 52];
            app.STEP2AddWaypointsLabel_2.Text = 'Note - First waypoint will be taken as starting position ';

            % Create CenterPanel
            app.CenterPanel = uipanel(app.GridLayout);
            app.CenterPanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.CenterPanel.Layout.Row = 1;
            app.CenterPanel.Layout.Column = 2;

            % Create UIAxes
            app.UIAxes = uiaxes(app.CenterPanel);
            title(app.UIAxes, 'Create Scenario')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.ButtonDownFcn = createCallbackFcn(app, @updateAppLayout, true);
            app.UIAxes.Position = [36 77 416 334];

            % Create CreatetheScenarioButton
            app.CreatetheScenarioButton = uibutton(app.CenterPanel, 'push');
            app.CreatetheScenarioButton.ButtonPushedFcn = createCallbackFcn(app, @CreatetheScenarioButtonPushed, true);
            app.CreatetheScenarioButton.BackgroundColor = [0.3922 0.8314 0.0745];
            app.CreatetheScenarioButton.Enable = false;
            app.CreatetheScenarioButton.FontSize = 15;
            app.CreatetheScenarioButton.Tooltip = {'Click here if you are ready to create a Scenario'};
            app.CreatetheScenarioButton.Position = [169 15 195 35];
            app.CreatetheScenarioButton.Text = 'Create the Scenario!';

            % Create GHC2022CatchingFireLabel
            app.GHC2022CatchingFireLabel = uilabel(app.CenterPanel);
            app.GHC2022CatchingFireLabel.FontName = 'Arial Black';
            app.GHC2022CatchingFireLabel.FontSize = 20;
            app.GHC2022CatchingFireLabel.Position = [129 435 290 27];
            app.GHC2022CatchingFireLabel.Text = 'GHC 2022 - Catching Fire ';

            % Create Exercise1Label
            app.Exercise1Label = uilabel(app.CenterPanel);
            app.Exercise1Label.HorizontalAlignment = 'center';
            app.Exercise1Label.FontName = 'Arial Black';
            app.Exercise1Label.FontSize = 20;
            app.Exercise1Label.Position = [200 410 134 27];
            app.Exercise1Label.Text = 'Exercise - 1';

            % Create STEP3OncereadyclickonthebuttontorunthesimulationLabel
            app.STEP3OncereadyclickonthebuttontorunthesimulationLabel = uilabel(app.CenterPanel);
            app.STEP3OncereadyclickonthebuttontorunthesimulationLabel.FontWeight = 'bold';
            app.STEP3OncereadyclickonthebuttontorunthesimulationLabel.Position = [56 35 363 52];
            app.STEP3OncereadyclickonthebuttontorunthesimulationLabel.Text = 'STEP 3 - Once ready, click on the button to run the simulation';

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.BackgroundColor = [0.8 0.8 0.8];
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 3;

            % Create Image2
            app.Image2 = uiimage(app.RightPanel);
            app.Image2.Position = [17 24 122 55];
            app.Image2.ImageSource = fullfile(pathToMLAPP, 'mathworks.svg');

            % Create Image3
            app.Image3 = uiimage(app.RightPanel);
            app.Image3.Position = [17 277 122 135];
            app.Image3.ImageSource = fullfile(pathToMLAPP, 'Picture1.jpg');

            % Create Image4
            app.Image4 = uiimage(app.RightPanel);
            app.Image4.Position = [12 162 127 152];
            app.Image4.ImageSource = fullfile(pathToMLAPP, 'Quadcoptor_Sim.PNG');

            % Create QuadcoptorinSimulationLabel
            app.QuadcoptorinSimulationLabel = uilabel(app.RightPanel);
            app.QuadcoptorinSimulationLabel.FontWeight = 'bold';
            app.QuadcoptorinSimulationLabel.Position = [2 168 152 52];
            app.QuadcoptorinSimulationLabel.Text = 'Quadcoptor in Simulation';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Exercise1_Step1

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
