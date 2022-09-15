% This is the code for checking workshop folder
% as part of the Catching Fire Workshop presented
% at the GHC 2022

% Run this file to check your environment


% Check permissions for Exercise1
fileName = 'Exercises';
[fid,errmsg] = fopen(fileName, 'w');
if ~isempty(errmsg)&&strcmp(errmsg,'Permission denied') 
    fprintf('\nError: You do not have write permission in the folder containing (%s).\n',fileName);
    fprintf('\nPlease make a copy of the original workshop folder and navigate to it.\n');
    fprintf('You will run the exercises out of the folder copy you created.\n');
else
    fprintf('\nWelcome to the Catching Fire Workshop at GHC22.\n');
    fprintf('\nYou have write permission in this folder.\n');
    fprintf('\nInitializing the exercises...\n');
    % Add files to path
    addpath(fullfile(pwd,'Exercise1_ObstacleAvoidance'));
    addpath(genpath('Exercise1_ObstacleAvoidance'));
    addpath(fullfile(pwd,'Exercise2_DetectFire'));
    addpath(genpath('Exercise2_DetectFire'));
    addpath(fullfile(pwd,'Exercise3_BurnAnalysisUsingHyperspectralImage'));
    addpath(genpath('Exercise3_BurnAnalysisUsingHyperspectralImage'));
    % These lines initialize the Simulink model for Exercise 1
    load_system('ObstacleAvoidanceDemo.slx');
    %bdclose('ObstacleAvoidanceDemo.slx');
    fprintf('\nEnvironment Check is Complete!\n');
    fprintf('\nEnjoy the workshop!\n');
end
