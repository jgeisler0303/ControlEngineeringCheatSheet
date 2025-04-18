function [ax, ay]= annotCoords(x, y)
set(gcf, 'Units', 'normalized')
axPos = get(gca, 'Position');
xLimits = xlim;
yLimits = ylim;

% Convert x, y data coordinates to normalized figure coordinates
ax(1) = axPos(1) + (x(1) - xLimits(1)) / diff(xLimits) * axPos(3);
ay(1) = axPos(2) + (y(1) - yLimits(1)) / diff(yLimits) * axPos(4);
ax(2)   = axPos(1) + (x(2) - xLimits(1)) / diff(xLimits) * axPos(3);
ay(2)   = axPos(2) + (y(2) - yLimits(1)) / diff(yLimits) * axPos(4);
end