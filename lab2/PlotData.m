function PlotData(X,Y)
    figure;
    hold on;
    scatter(X(1, Y < 0.5), X(2, Y < 0.5), 50, 'ro', 'filled');
    scatter(X(1, Y >= 0.5), X(2, Y >= 0.5), 50, 'bs', 'filled');
    Yresized = resize(Y,[23,27]);
    contour(unique(X(1,:)),unique(X(2,:)),Yresized,[0.5,0.5]);
    hold off;
end