function updateObstacleLocation(ax, data, sceneData)

sceneData.ObstacleXY(end+1, :) = data.IntersectionPoint(1:2);
alpha = linspace(0, 2*pi, 20);
circle = 1*[cos(alpha') sin(alpha')]+sceneData.ObstacleXY(end, :);
hold(ax, 'on')
plot(ax, circle(:,1), circle(:,2));
hold(ax, 'off')
end