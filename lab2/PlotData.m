function PlotData(X,Y)
    % figure;
    hold on;
    scatter(X(1, Y < 0.5), X(2, Y < 0.5), 50, 'ro', 'filled');
    scatter(X(1, Y >= 0.5), X(2, Y >= 0.5), 50, 'bs', 'filled');
    
    hold off;
end