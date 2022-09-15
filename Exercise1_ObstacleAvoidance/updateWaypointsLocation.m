function updateWaypointsLocation(ax, data, sceneData)

sceneData.WaypointsXY(end+1, :) = data.IntersectionPoint(1:2);
delete(findobj(ax, 'tag', 'WaypointLine'));
hold(ax, 'on')
line = plot(ax, sceneData.WaypointsXY(:, 1), sceneData.WaypointsXY(:,2), '--kx');
line.Tag = 'WaypointLine';
hold(ax, 'off')
end