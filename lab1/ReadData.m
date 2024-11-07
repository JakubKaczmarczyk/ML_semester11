function [X,Y] = ReadData()
    S = load('LC_data.mat');
    X = S.X;
    Y = S.Fm;
end