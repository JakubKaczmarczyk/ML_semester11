function [X,Y] = ReadData(n)
    S = load('PCA_data.mat');
    Xfield = sprintf('X%d', n);
    Yfield = sprintf('Y%d', n);
    X = S.(Xfield);
    Y = S.(Yfield);
end