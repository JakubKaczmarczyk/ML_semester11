function PlotBoundry(X,Y,Theta,mu,sig)
    hold on;
    x1_unique = unique(X(1, :));
    x2_unique = unique(X(2, :));
    [X1grid, X2grid] = meshgrid(x1_unique, x2_unique);
    Ygrid = griddata(X(1, :), X(2, :), Y, X1grid, X2grid, 'linear');
    contour(X1grid, X2grid, Ygrid, [0.5 0.5], 'k', 'LineWidth', 2);
    hold off;
end